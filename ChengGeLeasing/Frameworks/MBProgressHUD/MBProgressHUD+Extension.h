//
//  MBProgressHUD+Extension.h
//  Kivii
//
//  Created by 相约在冬季 on 16/5/16.
//  Copyright © 2016年 AIYISHU. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extension)<MBProgressHUDDelegate>

+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)showMessage:(NSString *)message toView:(UIView *)view delay:(NSTimeInterval)timeInterval;
+ (MBProgressHUD *)showMsg:(NSString *)message toView:(UIView *)view;
- (void)showError:(NSString *)error;
- (void)showSuccess:(NSString *)success;
+ (void)hideHUD:(UIView *)view;
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

/**
 *  旋转的菊花(不带文字)
 */
+ (MBProgressHUD *)showSimple:(UIView *)view;

/**
 *  旋转的菊花的(带文字)
 */
+ (MBProgressHUD *)showWithLabel:(NSString *)message
                          toView:(UIView *)view;

/**
 *  旋转的菊花的(带标题、副标题)
 */
+ (MBProgressHUD *)showWithDetailsLabel:(NSString *)title
                                message:(NSString *)message
                                 toView:(UIView *)view;

@end
