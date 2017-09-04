//
//  EGGradientLayerViewController.m
//  Widgets
//
//  Created by EG on 2017/9/4.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGGradientLayerViewController.h"

/**
 CAGradientLayer是用来生成两种或更多颜色平滑渐变的。
 用Core Graphics复制一个CAGradientLayer并将内容绘制到一个普通图层的寄宿图也是有可能的，
 但是CAGradientLayer的真正好处在于绘制使用了 硬件加速
 左上角坐标是{0, 0}，右下角坐标是{1, 1}
 */
@interface EGGradientLayerViewController ()

@end

@implementation EGGradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:gradientLayer];
    
        //set gradient colors
    gradientLayer.colors = @[
                             (__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor orangeColor].CGColor,
                             (__bridge id)[UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor,
                             (__bridge id)[UIColor purpleColor].CGColor
                             ];
    
    gradientLayer.locations = @[
                                @(0.5),
                                @(0.6),
                                @(0.7),
                                @(0.8),
                                @(0.9),
                                @(1)
                                ];
    
        //set gradient start and end points
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
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
