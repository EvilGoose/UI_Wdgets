//
//  EGLayerContentRectViewController.m
//  Widgets
//
//  Created by EG on 2017/9/2.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGLayerContentRectViewController.h"

@interface EGLayerContentRectViewController ()

/**content rect views*/
@property (nonatomic, strong)UIView *fzView;

@property (nonatomic, strong)UIView *ydView;

@property (nonatomic, strong)UIView *enView;

@property (nonatomic, strong)UIView *cbView;

/**stretch*/
@property (nonatomic, strong)UIButton *strechButton1;

@property (nonatomic, strong)UIButton *strechButton2;

@property (nonatomic, strong)UIButton *strechButton3;

@property (nonatomic, strong)UIButton *strechButton4;

@end

@implementation EGLayerContentRectViewController

/**
 contentsCenter其实是一个CGRect，它定义了一个固定的边框和一个在图层上可拉伸的区域。 
 改变contentsCenter的值并不会影响到寄宿图的显示，除非这个图层的大小改变了，你才看得到效果。
 
 contentsCenter是{0, 0, 1, 1}，这意味着如果大小（由conttensGravity决定）改变了,那么寄宿图将会均匀地拉伸开。
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.fzView];
    [self.view addSubview:self.ydView];
    [self.view addSubview:self.enView];
    [self.view addSubview:self.cbView];
    
    [self.view addSubview:self.strechButton1];
    [self.view addSubview:self.strechButton2];
    [self.view addSubview:self.strechButton3];
    [self.view addSubview:self.strechButton4];
    
    UIImage *image = [UIImage imageNamed:@"icons.png"];
        //set igloo sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:self.fzView.layer];
        //set cone sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:self.ydView.layer];
        //set anchor sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:self.enView.layer];
        //set spaceship sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:self.cbView.layer];
    
    
    
    UIImage *strechImage = [UIImage imageNamed:@"strech.png"];
    
        //set button 1 左下
    [self addStretchableImage:strechImage withContentCenter:CGRectMake(2, 0, 0, 0) toLayer:self.strechButton1.layer];
    
        //set button 2 右下
    [self addStretchableImage:strechImage withContentCenter:CGRectMake(0, 2, 0, 0) toLayer:self.strechButton2.layer];
    
        //set button 3 左上 （原图）
    [self addStretchableImage:strechImage withContentCenter:CGRectMake(0, 0, 1, 1) toLayer:self.strechButton3.layer];
    
        //set button 4 右上
    [self addStretchableImage:strechImage withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:self.strechButton4.layer];
}

    //set image
- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer {
    layer.contents = (__bridge id)image.CGImage;
    
        //scale contents to fit
    layer.contentsGravity = kCAGravityResizeAspect;
    
        //set contentsRect
    layer.contentsRect = rect;
}

- (void)addStretchableImage:(UIImage *)image withContentCenter:(CGRect)rect toLayer:(CALayer *)layer {
        //set image
    layer.contents = (__bridge id)image.CGImage;
    
        //set contentsCenter
    layer.contentsCenter = rect;
}


- (UIView *)fzView {
    if (!_fzView) {
        _fzView = [[UIView alloc]initWithFrame:CGRectMake(10, 70, 200, 200)];
        _fzView.layer.backgroundColor = RANDOM_COLOR.CGColor;
        _fzView.backgroundColor = RANDOM_COLOR;
     }
    return _fzView;
}

- (UIView *)ydView {
    if (!_ydView) {
        _ydView = [[UIView alloc]initWithFrame:CGRectMake(10, 280, 200, 200)];
        _ydView.layer.backgroundColor = RANDOM_COLOR.CGColor;
        _ydView.backgroundColor = RANDOM_COLOR;
    }
    return _ydView;
}

- (UIView *)enView {
    if (!_enView) {
        _enView = [[UIView alloc]initWithFrame:CGRectMake(220, 70, 200, 200)];
        _enView.layer.backgroundColor = RANDOM_COLOR.CGColor;
        _enView.backgroundColor = RANDOM_COLOR;
    }
    return _enView;
}

- (UIView *)cbView {
    if (!_cbView) {
        _cbView = [[UIView alloc]initWithFrame:CGRectMake(220, 280, 200, 200)];
        _cbView.layer.backgroundColor = RANDOM_COLOR.CGColor;
        _cbView.backgroundColor = RANDOM_COLOR;
    }
    return _cbView;
}

- (UIButton *)strechButton1 {
    if (!_strechButton1) {
        _strechButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _strechButton1.frame = CGRectMake(10, SCREEN_HEIGHT - 200, 100, 100);
    }
    return _strechButton1;
}

- (UIButton *)strechButton2 {
    if (!_strechButton2) {
        _strechButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _strechButton2.frame = CGRectMake(150, SCREEN_HEIGHT - 200, 100, 100);
    }
    return _strechButton2;
}

- (UIButton *)strechButton3 {
    if (!_strechButton3) {
        _strechButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _strechButton3.frame = CGRectMake(10, SCREEN_HEIGHT - 350, 100, 100);
    }
    return _strechButton3;
}

- (UIButton *)strechButton4 {
    if (!_strechButton4) {
        _strechButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
        _strechButton4.frame = CGRectMake(150, SCREEN_HEIGHT - 350, 100, 100);
    }
    return _strechButton4;
}

@end
