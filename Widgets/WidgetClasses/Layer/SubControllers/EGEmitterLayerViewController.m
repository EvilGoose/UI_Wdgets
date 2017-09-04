//
//  EGEmitterLayerViewController.m
//  Widgets
//
//  Created by EG on 2017/9/4.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGEmitterLayerViewController.h"

/**
 CAEmitterLayer是一个高性能的粒子引擎，被用来创建实时例子动画如：烟雾，火，雨等等这些效果
 CAEmitterLayer看上去像是许多CAEmitterCell的容器，这些CAEmitierCell定义了一个粒子效果
 我们会为不同的例子效果定义一个或多个CAEmitterCell作为模版，
 同时CAEmitterLayer负责基于这些模版实例化一个粒子流。
 一个CAEmitterCell类似于一个CALayer：它有一个contents属性可以定义为一个CGImage，
 另外还有一些可设置属性控制着表现和行为
 */
@interface EGEmitterLayerViewController ()

@end

@implementation EGEmitterLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.view.bounds;
    [self.view.layer addSublayer:emitter];
    
        //configure emitter
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width * .25,
                                          emitter.frame.size.height * .25);
    
        //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"strech.png"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.6;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    
        //add particle template to emitter
    emitter.emitterCells = @[cell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
