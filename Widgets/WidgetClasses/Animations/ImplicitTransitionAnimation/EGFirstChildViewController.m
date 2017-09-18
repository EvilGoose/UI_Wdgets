//
//  EGFirstChildViewController.m
//  Widgets
//
//  Created by EG on 2017/9/18.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGFirstChildViewController.h"

@interface EGFirstChildViewController ()

@end

@implementation EGFirstChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"First";
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
}

@end
