//
//  EGMicroPhoneHelper.m
//  Widgets
//
//  Created by EG on 2017/8/28.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGMicroPhoneHelper.h"

@interface EGMicroPhoneHelper()

/**录音设置*/
@property (strong, nonatomic)NSDictionary *audioRecordingSettings;

/**录音器*/
@property (strong, nonatomic)AVAudioRecorder *recorder;

/**播放器*/
@property (strong, nonatomic)AVAudioPlayer *player;

/**事务处理*/
@property (strong, nonatomic)AVAudioSession *session;

/**文件路径*/
@property (copy, nonatomic)NSString *filePath;

@end

@implementation EGMicroPhoneHelper

SINGLETON_IMPLEMENTATION(EGMicroPhoneHelper)

- (void)startRecordToPath:(NSString *)path {    
    self.filePath = path;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if (session == nil) {
        NSLog(@"无法创建事务: %@",[sessionError description]);
    }else{
        [session setActive:YES error:nil];
    }
    
        //创建记录者
    self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:path]
                                                settings:self.audioRecordingSettings error:nil];
    
    if (self.recorder) {
        self.recorder.meteringEnabled = YES;//刷新电平
        [self.recorder prepareToRecord];
        [self.recorder record];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self finishRecord];
        });
    }else{
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
    }
}

- (void)pauseRecord {
    [self.player pause];
}

- (void)finishRecord {
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:self.filePath]){
        NSLog(@"不能找到对应文件");
    }
}

- (void)playRecorder:(NSString *)URLString {
    [self.recorder stop];

    if ([self.player isPlaying]) return;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:URLString] error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    [self.player play];
    
    NSLog(@"%li",self.player.data.length/1024);
}


- (NSDictionary *)audioRecordingSettings{
    if (!_audioRecordingSettings) {
        
        NSMutableDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                       [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                       // 音频格式
                                       [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                       //采样位数  8、16、24、32 默认为16
                                       [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                       // 音频通道数 1 或 2
                                       [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                       //录音质量
                                       [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                       nil];

//        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		//设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
//		[dict setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
//      [dict setValue:[NSNumber numberWithInt: kAudioFormatLinearPCM] forKey:AVFormatIDKey];
//        [dict setValue:[NSNumber numberWithInt:kAudioFormatMPEGLayer3] forKey:AVFormatIDKey];
//        
//            //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
//        [dict setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
//            //录音通道数  1 或 2
//        [dict setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
//            //线性采样位数  8、16、24、32
//        [dict setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
//            //录音的质量
//        [dict setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
        
        _audioRecordingSettings = [NSDictionary dictionaryWithDictionary:dict];
    }
    return _audioRecordingSettings;
}


@end
