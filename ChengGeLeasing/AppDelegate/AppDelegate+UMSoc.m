//
//  AppDelegate+UMSoc.m
//  Kivii
//
//  Created by 相约在冬季 on 2017/9/26.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import "AppDelegate+UMSoc.h"
#import "UMMobClick/MobClick.h"

@implementation AppDelegate (UMSoc)

/**
 *  初始化友盟
 */
- (void)setupUMSocial {
    
    //友盟统计
    [MobClick setLogEnabled:NO];
    UMConfigInstance.appKey = @"5a430b10f43e48715c000047";
    UMConfigInstance.secret = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    
//    //打开日志
//    [[UMSocialManager defaultManager] openLog:YES];
//    
//    //注册友盟AppKey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5a430b10f43e48715c000047"];
    
    //设置QQAppId,appSecret,分享url
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105997869" appSecret:@"pNIKjd55kg2qI5DX" redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx2b33ffa189d5bc6f" appSecret:@"26f045af7a090b0b7a35bf3fa5fbdd50" redirectURL:@"http://mobile.umeng.com/social"];
//    
//    //设置新浪的appKey和appSecret
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1521880094"  appSecret:@"82447cc0109e97c27da1c21bd2a7df69" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

@end
