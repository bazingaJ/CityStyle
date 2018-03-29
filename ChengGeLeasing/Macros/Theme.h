//
//  Theme.h
//  liangmaitong
//
//  Created by 相约在冬季 on 2017/1/14.
//  Copyright © 2017年 liangmaitong. All rights reserved.
//

#ifndef Theme_h
#define Theme_h

#pragma mark -  * * * * * * * * * * * * * * 设置主题 * * * * * * * * * * * * * *

/**
 *  无色
 */
#define CLEAR_COLOR [UIColor clearColor]
/**
 *  主题背景色
 */
#define BACK_COLOR UIColorFromRGBWith16HEX(0xF2F6F8)
/**
 *  导航蓝颜色
 */
#define NAV_COLOR UIColorFromRGBWith16HEX(0x2E374F)
/**
 *  默认白色
 */
#define WHITE_COLOR UIColorFromRGBWith16HEX(0Xffffff)
/**
 *  主题颜色
 */
#define MAIN_COLOR UIColorFromRGBWith16HEX(0x789BD4)
/**
 *  蓝色
 */
#define BLUE_COLOR UIColorFromRGBWith16HEX(0x4588EC)
/** 
 *  绿色
 */
#define GREEN_COLOR UIColorFromRGBWith16HEX(0x91E1DA)
/**
 *  橙色
 */
#define ORANGE_COLOR UIColorFromRGBWith16HEX(0xDDB76A)
/**
 *  红色
 */
#define RED_COLOR UIColorFromRGBWith16HEX(0xE2566A)
/**
 *  分割线灰色
 */
#define LINE_COLOR UIColorFromRGBWith16HEX(0xe4e4e4)
/**
 *  灰色背景
 */
#define GRAY_COLOR UIColorFromRGBWith16HEX(0xF1F1F1)
/**
 *  遮盖半透明色
 */
#define COVER_COLOR [UIColorFromRGBWith16HEX(0X000000) colorWithAlphaComponent:0.4]
/**
 *  主要字体颜色
 */
#define COLOR3 UIColorFromRGBWith16HEX(0X333333)
/**
 *  次要字体颜色
 */
#define COLOR6 UIColorFromRGBWith16HEX(0X666666)
/**
 *  辅助字体颜色
 */
#define COLOR9 UIColorFromRGBWith16HEX(0X999999)
/**
 *  占位文字颜色
 */
#define HOLDER_COLOR UIColorFromRGBWith16HEX(0X676767)
/**
 *  颜色
 */
#define COLORM UIColorFromRGBWith16HEX(0X416A7B)


#pragma mark -  * * * * * * * * * * * * * * 设置字体 * * * * * * * * * * * * * *

/**
 *  7号字体
 */
#define FONT7 SYSTEM_FONT_SIZE(7)
/**
 *  8号字体
 */
#define FONT8 SYSTEM_FONT_SIZE(8)
/**
 *  9号字体
 */
#define FONT9 SYSTEM_FONT_SIZE(9)
/**
 *  10号字体
 */
#define FONT10 SYSTEM_FONT_SIZE(10)
/**
 *  11号字体
 */
#define FONT11 SYSTEM_FONT_SIZE(11)
/**
 *  12号字体
 */
#define FONT12 SYSTEM_FONT_SIZE(12)
/**
 *  13号字体
 */
#define FONT13 SYSTEM_FONT_SIZE(13)
/**
 *  14号字体
 */
#define FONT14 SYSTEM_FONT_SIZE(14)
/**
 *  15号字体
 */
#define FONT15 SYSTEM_FONT_SIZE(15)
/**
 *  16号字体
 */
#define FONT16 SYSTEM_FONT_SIZE(16)
/**
 *  17号字体
 */
#define FONT17 SYSTEM_FONT_SIZE(17)
/**
 *  18号字体
 */
#define FONT18 SYSTEM_FONT_SIZE(18)
/**
 *  20号字体
 */
#define FONT20 SYSTEM_FONT_SIZE(20)
/**
 *  24号字体
 */
#define FONT24 SYSTEM_FONT_SIZE(24)
/**
 *  字体-宏定义
 */
#define SYSTEM_FONT_SIZE(F) [UIFont systemFontOfSize:F] //[UIFont fontWithName:@"HiraginoSansGB-W3" size:F]

//十六进制颜色
#define UIColorFromRGBWith16HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define kRGB_alpha(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//=========================微信=====================\\

#define WetChatAppID        @"wx2b33ffa189d5bc6f"
#define WetChatAppSecret    @"26f045af7a090b0b7a35bf3fa5fbdd50"
//=========================支付宝=====================\\

#define AliPayAppID         @""
#define AliPartnerID        @""
#define AliSellerID         @""

#endif /* Theme_h */
