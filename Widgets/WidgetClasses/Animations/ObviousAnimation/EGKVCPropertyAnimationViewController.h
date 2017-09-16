//
//  EGKVCPropertyAnimationViewController.h
//  Widgets
//
//  Created by EG on 2017/9/16.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGBasicViewController.h"

/**
 “当更新属性的时候，我们需要设置一个新的事务，并且禁用图层行为。
 否则动画会发生两次，一个是因为显式的CABasicAnimation，另一次是因为隐式动画”

 */
@interface EGKVCPropertyAnimationViewController : EGBasicViewController

@end
