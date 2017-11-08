//
//  EGValidEdgePopGestureController.m
//  Widgets
//
//  Created by FangViee on 2017/10/23.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGValidEdgePopGestureController.h"

@interface EGValidEdgePopGestureController ()
<UIGestureRecognizerDelegate>

@end

@implementation EGValidEdgePopGestureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

    // 给该控制器添加协议 <UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return gestureRecognizer != self.navigationController.interactivePopGestureRecognizer;
}

@end
