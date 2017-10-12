
    //
//  EGViewController_dispatch_block_t.m
//  Widgets
//
//  Created by Fangweiyi on 2017/10/11.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGViewController_dispatch_block_t.h"
#import "EGCallOutViewController.h"

@interface EGViewController_dispatch_block_t ()

@end

@implementation EGViewController_dispatch_block_t

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    EGCallOutViewController *newVC = [EGCallOutViewController new];
    newVC.callBack = ^{
        NSLog(@"hello world");
    };
    [self presentViewController:newVC animated:YES completion:^{

    }];
}


@end
