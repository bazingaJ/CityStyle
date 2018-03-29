//
//  CommonDefine.h
//  liangmaitong
//
//  Created by 相约在冬季 on 2017/1/14.
//  Copyright © 2017年 liangmaitong. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

//获取设备宽、高
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds

//宏定义
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAV_BAR_HEIGHT 44
#define NAVIGATION_BAR_HEIGHT (NAV_BAR_HEIGHT+STATUS_BAR_HEIGHT)
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

#define IOS7 [[UIDevice currentDevice].systemVersion floatValue] >= 7.0
#define IOS8 [[UIDevice currentDevice].systemVersion floatValue] >= 8.0
#define IOS9 [[UIDevice currentDevice].systemVersion floatValue] >= 9.0

/**
 *  获取系统版本号
 */
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
/**
 *  iPhone or iPad
 */
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/**
 *  获取Window
 */
#define kWindow [UIApplication sharedApplication].keyWindow
/**
 *  获取AppDelegate
 */
#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])
/**
 *  版本号1.0.0
 */
#define APP_Version [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]
/**
 *  获取APP名称
 */
#define APP_Name [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]]
/**
 *  系统通知宏定义
 */
#define POST_NOTIFICATION(name) [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];

#define REGISTER_NOTIFICATION(obj,notif_name,sel)                    \
if([obj respondsToSelector:sel])                            \
[[NSNotificationCenter defaultCenter]    addObserver:obj    \
selector:sel    \
name:notif_name    \
object:nil        \
];

//SELF宏定义
#define WS(weakSelf) __unsafe_unretained __typeof(&*self)weakSelf = self;

/**
 *  判断字符串是否为空
 */
#define IsStringEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]) || [(_ref)isEqualToString:@"<null>"] || [(_ref)isEqualToString:@"(null)"]|| [(_ref)isEqualToString:@"null"]||(_ref.length == 0))

/**
 *  NSLog
 */
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//NSCoding协议遵循
#define kObjectCodingAction  -(id)initWithCoder:(NSCoder *)aDecoder\
{\
self = [super init];\
if (self) {\
[self autoDecode:aDecoder];\
\
}\
return self;\
}\
-(void)encodeWithCoder:(NSCoder *)aCoder\
{\
[self autoEncodeWithCoder:aCoder];\
}\
-(void)setValue:(id)value forUndefinedKey:(NSString *)key\
{\
\
}

#define PRICE

#define FREE_PRICE [[NSUserDefaults standardUserDefaults] objectForKey:@"free_price"]
#define FREE_USERNUM [[NSUserDefaults standardUserDefaults] objectForKey:@"free_user_num"]
#define FREE_PRONUM [[NSUserDefaults standardUserDefaults] objectForKey:@"free_pro_num"]
#define FREE_POSNUM [[NSUserDefaults standardUserDefaults] objectForKey:@"free_pos_num"]
#define FREE_CATENUM [[NSUserDefaults standardUserDefaults] objectForKey:@"free_cate_num"]
#define FREE_SKYDRIVERNUM [[NSUserDefaults standardUserDefaults] objectForKey:@"free_sky_drive_num"]

#define VIP_PRICE [[NSUserDefaults standardUserDefaults] objectForKey:@"vip_price"]
#define VIP_USERNUM [[NSUserDefaults standardUserDefaults] objectForKey:@"vip_user_num"]
#define VIP_PRONUM [[NSUserDefaults standardUserDefaults] objectForKey:@"vip_pro_num"]
#define VIP_POSNUM [[NSUserDefaults standardUserDefaults] objectForKey:@"vip_pos_num"]
#define VIP_CATENUM [[NSUserDefaults standardUserDefaults] objectForKey:@"vip_cate_num"]
#define VIP_SKYDRIVERNUM [[NSUserDefaults standardUserDefaults] objectForKey:@"vip_sky_drive_num"]

#define VIP_TYPE [[NSUserDefaults standardUserDefaults] objectForKey:@"vip_type"]


#endif /* CommonDefine_h */
