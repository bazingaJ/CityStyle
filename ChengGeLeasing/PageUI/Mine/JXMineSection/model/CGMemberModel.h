//
//  CGMemberModel.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGMemberModel : NSObject


/**
 用户id
 */
@property (nonatomic, strong) NSString *member_id;

/**
 成员姓名
 */
@property (nonatomic, strong) NSString *name;

/**
 升级时间
 */
@property (nonatomic, strong) NSString *add_date;

/**
 角色 (1.管理员 2.普通成员)
 */
@property (nonatomic, strong) NSString *type;

/**
 角色名称
 */
@property (nonatomic, strong) NSString *type_name;

/**
 是否是购买者( 1.是 2.否)
 */
@property (nonatomic, strong) NSString *is_owner;

/**
 成员号码
 */
@property (nonatomic, strong) NSString *mobile;

/**
 成员头像
 */
@property (nonatomic, strong) NSString *avatar;

/**
 团队成员id
 */
@property (nonatomic, strong) NSString *group_mem_id;

@end
