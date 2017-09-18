//
//  EGImplicitTransitionViewController.m
//  Widgets
//
//  Created by EG on 2017/9/18.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGImplicitTransitionViewController.h"
#import "EGAnimationTabBarController.h"

@interface EGImplicitTransitionViewController ()

@end

@implementation EGImplicitTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *reminder = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    reminder.text = @"Touch to start!";
    reminder.textColor = [UIColor blueColor];
    [self.view addSubview:reminder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController presentViewController:[EGAnimationTabBarController new] animated:YES completion:nil];
}

@end
