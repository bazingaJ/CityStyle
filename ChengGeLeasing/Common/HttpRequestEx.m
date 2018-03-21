//
//  HttpRequestEx.m
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import "HttpRequestEx.h"
#import "HelperManager.h"
#import "DESManager.h"
@implementation HttpRequestEx

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
           success:(void (^)(id))success
           failure:(void (^)(NSError *))failure {
    
    //设置版本号
    [params setValue:@"1.0" forKey:@"version"];
    
    //app版本号
    [params setValue:APP_Version forKey:@"app_version"];
    
    //设备来源
    [params setValue:@"1" forKey:@"device"];
    [params setValue:[HelperManager CreateInstance].token forKey:@"token"];
    [params setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    
    //参数DES加密
    NSString *encryptStr = [self encryptDESDictionaryToString:params];
    
    //组织参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:encryptStr forKey:@"APIDATA"];
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    //序列化
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置网络请求超时时间
    manger.requestSerializer.timeoutInterval = 20;
    [manger GET:SERVICE_URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *jsonDic = [self decryptDESStringToDictionary:responseObject];
            if(jsonDic) {
                NSString *code = [jsonDic objectForKey:@"code"];
                if([code isEqualToString:@"300001"]) {
                    //清除缓存的值
                    [[HelperManager CreateInstance] clearAcc];
                    
                    
                }
            }
            success(jsonDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];
    
}

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
            success:(void (^)(id))success
            failure:(void (^)(NSError *))failure {
    
    //设置版本号
    [params setValue:@"1.0" forKey:@"version"];
    
    //app版本号
    [params setValue:APP_Version forKey:@"app_version"];
    
    //设备来源
    [params setValue:@"1" forKey:@"device"];
    [params setValue:[HelperManager CreateInstance].token forKey:@"token"];
    [params setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];

    //参数DES加密
    NSString *encryptStr = [self encryptDESDictionaryToString:params];
    
    //组织参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:encryptStr forKey:@"APIDATA"];
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    //序列化
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置网络请求超时时间
    manger.requestSerializer.timeoutInterval = 20;
    [manger POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //如果请求成功的话将responseObject保存在success Block中
        if (success) {
            NSDictionary *jsonDic = [self decryptDESStringToDictionary:responseObject];
            if(jsonDic) {
                NSString *code = [jsonDic objectForKey:@"code"];
                if([code isEqualToString:@"300001"]) {
                    
                    //清除缓存的值
                    [[HelperManager CreateInstance] clearAcc];
                    
                    [MBProgressHUD showError:@"请登录" toView:nil];
                    
                }
            }
            success(jsonDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];
    
}

/**
 *  上传图片
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
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure {
    
    //设置版本号
    [params setValue:@"1.0" forKey:@"version"];
    
    //app版本号
    [params setValue:APP_Version forKey:@"app_version"];
    
    //设备来源
    [params setValue:@"1" forKey:@"device"];
    [params setValue:[HelperManager CreateInstance].token forKey:@"token"];
    [params setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    
    //参数DES加密
    NSString *encryptStr = [self encryptDESDictionaryToString:params];
    
    //组织参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:encryptStr forKey:@"APIDATA"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    NSMutableSet *contentTypes = [NSMutableSet setWithObjects:@"image/jpg", @"text/html", @"text/json",nil];
    manager.responseSerializer.acceptableContentTypes = contentTypes;
    [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(imgArr && imgArr.count>0) {
            for(NSInteger i=0;i<[imgArr count];i++) {
                NSArray *subArr = imgArr[i];
                NSData *imageData = subArr[1];
                NSString *extName = [self typeForImageData:imageData];
                NSString *imageExt = @"jpg";
                if(extName && [extName length]>0) {
                    NSArray *extArr = [extName componentsSeparatedByString:@"/"];
                    imageExt = extArr[1];
                }
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%@[%zd]",subArr[0],i] fileName:[NSString stringWithFormat:@"fileName[%zd].%@",i,imageExt] mimeType:extName];
            }
            
        }
    }progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress=%@",uploadProgress);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"screenshot operation success!  %@", responseObject);
        if (success) {
            NSDictionary *jsonDic = [self decryptDESStringToDictionary:responseObject];
            
            if(jsonDic) {
                NSString *code = [jsonDic objectForKey:@"code"];
                if([code isEqualToString:@"300001"]) {
                    
                    //清除缓存的值
                    [[HelperManager CreateInstance] clearAcc];
                    
                }
            }
            
            success(jsonDic);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //NSLog(@"Operation Error: %@", error);
        if(failure) {
            failure(error);
        }
    }];
    
}

/**
 *  上传图片
 *
 *  @param path URL地址
 *
 *  @param params 请求参数 (NSDictionary)
 *
 *  @param success 请求成功返回值（NSArray or NSDictionary）
 *
 *  @param failure 请求失败值 (NSError)
 */
#pragma 图片上传
+ (void)postWithImgPath:(NSString *)path
                 params:(NSMutableDictionary *)params
                 imgArr:(NSArray *)imgArr
                success:(void (^)(id json))success
                failure:(void (^)(NSError *error))failure {
    
    //设置版本号
    [params setValue:@"1.0" forKey:@"version"];
    
    //app版本号
    [params setValue:APP_Version forKey:@"app_version"];
    
    //设备来源
    [params setValue:@"1" forKey:@"device"];
    [params setValue:[HelperManager CreateInstance].token forKey:@"token"];
    [params setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    
    NSString *imgKey = [params objectForKey:@"imgKey"];
    if(IsStringEmpty(imgKey)) {
        imgKey = @"images";
    }
    
    //参数DES加密
    NSString *encryptStr = [self encryptDESDictionaryToString:params];
    
    //组织参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:encryptStr forKey:@"APIDATA"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    NSMutableSet *contentTypes = [NSMutableSet setWithObjects:@"image/jpg", @"text/html", @"text/json",@"application/json",nil];
    manager.responseSerializer.acceptableContentTypes = contentTypes;
    [manager POST:path parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(imgArr && imgArr.count>0) {
            for(int i=0;i<imgArr.count;i++) {
                NSData *imageData = imgArr[i];
                NSString *extName = [self typeForImageData:imageData];
                NSString *imageExt = @"jpg";
                if(extName && [extName length]>0) {
                    NSArray *extArr = [extName componentsSeparatedByString:@"/"];
                    imageExt = extArr[1];
                }
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%@[%zd]",imgKey,i] fileName:[NSString stringWithFormat:@"fileName[%zd].%@",i,imageExt] mimeType:extName];
            }
        }
    }progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress=%@",uploadProgress);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"screenshot operation success!  %@", responseObject);
        if (success) {
            NSDictionary *jsonDic = [self decryptDESStringToDictionary:responseObject];
            
            if(jsonDic) {
                NSString *code = [jsonDic objectForKey:@"code"];
                if([code isEqualToString:@"300001"]) {
                    
                    //清除缓存的值
                    [[HelperManager CreateInstance] clearAcc];
                    
                }
            }
            
            success(jsonDic);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //NSLog(@"Operation Error: %@", error);
        if(failure) {
            failure(error);
        }
    }];
}

/**
 * 同步获取数据
 *
 *  @param path URL地址
 *  @param params 请求参数 (NSDictionary)
 *
 * @author zongjl
 * @date 2016-12-16
 */
+ (NSDictionary *)getSyncWidthURL:(NSString *)path
                            param:(NSMutableDictionary *)params {
    //设置版本号
    [params setValue:@"1.0" forKey:@"version"];
    
    //app版本号
    [params setValue:APP_Version forKey:@"app_version"];
    
    //设备来源
    [params setValue:@"1" forKey:@"device"];
    [params setValue:[HelperManager CreateInstance].token forKey:@"token"];
    [params setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    
    //参数DES加密
    NSString *encryptStr = [self encryptDESDictionaryToString:params];
    
    NSURL *url = [NSURL URLWithString:path];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSString *str = [NSString stringWithFormat:@"APIDATA=%@",encryptStr];//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonDic = [self decryptDESStringToDictionary:received];
    
    if(jsonDic) {
        NSString *code = [jsonDic objectForKey:@"code"];
        if([code isEqualToString:@"300001"]) {
            
            //清除缓存的值
            [[HelperManager CreateInstance] clearAcc];
            
        }
    }
    
    return jsonDic;
}

/**
 *  获取文件后缀
 *
 *  @author zongjl
 *  @date 2016-12-16
 */
+ (NSString *)typeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

/**
 *  字符串加密
 *
 *  @author zongjl
 *  @date 2016-12-16
 */
+ (NSString *)encryptDESDictionaryToString:(NSMutableDictionary *)param {
    NSData *data = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"JsonStr:%@",paramStr);
    NSString *encryptStr = [DESManager encryptUseDES:paramStr];
    return encryptStr;
}

/**
 *  解密字符串转换
 *
 *  @author zongjl
 *  @date 2016-12-16
 */
    
+ (NSDictionary *)decryptDESStringToDictionary:(NSData *)responseObject {
    
    NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

    NSString *decryptStr = [DESManager decryptUseDES:responseString];
    
    NSError *jsonError;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:[decryptStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonError];
    return jsonDic;
}

+ (void)getWithURLEx:(NSString *)url
            params:(NSMutableDictionary *)params
           success:(void (^)(id))success
           failure:(void (^)(NSError *))failure
{
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    //序列化
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置网络请求超时时间
    manger.requestSerializer.timeoutInterval = 20;
    [manger GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSError *jsonError;
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonError];
            if(jsonDic) {
                NSString *code = [jsonDic objectForKey:@"code"];
                NSLog(@"code=%@",code);
            }
            success(jsonDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];
    
}

@end
