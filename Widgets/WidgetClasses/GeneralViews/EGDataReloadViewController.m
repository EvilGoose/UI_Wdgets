//
//  EGDataReloadViewController.m
//  Widgets
//
//  Created by FangViee on 2017/10/31.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGDataReloadViewController.h"

@interface EGDataReloadViewController ()

@end

@implementation EGDataReloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) weakSelf =  self;
    self.selectedFeedBack = ^(NSIndexPath *index) {
        [weakSelf reloadData];
    };
}



- (NSArray *)datasArray {
    return @[
             @"hello_0",
             @"hello_1",
             @"hello_2",
             @"hello_3",
             @"hello_4",
             @"hello_5",
             @"hello_6",
             @"hello_7",
             @"hello_8",
             @"hello_9",

             @"hello_0",
             @"hello_1",
             @"hello_2",
             @"hello_3",
             @"hello_4",
             @"hello_5",
             @"hello_6",
             @"hello_7",
             @"hello_8",
             @"hello_9",

             @"hello_0",
             @"hello_1",
             @"hello_2",
             @"hello_3",
             @"hello_4",
             @"hello_5",
             @"hello_6",
             @"hello_7",
             @"hello_8",
             @"hello_9",
             ];
}

@end
