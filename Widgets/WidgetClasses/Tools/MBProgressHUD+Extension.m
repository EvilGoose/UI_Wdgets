//
//  MBProgressHUD+Extension.m
//  Widgets
//
//  Created by EG on 2017/9/5.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)

#pragma mark API

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (void)showMessage:(NSString *)message
{
    [self showMessage:message toView:nil];
}

+ (void)hideHUD
{
    [self hideHUDFromView:nil];
}

+ (void)showError:(NSString *)error toView:(UIView *)view
{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
        // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
        // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
        // YES代表需要蒙版效果
    hud.backgroundColor = [UIColor colorWithWhite:0.f alpha:.2f];
    
}

+ (void)hideHUDFromView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

#pragma mark - private

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    
        // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    
        // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    
        // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
        // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
        // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:0.7];
}

@end
