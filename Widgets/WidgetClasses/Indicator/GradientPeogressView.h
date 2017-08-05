//
//  GradientPeogressView.h
//  drawViw
//
//  Created by EG on 17/2/27.
//  Copyright © 2017年 edao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientPeogressView : UIView

/**环是否使用渐变色*/
@property (assign, nonatomic)BOOL gradient;

/**渐变颜色最浅色*/
@property (strong, nonatomic)UIColor *lightColor;

/**渐变颜色中间色*/
@property (assign, nonatomic)UIColor *middleColor;

/**渐变颜色最深色*/
@property (strong, nonatomic)UIColor *darkColor;

/**环的颜色*/
@property (strong, nonatomic)UIColor *customColor;

/**线宽*/
@property (assign, nonatomic)CGFloat lineWidth;

-(void)setPercent:(CGFloat)percent animated:(BOOL)animated duration:(CGFloat)duration;

@end
