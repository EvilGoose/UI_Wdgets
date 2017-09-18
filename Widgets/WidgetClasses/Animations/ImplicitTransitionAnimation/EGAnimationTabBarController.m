//
//  EGAnimationTabBarController.m
//  Widgets
//
//  Created by EG on 2017/9/18.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGAnimationTabBarController.h"
#import "EGFirstChildViewController.h"
#import "EGSecondViewController.h"

@interface EGAnimationTabBarController ()
<UITabBarDelegate>

@end

@implementation EGAnimationTabBarController

- (instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
        [self addChildViewController:[EGFirstChildViewController new]];
        [self addChildViewController:[EGSecondViewController new]];
    }
    return self;
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
        //apply transition to tab bar controller's view
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
}

- (void)dealloc {
    self.delegate = nil;
}

@end

