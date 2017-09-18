//
//  EGTransitionViewController.m
//  Widgets
//
//  Created by EG on 2017/9/18.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGTransitionViewController.h"


/**
 “过渡并不像属性动画那样平滑地在两个值之间做动画，而是影响到整个图层的变化。过渡动画首先展示之前的图层外观，然后通过一个交换过渡到新的外观。”
 */

@interface EGTransitionViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, copy) NSArray *images;

@end

@implementation EGTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    	//set up crossfade transition
    CATransition *transition = [CATransition animation];
    
//    transition.type = kCATransitionFade;
    transition.type = kCATransitionReveal;
    
// 	  系统提供的动画类型:
//    kCATransitionFade
//    kCATransitionMoveIn
//    kCATransitionPush
//    kCATransitionReveal
    
    
// 	  通过subtype来控制它们的方向，提供了如下四种类型：
//    kCATransitionFromRight
//    kCATransitionFromLeft
//    kCATransitionFromTop
//    kCATransitionFromBottom
    
    
        //apply transition to imageview backing layer
    [self.imageView.layer addAnimation:transition forKey:nil];
        //cycle to next image
    UIImage *currentImage = self.imageView.image;
    NSUInteger index = [self.images indexOfObject:currentImage];
    index = (index + 1) % [self.images count];
    self.imageView.image = self.images[index];
}

#pragma mark - lazy

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon1"]];
        _imageView.backgroundColor = [UIColor greenColor];
        _imageView.center = self.view.center;
    }
    return _imageView;
}

- (NSArray *)images {
    if (!_images) {
        _images = @[[UIImage imageNamed:@"icon1"],
                                   [UIImage imageNamed:@"icon2"],
                                   [UIImage imageNamed:@"icon3"],
                                   [UIImage imageNamed:@"icon4"]];
    }
    return _images;
}

@end
