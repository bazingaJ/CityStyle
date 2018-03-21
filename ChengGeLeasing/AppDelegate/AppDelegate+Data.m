//
//  AppDelegate+Data.m
//  Kivii
//
//  Created by 相约在冬季 on 2017/9/26.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import "AppDelegate+Data.h"

@implementation AppDelegate (Data)

/**
 *  获取系统信息
 */
- (CGURLManager *)getSystemInfo {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"getAboutInfo" forKey:@"act"];
    NSDictionary *jsonDic = [HttpRequestEx getSyncWidthURL:SERVICE_URL param:param];
    NSString *code = [jsonDic objectForKey:@"code"];
    if([code isEqualToString:SUCCESS]) {
        NSDictionary *dataDic = [jsonDic objectForKey:@"data"];
        CGURLManager *entity = [CGURLManager manager];
        entity.hotline = [dataDic objectForKey:@"hotline"];
        entity.open_img = [dataDic objectForKey:@"open_img"];
        entity.about_url = [dataDic objectForKey:@"about_url"];
        entity.user_url = [dataDic objectForKey:@"user_url"];
        entity.help_url = [dataDic objectForKey:@"help_url"];
        entity.auth_ios = [dataDic objectForKey:@"auth_ios"];
        
        return entity;
    }
    return [CGURLManager manager];
}

@end
