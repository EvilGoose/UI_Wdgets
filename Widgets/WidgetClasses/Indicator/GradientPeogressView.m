//
//  GradientPeogressView.m
//  drawViw
//
//  Created by EG on 17/2/27.
//  Copyright © 2017年 edao. All rights reserved.
//

#import "GradientPeogressView.h"
#import "UIColor+PDExtension.h"
 
#define Degree(x) (M_PI * (x)/180.0)

//默认配置
#define DEFAULT_LINE_WIDTH 5

#define DEFAULT_LINE_COLOR [UIColor darkGrayColor]

#define DEFAULT_LIGHT_COLOR [UIColor lightGrayColor]
#define DEFAULT_MIDDLE_COLOR [UIColor grayColor]
#define DEFAULT_DARK_COLOR [UIColor darkGrayColor]

@interface GradientPeogressView() {
    CAShapeLayer *_trackLayer;
    CAShapeLayer *_progressLayer;
    UIColor *_strokeColor;
}

@end

@implementation GradientPeogressView

-(void)setPercent:(double)percent animated:(BOOL)animated duration:(CGFloat)duration {
    
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:duration];
    
    _progressLayer.strokeEnd = percent < 0.998 ? percent : 0.998;
    
    [CATransaction commit];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width != frame.size.height) {
        CGFloat min = MIN(frame.size.width ,frame.size.height);
        frame.size = CGSizeMake(min, min);
    }

    if (self = [super initWithFrame:frame]) {
        [self drawTrackView];
        self.gradient = YES;
    }
    return self;
}

- (void)setGradient:(BOOL)gradient {
    _gradient = gradient;
    [self setNeedsDisplay];
}

#pragma mark - draw progress
- (void)drawTrackView {
    _strokeColor=[UIColor lightGrayColor];//背景圆环的颜色
    
    if (self.lineWidth == 0) {
        self.lineWidth = DEFAULT_LINE_WIDTH;
    }
    
    UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:
                        CGPointMake(self.frame.size.width * .5, self.frame.size.height * .5)
                                                      radius:(self.frame.size.width - self.lineWidth) * .5
                                                  startAngle:Degree(-90)
                                                    endAngle:Degree(270)
                                                   clockwise:YES];
    
    _trackLayer = [CAShapeLayer layer];
    _trackLayer.frame = self.bounds;
    _trackLayer.fillColor = [UIColor clearColor].CGColor;
    _trackLayer.strokeColor = _strokeColor.CGColor;
    
        //背景圆环的背景透明度
    _trackLayer.opacity = 0.25;
    
        //这个参数主要是调整环型进度条边上是不圆角，主要有三个参数kCALineCapRound(圆角)，kCALineCapButt（直角），kCALineCapSquare（这个参数设了跟直角一样）
    _trackLayer.lineCap = kCALineCapButt;
    _trackLayer.lineWidth = self.lineWidth;
    _trackLayer.path = [trackPath CGPath];
    
    [self.layer addSublayer:_trackLayer];

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:
                          CGPointMake(self.frame.size.width * .5, self.frame.size.height * .5)
                                                        radius:(self.frame.size.width - self.lineWidth) * .5
                                                    startAngle:Degree(-85.8)
                                                      endAngle:Degree(266.2)
                                                     clockwise:YES];
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor = [UIColor redColor].CGColor;//这个一定不能用clearColor，然显示不出来
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = self.lineWidth;
    _progressLayer.path = [path CGPath];
    _progressLayer.strokeEnd = 0.0;
    
        //背景渐变色
    CALayer *gradientLayer=[CALayer layer];
    
    CAGradientLayer *gradientLayerPart1 = [CAGradientLayer layer];
    gradientLayerPart1.frame = CGRectMake(0, 0, self.frame.size.width * .5,self.frame.size.height);

    CAGradientLayer *gradientLayerPart2 = [CAGradientLayer layer];
    gradientLayerPart2.frame = CGRectMake(self.frame.size.width * .5, 0, self.frame.size.width * .5 , self.bounds.size.height);
    
    
//    if (self.gradient) {
        if (!self.lightColor) {
            self.lightColor = DEFAULT_LIGHT_COLOR;
        }
        
        if (!self.darkColor) {
            self.darkColor = DEFAULT_DARK_COLOR;
        }
        
        if (!self.middleColor) {
            self.middleColor = DEFAULT_MIDDLE_COLOR;
        }
        
        [gradientLayerPart1 setColors:[NSArray arrayWithObjects:
                                       (id)self.lightColor.CGColor,
                                       (id)self.middleColor.CGColor,
                                       nil]];
        
        [gradientLayerPart1 setStartPoint:CGPointMake(0.5, 0)];//调整颜色比例主要是调这两个参数（0－1之间）
        [gradientLayerPart1 setEndPoint:CGPointMake(0.5, 1)];//调整颜色比例主要是调这两个参数（0－1之间）
        [gradientLayer addSublayer:gradientLayerPart1];
        
        [gradientLayerPart2 setColors:[NSArray arrayWithObjects:
                                       (id)self.darkColor.CGColor,
                                       (id)self.middleColor.CGColor,
                                       nil]];
        [gradientLayerPart2 setStartPoint:CGPointMake(0.5, 0)];
        [gradientLayerPart2 setEndPoint:CGPointMake(0.5, 1)];
            //如果只需要两种颜色渐变
        [gradientLayer addSublayer:gradientLayerPart2];
        
//    }else {
//        if (!self.customColor) {
//            self.customColor = DEFAULT_LINE_COLOR;
//        }
//        
//        [gradientLayerPart1 setColors:[NSArray arrayWithObjects:(id)self.customColor.CGColor, nil]];
//        [gradientLayerPart2 setColors:[NSArray arrayWithObjects:(id)self.customColor.CGColor, nil]];
//    }
    
    
    [gradientLayer setMask:_progressLayer];
    [self.layer addSublayer:gradientLayer];
}

@end
