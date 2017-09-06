//
//  EGMixAudioVideoViewController.m
//  Widgets
//
//  Created by EG on 2017/8/28.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGMixAudioVideoViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface EGMixAudioVideoViewController ()

/**Mix*/
@property (strong, nonatomic)UIButton *mixButton;

/**Origin Video*/
@property (strong, nonatomic)UIButton *originVideButton;

/**Pause*/
@property (strong, nonatomic)UIButton *pauseButton;

/**Play Image*/
@property (strong, nonatomic)UIImageView *imageView;

/**Player*/
@property (weak, nonatomic)AVPlayer *player;

@end

@implementation EGMixAudioVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.originVideButton];
    [self.view addSubview:self.pauseButton];
    [self.view addSubview:self.mixButton];
}


- (void)mix {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
            // 路径
        NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
            // 声音来源
        NSURL *audioInputUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                       pathForResource:@"Audio3"
                                                       ofType:@"m4a"]];
            // 视频来源
        NSURL *videoInputUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                       pathForResource:@"Movie"
                                                       ofType:@"mp4"]];
            // 最终合成输出路径
        NSString *outPutFilePath = [documents stringByAppendingPathComponent:@"merge.mp4"];
        
            // 添加合成路径
        NSURL *outputFileUrl = [NSURL fileURLWithPath:outPutFilePath];
        
             // 时间起点
        CMTime nextClistartTime = kCMTimeZero;
        
            // 创建可变的音视频组合
        AVMutableComposition *comosition = [AVMutableComposition composition];
        
            // 视频采集
        AVURLAsset *videoAsset = [[AVURLAsset alloc] initWithURL:videoInputUrl options:nil];
        
            // 视频时间范围
        CMTimeRange videoTimeRange = CMTimeRangeMake(kCMTimeZero, videoAsset.duration);
        
            // 视频通道 枚举 kCMPersistentTrackID_Invalid = 0
        AVMutableCompositionTrack *videoTrack = [comosition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
        
            // 视频采集通道
        AVAssetTrack *videoAssetTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo] firstObject];
        
            //  把采集轨道数据加入到可变轨道之中
        [videoTrack insertTimeRange:videoTimeRange
                            ofTrack:videoAssetTrack
                             atTime:nextClistartTime
                              error:nil];
        
        
            // 声音采集
        AVURLAsset *audioAsset = [[AVURLAsset alloc] initWithURL:audioInputUrl options:nil];
        
            // 因为视频短这里就直接用视频长度了,如果自动化需要自己写判断
        CMTimeRange audioTimeRange = videoTimeRange;
        
            // 音频通道
        AVMutableCompositionTrack *audioTrack = [comosition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
        
            // 音频采集通道
        AVAssetTrack *audioAssetTrack = [[audioAsset tracksWithMediaType:AVMediaTypeAudio] firstObject];
        
            // 加入合成轨道之中
        [audioTrack insertTimeRange:audioTimeRange
                            ofTrack:audioAssetTrack
                             atTime:nextClistartTime error:nil];
        
            // 创建一个输出
        AVAssetExportSession *assetExport = [[AVAssetExportSession alloc]
                                             initWithAsset:comosition
                                             presetName:AVAssetExportPresetMediumQuality];
        
            // 输出类型
        assetExport.outputFileType = AVFileTypeQuickTimeMovie;
        
            // 输出地址
        assetExport.outputURL = outputFileUrl;
        
            // 优化
        assetExport.shouldOptimizeForNetworkUse = YES;
        
            // 合成完毕
        [assetExport exportAsynchronouslyWithCompletionHandler:^{
                // 回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                    // 调用播放方法
                [self playResource:outputFileUrl];
            });
        }];
    });
	
}

- (void)playResource:(NSURL *)URL {
        // 传入地址
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:URL];
        // 播放器
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    
        // 播放器layer
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
        // 添加到imageview的layer上
    [self.imageView.layer addSublayer:playerLayer];
    playerLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH - 20, SCREEN_HEIGHT * .5);
    
        // 视频填充模式
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
        // 播放
    [player play];
    
    self.player = player;
}

- (void)originPlay {
    [self playResource:[NSURL fileURLWithPath:[[NSBundle mainBundle]
                                               pathForResource:@"Movie"
                                               ofType:@"mp4"]]];
}

- (void)pausePlayer {
    [self.player pause];
}

#pragma mark - lazy

- (UIButton *)originVideButton {
    if (!_originVideButton) {
        _originVideButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _originVideButton.backgroundColor = [UIColor darkGrayColor];
        [_originVideButton setTitle:@"PlayOrigin" forState:UIControlStateNormal];
        [_originVideButton addTarget:self action:@selector(originPlay) forControlEvents:UIControlEventTouchUpInside];
        _originVideButton.frame = CGRectMake(40, SCREEN_HEIGHT * .65 + 20, SCREEN_WIDTH - 80, SCREEN_HEIGHT * .1 - 20);
    }
    return _originVideButton;
}

- (UIButton *)pauseButton {
    if (!_pauseButton) {
        _pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _pauseButton.backgroundColor = [UIColor darkGrayColor];
        [_pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        [_pauseButton addTarget:self action:@selector(pausePlayer) forControlEvents:UIControlEventTouchUpInside];
        _pauseButton.frame = CGRectMake(40, SCREEN_HEIGHT * .75 + 20, SCREEN_WIDTH - 80, SCREEN_HEIGHT * .1 - 20);
    }
    return _pauseButton;
}

- (UIButton *)mixButton {
    if (!_mixButton) {
        _mixButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _mixButton.backgroundColor = [UIColor darkGrayColor];
        [_mixButton setTitle:@"MixAndPlay" forState:UIControlStateNormal];
        [_mixButton addTarget:self action:@selector(mix) forControlEvents:UIControlEventTouchUpInside];
        _mixButton.frame = CGRectMake(40, SCREEN_HEIGHT * .85 + 20, SCREEN_WIDTH - 80, SCREEN_HEIGHT * .1 - 20);
    }
    return _mixButton;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, SCREEN_WIDTH - 20, SCREEN_HEIGHT * .5)];
        _imageView.backgroundColor = [UIColor blackColor];
    }
    return _imageView;
}


@end
