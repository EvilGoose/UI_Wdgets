//
//  ViewController.m
//  Widgets
//
//  Created by EG on 2017/8/4.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
 
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"EG_WIDGETS";
    // Do any additional setup after loading the view, typically from a nib.
    self.datasArray = @[
                        @"EGTestViewController",
                        @"EGSeperateScrollViewController",
                        @"EGIndicatorViewController",
                        @"EGNaviBarViewController",
                        @"EGImageSizeViewController",
                        @"EGWaveViewController",
                        @"EGSocketController",
                        @"EGLayerUsageController",
                        @"EGAudio_VideoController",
                        @"EGAnimationsViewController",
                        @"EGDispatchViewController",
                        @"EGGuesturesViewController",
                        @"EGDataReloadViewController"
    ];
}

@end
