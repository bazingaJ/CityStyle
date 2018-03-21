//
//  AppDelegate+Extension.h
//  Kivii
//
//  Created by 相约在冬季 on 2017/1/12.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Extension)

/**
 *  设置Window和rootViewController
 */
- (void)setWindowAndRootViewController;

/** 进入主视图 */
- (void)enterMainVC;

/**
 *  开机图
 */
@property (nonatomic, copy) NSString *launchSrc;

@end
