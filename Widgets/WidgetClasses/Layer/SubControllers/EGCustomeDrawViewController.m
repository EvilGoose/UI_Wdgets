//
//  EGCustomeDrawViewController.m
//  Widgets
//
//  Created by EG on 2017/9/2.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGCustomeDrawViewController.h"

@interface EGCustomeDrawViewController ()
<CALayerDelegate>

@end

@implementation EGCustomeDrawViewController

/*
 -drawRect: 方法没有默认的实现，因为对UIView来说，寄宿图 并不是 必须的，它不在意那到底是单调的颜色还是有一个图片的实例
 虽然-drawRect:方法是一个UIView方法，事实上都是底层的CALayer安排了重绘工作和保存了因此产生的图片
 
 CALayer有一个可选的delegate属性，实现了CALayerDelegate协议，当CALayer需要一个内容特定的信息时，就会从协议中请求。CALayerDelegate是一个非正式协议，其实就是说没有CALayerDelegate
 @protocol可以让你在类里面引用。你只需要调用你想调用的方法，CALayer会帮你做剩下的。
 
 当需要被重绘时，CALayer会请求它的代理给他一个寄宿图来显示。它通过调用下面这个方法做到的:
 - (void)displayLayer:(CALayerCALayer *)layer;

 趁着这个机会，如果代理想直接设置contents属性的话，它就可以这么做，不然没有别的方法可以调用了。
 如果代理不实现-displayLayer:方法，CALayer就会转而尝试调用下面这个方法：
 - (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;
 
 但是除非你创建了一个单独的图层，你几乎没有机会用到CALayerDelegate协议。
 因为当UIView创建了它的宿主图层时，它就会自动地把图层的delegate设置为它自己，并提供了一个-displayLayer:的实现。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        //create sublayer
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.0f, 70.0f, 100.0f, 100.0f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
        //set controller as layer delegate
    blueLayer.delegate = self;
    
        //ensure that layer backing image uses correct scale
    blueLayer.contentsScale = [UIScreen mainScreen].scale; //add layer to our view
    
    blueLayer.borderWidth = 2.0f;
    blueLayer.borderColor = [UIColor orangeColor].CGColor;
    
    blueLayer.cornerRadius = 5.0f;
    
    [self.view.layer addSublayer:blueLayer];
    
	//force layer to redraw
    [blueLayer display];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
        //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f - 2.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

@end
