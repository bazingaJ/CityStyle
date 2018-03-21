//
//  DESManager.h
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESManager : NSObject

/**
 *  DES解密
 *
 *  @author zongjl
 *  @date 2016-12-16
 */
+ (NSString *) encryptUseDES:(NSString *)encryptStr;

/**
 *  DES加密
 *
 *  @author zongjl
 *  @date 2016-12-16
 */
+ (NSString *) decryptUseDES:(NSString *)decryptStr;

/**
 *  数据DES加密
 *
 *  @author zongjl
 *  @date 2016-12-16
 */
+ (NSData *)encryptUseDESWithData:(NSData *)data;

@end
