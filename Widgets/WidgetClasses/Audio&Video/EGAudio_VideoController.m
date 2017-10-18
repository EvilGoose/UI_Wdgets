//
//  EGAudio_VideoController.h.m
//  Widgets
//
//  Created by EG on 2017/9/6.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGAudio_VideoController.h"

@implementation EGAudio_VideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datasArray = @[
                        @"EGAVPlayerViewController",
                        @"EGMicroPhoneViewController",
                        @"EGVideoCaptureViewController",
                        @"EGMixAudioViewController",
                        @"EGMixVideoViewController",
                        @"EGMixAudioVideoViewController",
                        @"EGFFMPEGViewController",
                        @"EGComprehensiveController"
                        ];
}

@end
