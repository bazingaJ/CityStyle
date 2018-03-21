//
//  HttpRequestEx.h
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HttpSuccessBlockEx) (id JSON);
typedef void (^HttpFailureBlockEx) (NSError *error);

@interface HttpRequestEx : AFHTTPSessionManager

/**
 *  AFN get请求
 *
 *  @param url URL地址
 *  @param params 请求参数 (NSDictionary)
 *  @param success 请求成功返回值（NSArray or NSDictionary）
 *  @param failure 请求失败值 (NSError)
 *
 *  @author zongjl
 *  @date 2016-12-16
 */
+ (void)getWithURL:(NSString *)url
            params:(NSMutableDictionary *)params
           success:(void (^)(id json))success
           failure:(void (^)(NSError *error))failure;

/**
 *  AFN post请求
 *
 *  @param url URL地址
 *  @param params 请求参数 (NSDictionary)
 *  @param success 请求成功返回值（NSArray or NSDictionary）
 *  @param failure 请求失败值 (NSError)
 *
 *  @author zongjl
 *  @date 2016-12-16
 */
+ (void)postWithURL:(NSString *)url
             params:(NSMutableDictionary *)params
            success:(void (^)(id json))success
            failure:(void (^)(NSError *error))failure;

/**
 *  上传单图
 *
 *  @param url URL地址
 *  @param params 请求参数 (NSDictionary)
 *  @param success 请求成功返回值（NSArray or NSDictionary）
 *  @param failure 请求失败值 (NSError)
 *
 *  @author zongjl
 *  @date 2016-12-16
 */
+ (void)postWithImageURL:(NSString *)url
                 params:(NSMutableDictionary *)params
                 imgArr:(NSMutableArray *)imgArr
                success:(void (^)(id json))success
                failure:(void (^)(NSError *error))failure;

/**
 *  上传多图
 *
 *  @param path URL地址
 *
 *  @param params 请求参数 (NSDictionary)
 *
 *  @param success 请求成功返回值（NSArray or NSDictionary）
 *
 *  @param failure 请求失败值 (NSError)
 */
+ (void)postWithImgPath:(NSString *)path
                 params:(NSMutableDictionary *)params
                 imgArr:(NSArray *)imgArr
                success:(void (^)(id json))success
                failure:(void (^)(NSError *error))failure;

/**
 * 同步获取数据
 *
 *  @param path URL地址
 *  @param params 请求参数 (NSDictionary)
 *
 * @author zongjl
 * @date 2016-12-16
 */
+(NSDictionary *)getSyncWidthURL:(NSString *)path
                           param:(NSMutableDictionary *)params;

+ (void)getWithURLEx:(NSString *)url
              params:(NSMutableDictionary *)params
             success:(void (^)(id))success
             failure:(void (^)(NSError *))failure;

@end
