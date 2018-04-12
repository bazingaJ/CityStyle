//
//  CGEnterpriseModel.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/31.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGEnterpriseModel : NSObject

/**
 账户名称
 */
@property (nonatomic , copy) NSString              * account_name;

/**
 现有成员数
 */
@property (nonatomic , copy) NSString              * group_num;

/**
 总成员数
 */
@property (nonatomic , copy) NSString              * account_num;

/**
 账户。。。
 */
@property (nonatomic , copy) NSString              * account_no;

/**
 是否是管理员 1.是  2.不是
 */
@property (nonatomic , copy) NSString              * is_admin;

/**
 是否是创建者 1.是  2.不是
 */
@property (nonatomic , copy) NSString              * is_owner;

/**
 到期日期
 */
@property (nonatomic , copy) NSString              * end_date;

/**
 企业账户ID
 */
@property (nonatomic , copy) NSString              * account_id;

@end
