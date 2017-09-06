
    //
//  EGVideoCaptureViewController.m
//  Widgets
//
//  Created by EG on 2017/8/31.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGVideoCaptureViewController.h"
#import <VideoToolbox/VideoToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <GCDAsyncSocket.h>

#import "MBProgressHUD+Extension.h"

#import "EGOpenGLView.h"
#import "EGOpenGLLayer.h"

#define FILE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test.h264"]

@interface EGVideoCaptureViewController ()
<AVCaptureVideoDataOutputSampleBufferDelegate,
GCDAsyncSocketDelegate>
{
    dispatch_queue_t captureQueue;
    dispatch_queue_t encodeQueue;
    NSFileHandle *fileHandle;
    VTCompressionSessionRef EncodingSession;
    int frameID;
 
    dispatch_queue_t mDecodeQueue;
    VTDecompressionSessionRef mDecodeSession;
    CMFormatDescriptionRef  mFormatDescription;
    uint8_t *mSPS;
    long mSPSSize;
    uint8_t *mPPS;
    long mPPSSize;
    
    NSInputStream *inputStream;
    uint8_t*       inputBuffer;
    long           inputSize;
    long           inputMaxSize;
    
    uint8_t*       packetBuffer;
    long           packetSize;

    GCDAsyncSocket *_socket;
}
@property (nonatomic, strong) AVCaptureSession *captureSession; //负责输入和输出设备之间的数据传递

@property (nonatomic, strong) AVCaptureDeviceInput *captureDeviceInput;//负责从AVCaptureDevice获得输入数据

@property (nonatomic, strong) AVCaptureVideoDataOutput *captureDataOutput;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *capturePreviewLayer;

@property (nonatomic , weak) IBOutlet EGOpenGLView *mOpenGLView;

/**EGOpenGLLayer*/
@property (nonatomic , strong) EGOpenGLLayer *displayLayer;

@property (nonatomic , strong) CADisplayLink *mDispalyLink;

@end

const uint8_t lyStartCode[4] = {0, 0, 0, 1};

@implementation EGVideoCaptureViewController

#pragma mark - life cycle
    //OpenGL 相关
    //http://www.cocoachina.com/ios/20151123/14116.html
    //http://www.cocoachina.com/game/20141127/10335.html

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.mOpenGLView.layer addSublayer:self.displayLayer];//use a layer
    
    [self.mOpenGLView setupGL];//use g
    
    mDecodeQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.mDispalyLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateFrame)];
    [self.mDispalyLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.mDispalyLink setPaused:YES];
}

- (IBAction)socketBuildAction:(UIButton *)sender {
    _socket =
    [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
        //连接
    NSError *error = nil;
    
    [_socket acceptOnPort:2347 error:&error];
    
     if (error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             [MBProgressHUD showError:@"无法建立socket链接"];
         });
    }
    
    [_socket readDataWithTimeout:-1 tag:0];

}

- (IBAction)capture:(UIButton *)sender {
    [self startCapture];
}

- (IBAction)stopClick:(UIButton *)sender {
    [self stopCapture];
}

- (IBAction)play:(UIButton *)sender {
    [self onInputStart];
    [self.mDispalyLink setPaused:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopClick:nil];
}

#pragma mark - Capture actions

- (void)startCapture {
    self.captureSession = [[AVCaptureSession alloc] init];
    self.captureSession.sessionPreset = AVCaptureSessionPreset640x480;
    
    encodeQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    captureQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    AVCaptureDevice *inputCamera = nil;
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionBack) {
            inputCamera = device;
        }
    }
    
    self.captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:inputCamera error:nil];
    
    if ([self.captureSession canAddInput:self.captureDeviceInput]) {
        [self.captureSession addInput:self.captureDeviceInput];
    }
    
    self.captureDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [self.captureDataOutput setAlwaysDiscardsLateVideoFrames:NO];
    
    [self.captureDataOutput
     setVideoSettings:
     [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]
	forKey:(id)
      kCVPixelBufferPixelFormatTypeKey]];
    
    [self.captureDataOutput setSampleBufferDelegate:self queue:captureQueue];
    
    if ([self.captureSession canAddOutput:self.captureDataOutput]) {
        [self.captureSession addOutput:self.captureDataOutput];
    }
    
    AVCaptureConnection *connection = [self.captureDataOutput connectionWithMediaType:AVMediaTypeVideo];
    [connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    
    self.capturePreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.capturePreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    [self.capturePreviewLayer setFrame:self.mOpenGLView.frame];
    [self.view.layer addSublayer:self.capturePreviewLayer];
    
    [[NSFileManager defaultManager] removeItemAtPath:FILE_PATH error:nil];
    [[NSFileManager defaultManager] createFileAtPath:FILE_PATH contents:nil attributes:nil];
    
    fileHandle = [NSFileHandle fileHandleForWritingAtPath:FILE_PATH];
    
    [self initVideoToolBox];
    [self.captureSession startRunning];
 }

- (void)initVideoToolBox {
    frameID = 0;
    dispatch_sync(encodeQueue, ^{
        int width = SCREEN_HEIGHT < SCREEN_WIDTH ?  SCREEN_HEIGHT : SCREEN_WIDTH;
        int height = SCREEN_HEIGHT > SCREEN_WIDTH ?  SCREEN_HEIGHT : SCREEN_WIDTH;
        OSStatus status = VTCompressionSessionCreate(NULL,
                                                     width,
                                                     height,
                                                     kCMVideoCodecType_H264,
                                                     NULL,
                                                     NULL,
                                                     NULL,
                                                     didCompressH264,
                                                     (__bridge void *)(self),
                                                     &EncodingSession
                                                     );
        
        NSLog(@"H264: VTCompressionSessionCreate %d", (int)status);
        if (status != 0)
          {
            NSLog(@"H264: Unable to create a H264 session");
            return ;
          }
        
            // 设置实时编码输出（避免延迟）
        VTSessionSetProperty(EncodingSession, kVTCompressionPropertyKey_RealTime, kCFBooleanTrue);
            // h264 profile, 直播一般使用baseline，可减少由于b帧带来的延时
        VTSessionSetProperty(EncodingSession, kVTCompressionPropertyKey_ProfileLevel, kVTProfileLevel_H264_Baseline_AutoLevel);
        
            // 设置关键帧（GOPsize)间隔
        int frameInterval = 10;
        CFNumberRef  frameIntervalRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &frameInterval);
        VTSessionSetProperty(EncodingSession, kVTCompressionPropertyKey_MaxKeyFrameInterval, frameIntervalRef);
        
            // 设置期望帧率
        int fps = 10;
        CFNumberRef fpsRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &fps);
        VTSessionSetProperty(EncodingSession, kVTCompressionPropertyKey_ExpectedFrameRate, fpsRef);
        
        
            // 设置编码码率(比特率)，如果不设置，默认将会以很低的码率编码，导致编码出来的视频很模糊
            // 设置码率，上限，单位是bps
        int bitRate = width * height * 3 * 4 * 8;
        CFNumberRef bitRateRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &bitRate);
        VTSessionSetProperty(EncodingSession, kVTCompressionPropertyKey_AverageBitRate, bitRateRef);
            // 设置码率，均值，单位是byte
        int bitRateLimit = width * height * 3 * 4;
        CFNumberRef bitRateLimitRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &bitRateLimit);
        VTSessionSetProperty(EncodingSession, kVTCompressionPropertyKey_DataRateLimits, bitRateLimitRef);
        
            // Tell the encoder to start encoding
        VTCompressionSessionPrepareToEncodeFrames(EncodingSession);
        
    });
    
}

void didCompressH264(void *outputCallbackRefCon, void *sourceFrameRefCon, OSStatus status, VTEncodeInfoFlags infoFlags, CMSampleBufferRef sampleBuffer) {
    NSLog(@"didCompressH264 called with status %d infoFlags %d", (int)status, (int)infoFlags);
    if (status != 0) {
        return;
    }
    
    if (!CMSampleBufferDataIsReady(sampleBuffer)) {
        NSLog(@"didCompressH264 data is not ready ");
        return;
    }
    EGVideoCaptureViewController* encoder = (__bridge EGVideoCaptureViewController *)outputCallbackRefCon;
    
    bool keyframe = !CFDictionaryContainsKey( (CFArrayGetValueAtIndex(CMSampleBufferGetSampleAttachmentsArray(sampleBuffer, true), 0)), kCMSampleAttachmentKey_NotSync);
        // 判断当前帧是否为关键帧
        // 获取sps & pps数据
    if (keyframe)
      {
        CMFormatDescriptionRef format = CMSampleBufferGetFormatDescription(sampleBuffer);
        size_t spsSize, spsCount;
        const uint8_t *sparameterSet;
        OSStatus statusCode = CMVideoFormatDescriptionGetH264ParameterSetAtIndex(format, 0, &sparameterSet, &spsSize, &spsCount, 0 );
        if (statusCode == noErr)
          {
                // Found sps and now check for pps
            size_t ppsSize, ppsCount;
            const uint8_t *pparameterSet;
            OSStatus statusCode = CMVideoFormatDescriptionGetH264ParameterSetAtIndex(format, 1, &pparameterSet, &ppsSize, &ppsCount, 0 );
            if (statusCode == noErr)
              {
                    // Found pps
                NSData *sps = [NSData dataWithBytes:sparameterSet length:spsSize];
                NSData *pps = [NSData dataWithBytes:pparameterSet length:ppsSize];
                if (encoder)
                  {
                    [encoder gotSpsPps:sps pps:pps];
                  }
              }
          }
      }
    
    CMBlockBufferRef dataBuffer = CMSampleBufferGetDataBuffer(sampleBuffer);
    size_t length, totalLength;
    char *dataPointer;
    OSStatus statusCodeRet = CMBlockBufferGetDataPointer(dataBuffer, 0, &length, &totalLength, &dataPointer);
    if (statusCodeRet == noErr) {
        size_t bufferOffset = 0;
        static const int AVCCHeaderLength = 4; // 返回的nalu数据前四个字节不是0001的startcode，而是大端模式的帧长度length
        
            // 循环获取nalu数据
        while (bufferOffset < totalLength - AVCCHeaderLength) {
            uint32_t NALUnitLength = 0;
                // Read the NAL unit length
            memcpy(&NALUnitLength, dataPointer + bufferOffset, AVCCHeaderLength);
            
                // 从大端转系统端
            NALUnitLength = CFSwapInt32BigToHost(NALUnitLength);
            
            NSData* data = [[NSData alloc] initWithBytes:(dataPointer + bufferOffset + AVCCHeaderLength) length:NALUnitLength];
            [encoder gotEncodedData:data isKeyFrame:keyframe];
            
                // Move to the next NAL unit in the block buffer
            bufferOffset += AVCCHeaderLength + NALUnitLength;
        }
    }
}

- (void)gotSpsPps:(NSData *)sps pps:(NSData *)pps {
    NSLog(@"gotSpsPps %d %d", (int)[sps length], (int)[pps length]);
    const char bytes[] = "\x00\x00\x00\x01";
    NSData *ByteHeader = [NSData dataWithBytes:bytes length:4];
    [fileHandle writeData:ByteHeader];
    [fileHandle writeData:sps];
    [fileHandle writeData:ByteHeader];
    [fileHandle writeData:pps];
    
}

- (void)gotEncodedData:(NSData*)data isKeyFrame:(BOOL)isKeyFrame {
    NSLog(@"gotEncodedData %d", (int)[data length]);
    if (fileHandle != NULL)
      {
        const char bytes[] = "\x00\x00\x00\x01";
        size_t length = (sizeof bytes) - 1; //string literals have implicit trailing '\0'
        NSData *ByteHeader = [NSData dataWithBytes:bytes length:length];
        [fileHandle writeData:ByteHeader];
        [fileHandle writeData:data];
      }
}

- (void)stopCapture {
    [self.captureSession stopRunning];
    [self EndVideoToolBox];
    [fileHandle closeFile];
    [self.capturePreviewLayer removeFromSuperlayer];
    fileHandle = NULL;
}

- (void)EndVideoToolBox {
    VTCompressionSessionCompleteFrames(EncodingSession, kCMTimeInvalid);
    VTCompressionSessionInvalidate(EncodingSession);
    CFRelease(EncodingSession);
    EncodingSession = NULL;
}

#pragma mark - delegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    dispatch_sync(encodeQueue, ^{
        CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
            // 帧时间，如果不设置会导致时间轴过长。
        CMTime presentationTimeStamp = CMTimeMake(frameID++, 1000);
        VTEncodeInfoFlags flags;
        OSStatus statusCode = VTCompressionSessionEncodeFrame(EncodingSession,
                                                              imageBuffer,
                                                              presentationTimeStamp,
                                                              kCMTimeInvalid,
                                                              NULL, NULL, &flags);
        if (statusCode != noErr) {
            NSLog(@"H264: VTCompressionSessionEncodeFrame failed with %d", (int)statusCode);
            
            VTCompressionSessionInvalidate(EncodingSession);
            CFRelease(EncodingSession);
            EncodingSession = NULL;
            return;
        }
        NSLog(@"H264: VTCompressionSessionEncodeFrame Success");
    });
}

#pragma mark - decode action

void didDecompress(void *decompressionOutputRefCon, void *sourceFrameRefCon, OSStatus status, VTDecodeInfoFlags infoFlags, CVImageBufferRef pixelBuffer, CMTime presentationTimeStamp, CMTime presentationDuration ) {
    CVPixelBufferRef *outputPixelBuffer = (CVPixelBufferRef *)sourceFrameRefCon;
    *outputPixelBuffer = CVPixelBufferRetain(pixelBuffer);
}

- (void)onInputStart {
    
//    NSString *mtvPath = [[NSBundle mainBundle] pathForResource:@"mtv" ofType:@"h264"];
    
    inputStream = [[NSInputStream alloc] initWithFileAtPath:FILE_PATH];
    [inputStream open];
    inputSize = 0;
    inputMaxSize = self.mOpenGLView.height * self.mOpenGLView.width * 9 * 16;
    inputBuffer = malloc(inputMaxSize);
}
	
- (void)onInputEnd {
    [inputStream close];
    inputStream = nil;
    if (inputBuffer) {
        free(inputBuffer);
        inputBuffer = NULL;
    }
    [self.mDispalyLink setPaused:YES];
}

- (void)updateFrame {
    if (inputStream) {
        dispatch_sync(mDecodeQueue, ^{
            [self readPacket];
            if (packetBuffer == NULL || packetSize == 0) {
                [self onInputEnd];
                return;
            }
            
                //大小端转换
            uint32_t nalSize = (uint32_t)(packetSize - 4);
            uint32_t *pNalSize = (uint32_t *)packetBuffer;
            *pNalSize = CFSwapInt32HostToBig(nalSize);
            
            CVPixelBufferRef pixelBuffer = NULL;
            int nalType = packetBuffer[4] & 0x1f;
            switch (nalType) {
                case 0x05:
                    NSLog(@"Nal type is IDR frame");
                    [self setUpVideoToolBox];
                    pixelBuffer = [self decode];
                    break;
                case 0x07:
                    NSLog(@"Nal type is SPS");
                    [self shutDownVideoToolBox];
                    mSPSSize = packetSize - 4;
                    mSPS = malloc(mSPSSize);
                    memcpy(mSPS, packetBuffer + 4, mSPSSize);
                    break;
                case 0x08:
                    NSLog(@"Nal type is PPS");
                    mPPSSize = packetSize - 4;
                    mPPS = malloc(mPPSSize);
                    memcpy(mPPS, packetBuffer + 4, mPPSSize);
                    break;
                case 0x01:// P
                    NSLog(@"Nal type is P");
                    pixelBuffer = [self decode];
                    break;
                case 0x06: // SEI
                    NSLog(@"Nal type is SEI");
                    pixelBuffer = [self decode];
                 	break;
                default:
                    NSLog(@"Nal type is B/P frame");
                    pixelBuffer = [self decode];
                    break;
            }
            
            if(pixelBuffer) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                        //TODO: -- Layer Test
                    
//                    [self.mOpenGLView displayPixelBuffer:pixelBuffer];
                    self.displayLayer.pixelBuffer = pixelBuffer;
                    CVPixelBufferRelease(pixelBuffer);
                });
            }
            NSLog(@"Read Nalu size %ld", packetSize);
            
        });
    }
}

- (void)readPacket {
    if (packetSize && packetBuffer) {
        packetSize = 0;
        free(packetBuffer);
        packetBuffer = NULL;
    }
    if (inputSize < inputMaxSize && inputStream.hasBytesAvailable) {
        inputSize += [inputStream read:inputBuffer + inputSize maxLength:inputMaxSize - inputSize];
    }
    if (memcmp(inputBuffer, lyStartCode, 4) == 0) {
        if (inputSize > 4) { // 除了开始码还有内容
            uint8_t *pStart = inputBuffer + 4;
            uint8_t *pEnd = inputBuffer + inputSize;
            while (pStart != pEnd) { //这里使用一种简略的方式来获取这一帧的长度：通过查找下一个0x00000001来确定。
                if(memcmp(pStart - 3, lyStartCode, 4) == 0) {
                    packetSize = pStart - inputBuffer - 3;
                    if (packetBuffer) {
                        free(packetBuffer);
                        packetBuffer = NULL;
                    }
                    packetBuffer = malloc(packetSize);
                    memcpy(packetBuffer, inputBuffer, packetSize); //复制packet内容到新的缓冲区
                    memmove(inputBuffer, inputBuffer + packetSize, inputSize - packetSize); //把缓冲区前移
                    inputSize -= packetSize;
                    break;
                }
                else {
                    ++pStart;
                }
            }
        }
    }
}

- (void)setUpVideoToolBox {
    if (!mDecodeSession) {
        const uint8_t* parameterSetPointers[2] = {mSPS, mPPS};
        const size_t parameterSetSizes[2] = {mSPSSize, mPPSSize};
        OSStatus status = CMVideoFormatDescriptionCreateFromH264ParameterSets(kCFAllocatorDefault,
                                                                              2, //param count
                                                                              parameterSetPointers,
                                                                              parameterSetSizes,
                                                                              4, //nal start code size
                                                                              &mFormatDescription);
        
        BOOL canAccept = VTDecompressionSessionCanAcceptFormatDescription(mDecodeSession, mFormatDescription);
        if (!canAccept) {
            if(status == noErr) {
                
                CFDictionaryRef attrs = NULL;
                const void *keys[] = { kCVPixelBufferPixelFormatTypeKey };
                    //      kCVPixelFormatType_420YpCbCr8Planar is YUV420
                    //      kCVPixelFormatType_420YpCbCr8BiPlanarFullRange is NV12
                uint32_t v = kCVPixelFormatType_420YpCbCr8BiPlanarFullRange;
                const void *values[] = { CFNumberCreate(NULL, kCFNumberSInt32Type, &v) };
                attrs = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
                
                VTDecompressionOutputCallbackRecord callBackRecord;
                callBackRecord.decompressionOutputCallback = didDecompress;
                callBackRecord.decompressionOutputRefCon = NULL;
                
                status = VTDecompressionSessionCreate(kCFAllocatorDefault,
                                                      mFormatDescription,
                                                      NULL, attrs,
                                                      &callBackRecord,
                                                      &mDecodeSession);
                CFRelease(attrs);
            } else {
                NSLog(@"iOS VT: reset decoder session failed status=%d", status);
            }
        }
    }
    
}

-(CVPixelBufferRef)decode {
    
    CVPixelBufferRef outputPixelBuffer = NULL;
    if (mDecodeSession) {
        CMBlockBufferRef blockBuffer = NULL;
        OSStatus status  = CMBlockBufferCreateWithMemoryBlock(kCFAllocatorDefault,
                                                              (void*)packetBuffer,
                                                              packetSize,
                                                              kCFAllocatorNull,
                                                              NULL,
                                                              0,
                                                              packetSize,
                                                              0,
                                                              &blockBuffer);
        if(status == kCMBlockBufferNoErr) {
            CMSampleBufferRef sampleBuffer = NULL;
            const size_t sampleSizeArray[] = {packetSize};
            status = CMSampleBufferCreateReady(kCFAllocatorDefault,
                                               blockBuffer,
                                               mFormatDescription,
                                               1,
                                               0,
                                               NULL,
                                               1,
                                               sampleSizeArray,
                                               &sampleBuffer);
            
            if (status == kCMBlockBufferNoErr && sampleBuffer) {
                VTDecodeFrameFlags flags = 0;
                VTDecodeInfoFlags flagOut = 0;
                    // 默认是同步操作。
                    // 调用didDecompress，返回后再回调
                OSStatus decodeStatus = VTDecompressionSessionDecodeFrame(mDecodeSession,
                                                                          sampleBuffer,
                                                                          flags,
                                                                          &outputPixelBuffer,
                                                                          &flagOut);
                
                if(decodeStatus == kVTInvalidSessionErr) {
                    NSLog(@"iOS VT: Invalid session, reset decoder session");
                } else if(decodeStatus == kVTVideoDecoderBadDataErr) {
                    NSLog(@"iOS VT: decode failed status=%d(Bad data)", (int)decodeStatus);
                } else if(decodeStatus != noErr) {
                    NSLog(@"iOS VT: decode failed status=%d", (int)decodeStatus);
                }
                 CFRelease(sampleBuffer);
            }
            CFRelease(blockBuffer);
        }
    }
    
    return outputPixelBuffer;
}

- (void)shutDownVideoToolBox {
    if(mDecodeSession) {
        VTDecompressionSessionInvalidate(mDecodeSession);
        CFRelease(mDecodeSession);
        mDecodeSession = NULL;
    }
    
    if(mFormatDescription) {
        CFRelease(mFormatDescription);
        mFormatDescription = NULL;
    }
    
    free(mSPS);
    free(mPPS);
    mSPSSize = mPPSSize = 0;
}

- (EGOpenGLLayer *)displayLayer {
    if (!_displayLayer) {
        _displayLayer = [[EGOpenGLLayer alloc]initWithFrame:self.mOpenGLView.bounds];
    }
    return _displayLayer;
}
#pragma mark - delegate
    //连接成功
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showError:@"成功建立socket链接"];
    });
}

    //断开连接
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (err) {
            
         }else{
             
         }
    });
}

    //读取数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
}

@end
