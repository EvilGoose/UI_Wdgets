//
//  EGMixAudioViewController.m
//  Widgets
//
//  Created by EG on 2017/8/30.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGMixAudioViewController.h"
#import <AVFoundation/AVFoundation.h>

/**
 三个核心类
 AVMutableComposition: 用于对音视频轨道的添加和删除
 AVMutableCompositionTrack: 代表着一个音频/视频 的轨道,可以添加音频/视频资源
 AVAssetExportSession:用于导出处理后的音视频文件.
 
 */
@interface EGMixAudioViewController ()

@end

@implementation EGMixAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)playAction:(UIButton *)sender {
    AVMutableComposition *compostion = [AVMutableComposition composition];
    
    AVMutableCompositionTrack *audio1 = [compostion addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
    
//    AVMutableCompositionTrack *audio2 = [compostion addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:1];
    
    CMTime beginTime = kCMTimeZero;
    NSError *error = nil;
    
    NSURL *audio1URL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"Audio1" ofType:@"m4a"]];
    NSURL *audio2URL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"Audio2" ofType:@"mp3"]];
//    NSURL *audio3URL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"Audio3" ofType:@"m4a"]];
    
    
    AVURLAsset  *audioAsset1 = [[AVURLAsset alloc]initWithURL:audio1URL options:nil];
    AVURLAsset  *audioAsset2 = [[AVURLAsset alloc]initWithURL:audio2URL options:nil];
//    AVURLAsset  *audioAsset3 = [[AVURLAsset alloc]initWithURL:audio3URL options:nil];

    CMTimeRange audio_timeRange1 = CMTimeRangeMake(kCMTimeZero, audioAsset1.duration);
    CMTimeRange audio_timeRange2 = CMTimeRangeMake(kCMTimeZero, audioAsset2.duration);
//    CMTimeRange audio_timeRange3 = CMTimeRangeMake(kCMTimeZero, audioAsset3.duration);
 
    BOOL mark = [audio1 insertTimeRange:audio_timeRange2
                                ofTrack:audio1
                                 atTime:beginTime
                                  error:&error];
    
    if (!mark) {
        NSLog(@"插入音频失败: %@",error);
        return;
    }
    
    AVAssetExportSession* assetExport = [[AVAssetExportSession alloc] initWithAsset:compostion
                                                                         presetName:AVAssetExportPresetAppleM4A];
        //  4.2 设置导入音视频的URL
    assetExport.outputURL = [NSURL URLWithString:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
                                                  stringByAppendingString:@"result"]];
        //  导出音视频的文件格式
    assetExport.outputFileType = @"com.apple.m4a";
        //  4.3 导入出
    [assetExport exportAsynchronouslyWithCompletionHandler:^{
            //      4.5 分发到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
 
        });
    }];
 
    
}

- (IBAction)mixAction:(UIButton *)sender {

}


@end
