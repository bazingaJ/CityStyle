//
//  CGUserModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用户-模型
 */
@interface CGUserModel : NSObject

/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *user_id;
/**
 *  token
 */
@property (nonatomic, strong) NSString *token;
/**
 *  昵称
 */
@property (nonatomic, strong) NSString *nickname;
/**
 *  手机号
 */
@property (nonatomic, strong) NSString *mobile;
/**
 *  头像
 */
@property (nonatomic, strong) NSString *avatar;
/**
 *  性别:1男 2女 3未知
 */
@property (nonatomic, strong) NSString *gender;
/**
 *  性别名称
 */
@property (nonatomic, strong) NSString *gender_name;
/**
 *  邮箱
 */
@property (nonatomic, strong) NSString *email;
/**
 *  会员类型
 */
@property (nonatomic, strong) NSString *vip_type;
/**
 *  到期时间
 */
@property (nonatomic, strong) NSString *end_time;
/**
 *  是否过期
 */
@property (nonatomic, strong) NSString *is_over;

@end
