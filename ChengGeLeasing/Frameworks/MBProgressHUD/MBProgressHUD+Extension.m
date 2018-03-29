//
//  MBProgressHUD+Extension.m
//  Kivii
//
//  Created by 相约在冬季 on 16/5/16.
//  Copyright © 2016年 AIYISHU. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:16.0];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.0];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}
- (void)showSuccess:(NSString *)success
{
    self.detailsLabelText = success ? success : @"操作成功";
    self.detailsLabelFont = [UIFont systemFontOfSize:16];
    // 设置图片
    self.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"success.png"]]];
    // 再设置模式
    self.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    self.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [self hide:YES afterDelay:1.0];
}
- (void)showError:(NSString *)error
{
    self.detailsLabelText = error ? error :@"操作失败";
    self.detailsLabelFont = [UIFont systemFontOfSize:16];
    // 设置图片
    self.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"error.png"]]];
    // 再设置模式
    self.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    self.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [self hide:YES afterDelay:1.0];
}
+ (void)showMessage:(NSString *)message toView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelFont = [UIFont systemFontOfSize:16];
    hud.detailsLabelText = message ? message : @"操作错误";
    
    
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = NO;
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.5];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view delay:(NSTimeInterval)timeInterval
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelFont = [UIFont systemFontOfSize:16];
    hud.detailsLabelText = message ? message : @"操作错误";
    
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = NO;
    // 1秒之后再消失
    [hud hide:YES afterDelay:timeInterval];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMsg:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelFont = [UIFont systemFontOfSize:16.0];
    hud.detailsLabelText = message ? message : @"操作中...";
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}

//隐藏
+ (void)hideHUD:(UIView *)view {
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  旋转的菊花(不带文字)
 */
+ (MBProgressHUD *)showSimple:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}

/**
 *  旋转的菊花的(带文字)
 */
+ (MBProgressHUD *)showWithLabel:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelFont = [UIFont systemFontOfSize:16.0];
    hud.detailsLabelText = message ? message : @"操作中...";
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}

/**
 *  旋转的菊花的(带标题、副标题)
 */
+ (MBProgressHUD *)showWithDetailsLabel:(NSString *)title
                                message:(NSString *)message
                                 toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelFont = [UIFont systemFontOfSize:16.0];
    hud.labelText = title ? title : @"操作中...";;
    hud.detailsLabelFont = [UIFont systemFontOfSize:14.0];
    hud.detailsLabelText = message ? message : @"操作中...";
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}

@end
