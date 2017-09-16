//
//  EGVirtualAnimationViewController.m
//  Widgets
//
//  Created by EG on 2017/9/16.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGVirtualAnimationViewController.h"

/**
 “属性动画实际上是针对于关键路径而不是一个键，这就意味着可以对子属性甚至是虚拟属性做动画”
 
 
 */
@interface EGVirtualAnimationViewController ()

@end

@implementation EGVirtualAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self rotateAnimation];
    [self transformRotateAnimation];
}

- (void)rotateAnimation {
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 40, 40);
    shipLayer.position = CGPointMake(150, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"Plane"].CGImage;
    [self.view.layer addSublayer:shipLayer];
        //animate the ship rotation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform";
    animation.duration = 2.0;
    
//    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    
    //M_PI修改为M_PI * 2就不会动了,这是因为这里的矩阵做了一次360度的旋转,和做了0度一样,所有最后的值根本就没有修改
    //“有一个更好的解决方案：为了旋转图层，我们可以对transform.rotation关键路径应用动画，而不是transform本身”
    
    animation.byValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0, 0, 1)];

    [shipLayer addAnimation:animation forKey:nil];
}

- (void)transformRotateAnimation {
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 128, 128);
    shipLayer.position = CGPointMake(150, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"Plane"].CGImage;
    [self.view.layer addSublayer:shipLayer];
        //animate the ship rotation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";//这句不一样~
    animation.duration = 2.0;
    animation.byValue = @(M_PI * 2);
    [shipLayer addAnimation:animation forKey:nil];
}
    /*
     用transform.rotation而不是transform做动画的好处如下：
     
     - 我们可以不通过关键帧一步旋转多于180度的动画。
     - 可以用相对值而不是绝对值旋转（设置byValue而不是toValue）。
     - 可以不用创建CATransform3D，而是使用一个简单的数值来指定角度。
     - 不会和transform.position或者transform.scale冲突（同样是使用关键路径来做独立的动画属性）。
     
     transform.rotation属性有一个奇怪的问题是它其实并不存在。
     这是因为CATransform3D并不是一个对象，它实际上是一个结构体，也没有符合KVC相关属性，transform.rotation实际上是一个CALayer用于处理动画变换的 虚拟属性 。
     你不可以直接设置transform.rotation或者transform.scale，他们不能被直接使用。
     当你对他们做动画时，Core Animation自动地根据通过CAValueFunction来计算的值来更新transform属性
     
     CAValueFunction用于把我们赋给虚拟的transform.rotation简单浮点值转换成真正的用于摆放图层的CATransform3D矩阵值。
     你可以通过设置CAPropertyAnimation的valueFunction属性来改变，于是你设置的函数将会覆盖默认的函数。
     

     
     */

@end
