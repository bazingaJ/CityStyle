//
//  NSString+Extension.h
//  liangmaitong
//
//  Created by 相约在冬季 on 2017/1/14.
//  Copyright © 2017年 liangmaitong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  给金额字符串添加分割标示，例：33，345，434.98
 */
+(NSString *)ResetAmount:(NSString *)Amount_str segmentation_index:(int)segmentation_index segmentation_str:(NSString *)segmentation_str;

/**
 *  获取字符串MD5加密
 */
- (NSString *)MD5string;

/**
 *  判断字符串是否为空
 */
+(BOOL)isNULL:(id)string;
/**
 *  判断是否是中文
 */
- (BOOL)isChinese;
/**
 *  判断是否是EMail
 */
- (BOOL)isEmail;
/**
 *  判断是否是手机号码
 */
- (BOOL)isPhoneNumber;
/**
 *  身份证号验证
 */
- (BOOL)IsIdentityCard;
/**
 *  判断是否是数字
 */
- (BOOL)isDigit;
/**
 *  判断是否是数字
 */
- (BOOL)isNumeric;
/**
 *  判断是否是URL
 */
- (BOOL)isUrl;
/**
 *  判断字符串字符个数限制
 */
- (BOOL)isMinLength:(NSUInteger)min andMaxLength:(NSUInteger)max;
/**
 *  判断是否为空
 */
- (BOOL)isEmpty;

//过滤表情符
+ (BOOL)stringContainsEmoji:(NSString *)string;

@end
