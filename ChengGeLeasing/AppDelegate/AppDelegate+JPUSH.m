//
//  AppDelegate+JPUSH.m
//  jiaxiaopingtai
//
//  Created by 相约在冬季 on 2017/9/28.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "AppDelegate+JPUSH.h"
#import "CGMineMessageViewController.h"

static NSString *appKey = @"d010fda114e55d4a05164c1e";
static NSString *channel = @"App Store";
static BOOL isProduction = FALSE;

@implementation AppDelegate (JPUSH)

/**
 *  创建JPUSH推送
 */
- (void)setupJPUSH:(NSDictionary *)launchOptions {
    
    //场景一：添加初始化APNs代码
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //场景二：添加初始化JPush代码
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    //NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *advertisingId = [HelperManager CreateInstance].getIDFA;
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    
    //注册自定义消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidReceiveMessage:)
                                                 name:kJPFNetworkDidReceiveMessageNotification
                                               object:nil];
    
    //JPush 监听登陆成功
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidLogin)
                                                 name:kJPFNetworkDidLoginNotification
                                               object:nil];

}

/**
 *  自定义消息接收方法
 */
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    
    //创建“本地通知”
    [self addLocalNotification:userInfo];
    
//    [JPUSHService setLocalNotification:[NSDate dateWithTimeIntervalSinceNow:10] alertBody:@"收到了自定义信息" badge:1 alertAction:@"adada" identifierKey:nil userInfo:nil soundName:nil];
    
}

/**
 *  登陆成功调用方法
 */
- (void)networkDidLogin {
    NSString *idfaStr  = [HelperManager CreateInstance].getIDFA;
    [JPUSHService setTags:nil alias:idfaStr fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"%d-------------%@,-------------%@",iResCode,iTags,iAlias);
    }];
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kJPFNetworkDidLoginNotification
                                                  object:nil];
}

/**
 *  注册APNs成功并上报DeviceToken
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

/**
 *  实现注册APNs失败接口（可选）
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#pragma mark- JPUSHRegisterDelegate 注册代理

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    //前台收到远程通知
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        //自定义远程推送声音
//        NSString *str = @"新订单";//[NSString stringWithFormat:@"%@",userInfo[@"aps"][@"alert"]];
//        NSLog(@"user-----%@",userInfo);
//        if ([str containsString:@"新订单"]) {
//            //音效文件路径
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"caf"];
//            //这里是指你的音乐名字和文件类型
//            NSLog(@"path---%@",path);
//            //组装并播放音效
//            SystemSoundID soundID;
//            NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
//            AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
//            AudioServicesPlaySystemSound(soundID);
//
//        }else if([str containsString:@"退货"]){
//
//
//
//        }else{
//
//
//
//        }
        
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
    }else{
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
    }else{
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    NSString *typeStr = userInfo[@"extras"][@"jump_type"];
    
    //查看通知:1消息 2待办
    [self didSelectPushMessage:typeStr];
    
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    
    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
        //TODO...
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    
    NSLog(@"iOS6及以下系统，收到通知:%@", [self logDic:userInfo]);
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

/**
 *  添加本地消息通知
 */
-(void)addLocalNotification:(NSDictionary *)userInfo {
    //通知主题
    NSString *content = [userInfo valueForKey:@"content"];
    
    UILocalNotification *localNotifa = [[UILocalNotification alloc] init];
    localNotifa.alertBody = content; // 通知的内容
    localNotifa.soundName = @"msg.caf"; //通知的声音sound.caf
    localNotifa.alertAction = @":查看"; // 锁屏的时候 相当于 滑动来::查看最新重大新闻
    //localNotifa.alertTitle=@"弹出标题,我在这里";
    localNotifa.applicationIconBadgeNumber = 1;
    localNotifa.fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0]; // 触发通知的时间(5秒后发送通知)
    localNotifa.timeZone = [NSTimeZone defaultTimeZone];  // 设置时区
    localNotifa.repeatInterval = NSCalendarUnitDay; // 通知重复提示的单位，可以是天、周、月
    localNotifa.userInfo = userInfo;
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotifa]; // 调度通知(启动通知)
    
}

/**
 *  查看推送消息
 */
- (void)didSelectPushMessage:(NSString *)typeStr {
    
    dispatch_async(dispatch_get_main_queue(), ^
   {
       //界面条转
       CGMineMessageViewController *messageView = [[CGMineMessageViewController alloc] init];
       [messageView setIsPush:YES];
       if([typeStr isEqualToString:@"2"]) {
           messageView.segmentIndex = 1;
       }
       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:messageView];
       [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
       
   });
}

@end
