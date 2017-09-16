//
//  EGKeyAnimationViewController.m
//  Widgets
//
//  Created by EG on 2017/9/16.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGKeyAnimationViewController.h"

@interface EGKeyAnimationViewController ()

@property (nonatomic, strong)CALayer *colorLayer;

@property (nonatomic, strong)CALayer *planeLayer;

@end

@implementation EGKeyAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   }

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self bezierPathAnimation];
 }

- (void)keyAnimation {
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(100, 100.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.view.layer addSublayer:self.colorLayer];

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
        //apply animation to layer
    [self.colorLayer addAnimation:animation forKey:nil];
}

- (void)bezierPathAnimation {
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(100, 150)];
    [bezierPath addCurveToPoint:CGPointMake(400, 150)
                  controlPoint1:CGPointMake(175, 0)
                  controlPoint2:CGPointMake(325, 300)];
    
        //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    
        //add the ship
    self.planeLayer = [CALayer layer];
    self.planeLayer.frame = CGRectMake(0, 0, 40, 40);
    self.planeLayer.position = CGPointMake(100, 150);
    self.planeLayer.contents = (__bridge id)[UIImage imageNamed: @"Plane"].CGImage;
    [self.view.layer addSublayer:self.planeLayer];
    
        //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;//这句话很神的哦!
    [self.planeLayer addAnimation:animation forKey:nil];
}

@end
