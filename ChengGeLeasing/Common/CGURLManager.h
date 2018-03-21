//
//  CGURLManager.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGURLManager : NSObject

/**
 *  创建单例模式
 */
+ (instancetype)manager;
/**
 *  开机图
 */
@property (nonatomic, strong) NSString *open_img;
/**
 *  关于我们
 */
@property (nonatomic, strong) NSString *about_url;
/**
 *  帮助
 */
@property (nonatomic, strong) NSString *help_url;
/**
 *  用户类型
 */
@property (nonatomic, strong) NSString *user_url;
/**
 *  电话
 */
@property (nonatomic, strong) NSString *hotline;
/**
 *  审核版本
 */
@property (nonatomic, strong) NSString *auth_ios;

@end
