//
//  AppDelegate.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  是否开启
 */
@property (nonatomic, assign) BOOL isOK;
/**
 *  用户登录
 */
- (void)userLogin:(void (^)(BOOL isLogin))completion;


@end

