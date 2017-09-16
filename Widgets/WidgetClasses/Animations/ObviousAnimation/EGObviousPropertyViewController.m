//
//  EGObviousPropertyViewController.m
//  Widgets
//
//  Created by EG on 2017/9/16.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGObviousPropertyViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface EGObviousPropertyViewController ()
<
CAAnimationDelegate
>

/**layerView*/
@property (nonatomic, strong)UIView *layerView;

/**colorLayer*/
@property (nonatomic, strong)CALayer *colorLayer;

@end

@implementation EGObviousPropertyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        //create sublayer
    [self.view addSubview:self.layerView];
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
        //add it to our view
    [self.layerView.layer addSublayer:self.colorLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //create a new random color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        //create a basic animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    animation.delegate = self;
        //apply animation to layer
    [self.colorLayer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
        //set the backgroundColor property to match animation toValue
        //“委托传入的动画参数是原始值的一个深拷贝”
    [CATransaction begin];
        //“我们不能通过隐式动画来实现因为这些指针都是UIView的实例，所以图层的隐式动画都被禁用了。”
    [CATransaction setDisableActions:YES];
    self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}

- (UIView *)layerView {
    if (!_layerView) {
        _layerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _layerView.backgroundColor = [UIColor blackColor];
        _layerView.center = self.view.center;
    }
    return _layerView;
}

@end
