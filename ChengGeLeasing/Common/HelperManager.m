//
//  HelperManager.m
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import "HelperManager.h"

@implementation HelperManager

/**
 *  创建单例模式
 */
static HelperManager *_createInstance;
+ (HelperManager *)CreateInstance{
    if (!_createInstance){
        _createInstance = [[super allocWithZone:NULL] init];
    }
    return _createInstance;
}
/**
 *  是否已登录
 */
- (BOOL)isLogin {
    if(IsStringEmpty(self.user_id)) {
        return NO;
    }
    return YES;
}
/**
 *  获取用户权限
 */
- (BOOL)userAuth:(NSString *)pro_id completion:(void (^)(NSArray *authArr))completion {
    
    //项目ID验证
    if(IsStringEmpty(pro_id)) {
        [MBProgressHUD showError:@"项目ID不能为空" toView:nil];
        return NO;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"getMyAuth" forKey:@"act"];
    [param setValue:pro_id forKey:@"pro_id"];
    NSDictionary *json = [HttpRequestEx getSyncWidthURL:SERVICE_URL param:param];
    NSString *code = [json objectForKey:@"code"];
    if([code isEqualToString:SUCCESS]) {
        NSDictionary *dataDic = [json objectForKey:@"data"];
        NSString *is_charge = [dataDic objectForKey:@"is_charge"];
        if([is_charge isEqualToString:@"1"]) {
            //是项目负责人
            return YES;
        }else{
            NSString *authStr = [dataDic objectForKey:@"authority"];
            NSArray *itemArr = [authStr componentsSeparatedByString:@","];
            if(completion) {
                completion(itemArr);
            }
            return NO;
        }
    }
    return NO;
    
}

/**
 *  是否登录
 */
- (BOOL)isLogin:(BOOL)isAuth completion:(void (^)(NSInteger tIndex))completion {
    if(![self isLogin]) {
        
        //用户登录
        [APP_DELEGATE userLogin:^(BOOL isLogin)
        {
            if(completion) {
                completion(isLogin);
            }
            
        }];
        
        return NO;
    }
    if(isAuth) {
        //认证处理
        
        return YES;
    }
    return YES;
}
/**
 *  获取用户信息
 */
- (NSDictionary *)getUserDefaultInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [userDefaults objectForKey:@"userInfo"];
    return userDic;
}
/**
 *  用户ID
 */
- (NSString *)user_id {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *user_id = [userDic objectForKey:@"user_id"];
    return user_id;
}
/**
 *  用户昵称
 */
- (NSString *)nickname {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *nickname = [userDic objectForKey:@"nickname"];
    return nickname;
}
/**
 *  用户头像
 */
- (NSString *)avatar {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *icon_src = [userDic objectForKey:@"avatar"];
    return icon_src;
}
/**
 *  手机号码
 */
- (NSString *)mobile {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *mobile = [userDic objectForKey:@"mobile"];
    return mobile;
}
/**
 *  Token验证
 */
- (NSString *)token {
    NSDictionary *userDic = [self getUserDefaultInfo];
    NSString *token = [userDic objectForKey:@"token"];
    return token;
}
/**
 *  清除账号
 */
- (void)clearAcc {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"userInfo"];
    [userDefault removeObjectForKey:@"proId"];
    [userDefault removeObjectForKey:@"proName"];
    [userDefault synchronize];
    
}
/**
 *  获取APP版本号
 */
- (NSString *)getAppVersion {
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}
/**
 *  获取APP名称
 */
- (NSString *)getAppName {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDic objectForKey:@"CFBundleDisplayName"];
    return appName;
}
/**
 *  获取IDFA
 */
- (NSString *)getIDFA {
    //广告表示ID
    NSString *idfaStr = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    idfaStr = [idfaStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return idfaStr;
}
/**
 *  支付支付穿处理
 */
- (NSDictionary *)dictionaryFromURLParameters:(NSString *)str {
    NSArray *pairs = [str componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val = [[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        val = [val stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        [params setObject:val forKey:[kv objectAtIndex:0]];
    }
    return params;
}
/**
 *  获取账号等级
 */
- (BOOL)isFree
{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *level = [userDefaults objectForKey:@"level"];
    return NO;
//    return YES;
}
/**
 *  获取项目ID
 */
- (NSString *)proId {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *proId = [userDefaults objectForKey:@"proId"];
    return proId;
}
/**
 *  获取项目名称
 */
- (NSString *)proName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *proName = [userDefaults objectForKey:@"proName"];
    
    //如果超出6个字进行截取
    if(proName.length>6) {
        proName = [proName substringToIndex:6];
    }
    
    return proName;
}

@end
