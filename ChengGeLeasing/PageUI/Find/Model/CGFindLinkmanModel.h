//
//  CGFindLinkmanModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/19.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  资源库联系人-模型
 */
@interface CGFindLinkmanModel : NSObject

/**
 *  联系人ID
 */
@property (nonatomic, strong) NSString *id;
/**
 *  联系人姓名
 */
@property (nonatomic, strong) NSString *name;
/**
 *  性别:1男 2女 3未知
 */
@property (nonatomic, strong) NSString *sex;
/**
 *  性别名称
 */
@property (nonatomic, strong) NSString *sex_name;
/**
 *  电话
 */
@property (nonatomic, strong) NSString *real_tel;
/**
 *  职位
 */
@property (nonatomic, strong) NSString *job;
/**
 *  邮箱
 */
@property (nonatomic, strong) NSString *email;

@end
