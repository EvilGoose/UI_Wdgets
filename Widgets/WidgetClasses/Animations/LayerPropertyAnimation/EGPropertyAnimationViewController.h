//
//  EGPropertyAnimationViewController.h
//  Widgets
//
//  Created by EG on 2017/9/15.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGBasicViewController.h"


/**
 隐式动画
 
 “动画并不需要你在Core Animation中手动打开，相反需要明确地关闭，否则他会一直存在”
 
 “当你改变CALayer的一个可做动画的属性，它并不能立刻在屏幕上体现出来。相反，它是从先前的值平滑过渡到新的值。这一切都是默认的行为，你不需要做额外的操作。”
 
 */
@interface EGPropertyAnimationViewController : EGBasicViewController

@end
