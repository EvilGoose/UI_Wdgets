//
//  EGNaviBarViewController.h
//  Widgets
//
//  Created by EG on 2017/8/12.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGBasicViewController.h"
 
/**
 custom button with two titles
 */
@interface GDUDoubleTitleButton : UIButton

/*top title*/
@property (copy, nonatomic)NSString *topTitle;

/*bottom title*/
@property (copy, nonatomic)NSString *bottomTitle;

@end



/**
 top options view
 */
typedef void(^optionViewClickBlock)(NSInteger);

@interface EGPersonalOptionView : UIView

/*index call back*/
@property (copy, nonatomic)optionViewClickBlock clickedCallBack;

/*work num*/
@property (copy, nonatomic)NSString *workNumber;

/*focus num*/
@property (copy, nonatomic)NSString *focusNumber;

/*fans  num*/
@property (copy, nonatomic)NSString *fansNumber;

- (void)setDefaultIndex:(NSInteger)index;

- (void)setTitleColor:(UIColor *)titleColor;

- (void)setSubTitleColor:(UIColor *)subTitleColor;

@end



@interface EGNaviBarViewController : EGBasicViewController

@end
