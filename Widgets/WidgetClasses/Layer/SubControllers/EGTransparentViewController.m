//
//  EGTransparentViewController.m
//  Widgets
//
//  Created by EG on 2017/9/2.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGTransparentViewController.h"

@interface EGTransparentViewController ()

@end

@implementation EGTransparentViewController

    //UIView有一个叫做alpha的属性来确定视图的透明度。CALayer有一个等同的属性叫做opacity，这两个属性都是影响子层级的。也就是说，如果你给一个图层设置了opacity属性，那它的子图层都会受此影响。

    //通过设置Info.plist文件中的UIViewGroupOpacity为YES来达到这个效果，但是这个设置会影响到这个应用，整个app可能会受到不良影响 ==> 如果打开为NO,在过去会有透明度混合的问题,现在苹果已经默认处理这个东西了

    //设置CALayer的一个叫做 shouldRasterize属性 来实现组透明的效果，如果它被设置为YES，在应用透明度之前，图层及其子图层都会被整合成一个整体的图片，这样就没有透明度混合的问题了

- (UIButton *)customButton
{
        //create button
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    
        //add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"Hello World";
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    return button;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
        //create opaque button
    UIButton *button1 = [self customButton];
    button1.center = CGPointMake(150, 150);
    [self.view addSubview:button1];
    
        //create translucent button
    UIButton *button2 = [self customButton];
    button2.center = CGPointMake(150, 250);
    button2.alpha = 0.5;
    [self.view addSubview:button2];
    
        //enable rasterization for the translucent button
    button2.layer.shouldRasterize = YES;
    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

@end
