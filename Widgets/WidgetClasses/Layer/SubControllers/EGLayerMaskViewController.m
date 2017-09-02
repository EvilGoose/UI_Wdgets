//
//  EGLayerMaskViewController.m
//  Widgets
//
//  Created by EG on 2017/9/2.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGLayerMaskViewController.h"

@interface EGLayerMaskViewController ()

@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation EGLayerMaskViewController

/**
 通过这个方式画什么形状的头像简直so EZ
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    // Do any additional setup after loading the view.
     [self.view addSubview:self.imageView];
        //create mask layer
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(20, 95, 100, 100);
    UIImage *maskImage = [UIImage imageNamed:@"heart.png"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    
        //apply mask to image layer￼
    self.imageView.layer.mask = maskLayer;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car.png"]];
        _imageView.frame = CGRectMake(0, 0, 360, 307);
        _imageView.backgroundColor = [UIColor orangeColor];
        _imageView.center = self.view.center;
    }
    return _imageView;
}

@end
