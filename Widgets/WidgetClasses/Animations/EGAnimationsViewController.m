//
//  EGAnimationsViewController.m
//  Widgets
//
//  Created by EG on 2017/9/15.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGAnimationsViewController.h"

@interface EGAnimationsViewController ()

@end

@implementation EGAnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datasArray = @[
                        @"EGPropertyAnimationViewController",
                        @"EGObviousPropertyViewController",
                        @"EGKVCPropertyAnimationViewController",
                        @"EGKeyAnimationViewController",
                        @"EGVirtualAnimationViewController",
                        @"EGGroupAnimationViewController"
                        ];
}

@end
