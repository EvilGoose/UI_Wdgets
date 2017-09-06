//
//  MBProgressHUD+Extension.h
//  Widgets
//
//  Created by EG on 2017/9/5.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Extension)

+ (void)showError:(NSString *)error;

+ (void)showSuccess:(NSString *)success;

+ (void)showMessage:(NSString *)message;

+ (void)hideHUD;

+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUDFromView:(UIView *)view;

@end
