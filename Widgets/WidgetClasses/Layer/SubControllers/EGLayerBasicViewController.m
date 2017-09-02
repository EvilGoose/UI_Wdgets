//
//  EGLayerBasicViewController.m
//  Widgets
//
//  Created by EG on 2017/9/2.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGLayerBasicViewController.h"

@interface EGLayerBasicViewController ()

/**layerView*/
@property (nonatomic, strong)UIView *layerView;

/**size Label*/
@property (nonatomic, strong)UILabel *sizeLabel;

@end

@implementation EGLayerBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSStringFromClass(self.class);
    
    [self.view addSubview:self.layerView];
    [self.view addSubview:self.sizeLabel];
    
    UIImage *image = [UIImage imageNamed:@"car.png"]; //add it directly to our view's layer
    self.layerView.layer.contents = (__bridge id)image.CGImage; //center the image
    self.layerView.layer.contentsGravity = kCAGravityCenter;
    
        //set the contentsScale to match image
        //下面两个缩放尺寸是不一样的
        //如果contentsScale设置为1.0，将会以每个点1个像素绘制图片，如果设置为2.0，则会以每个点2个像素绘制图片，这就是我们熟知的Retina屏幕。
    
//    self.layerView.layer.contentsScale = image.scale;
    self.layerView.layer.contentsScale = [UIScreen mainScreen].scale;//用这个
    
    self.sizeLabel.text = [NSString stringWithFormat:@"image.size %f %f || %f %f", image.size.width, image.size.height, self.layerView.layer.preferredFrameSize.width, self.layerView.layer.preferredFrameSize.height];
}

#pragma mark - lazy

- (UIView *)layerView {
    if (!_layerView) {
        _layerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 5, SCREEN_HEIGHT * .5)];
        _layerView.layer.backgroundColor = [UIColor redColor].CGColor;
        _layerView.backgroundColor = [UIColor greenColor];
        _layerView.center = self.view.center;
    }
    return _layerView;
}

- (UILabel *)sizeLabel {
    if (!_sizeLabel) {
        _sizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, SCREEN_WIDTH - 20, 40)];
        _sizeLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _sizeLabel;
}

@end
