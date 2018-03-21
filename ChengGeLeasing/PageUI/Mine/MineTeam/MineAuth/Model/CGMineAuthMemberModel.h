//
//  CGMineAuthMemberModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  权限人员-模型
 */
@interface CGMineAuthMemberModel : NSObject

/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *user_id;
/**
 *  用户名称
 */
@property (nonatomic, strong) NSString *user_name;
/**
 *  已有权限数量
 */
@property (nonatomic, strong) NSString *auth_num;
/**
 *  已有权限ID 多个逗号分隔
 */
@property (nonatomic, strong) NSString *auth;
/**
 *  已有权限ID集合
 */
@property (nonatomic, strong) NSMutableArray *authArr;

@end
