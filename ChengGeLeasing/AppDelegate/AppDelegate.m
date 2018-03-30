//
//  AppDelegate.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Data.h"
#import "AppDelegate+UMSoc.h"
#import "AppDelegate+JPUSH.h"
#import "CGLoginViewController.h"
#import "CGRenewPayVC.h"
#import "CGBuySeatVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //获取系统参数
    CGURLManager *entity = [self getSystemInfo];
    if(!entity) {
        entity = [CGURLManager new];
        entity.auth_ios = APP_Version;
    }
    
    //是否开启
    self.isOK = ![entity.auth_ios isEqualToString:APP_Version];
    
    //初始化友盟
    [self setupUMSocial];
    
    //初始化极光推送
    [self setupJPUSH:launchOptions];
    
    //设置根目录
    [self setWindowAndRootViewController];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [application setApplicationIconBadgeNumber:0];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        if ([url.host isEqualToString:@"safepay"]) {
            //支付宝支付回调
            
        }else if([url.host isEqualToString:@"pay"]){
            //微信支付回调
            
        }
    }
    return result;
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    //友盟
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        if ([url.host isEqualToString:@"safepay"]) {
            //支付宝处理
            
        }
        if ([url.host isEqualToString:@"pay"]) {
            //微信支付
            
        }
    }
    return result;
}

// NOTE: 9.0以后使用新API接口--支付宝
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString*, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        if ([url.host isEqualToString:@"safepay"]) {
            //支付宝支付
        }
        if ([url.host isEqualToString:@"pay"]) {
            
            NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
            NSString *payTypeStr = [us objectForKey:@"payType"];
            
            if ([payTypeStr isEqualToString:@"shengji"])
            {
                
            }
            else if ([payTypeStr isEqualToString:@"xufei"])
            {
                CGRenewPayVC *vc = (CGRenewPayVC *)[JXTool currentViewController];
                [WXApi handleOpenURL:url delegate:vc];
            }
            else if ([payTypeStr isEqualToString:@"xiwei"])
            {
                CGBuySeatVC *vc = (CGBuySeatVC *)[JXTool currentViewController];
                [WXApi handleOpenURL:url delegate:vc];
            }

            
        }
    }
    return result;
}


- (void)userLogin:(void (^)(BOOL isLogin))completion {
    
    dispatch_async(dispatch_get_main_queue(), ^
       {
           //界面条转
           CGLoginViewController *loginView = [CGLoginViewController  new];
           loginView.callback = ^(BOOL isLogin) {
               completion(isLogin);
           };
           UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginView];
           [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];

       });
    
}


@end
