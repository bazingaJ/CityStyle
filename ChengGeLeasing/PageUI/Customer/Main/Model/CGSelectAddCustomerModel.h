//
//  CGSelectAddCustomerModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGSelectAddCustomerModel : NSObject
/**
 * 客户id
 */
@property (nonatomic, strong) NSString *cust_id;
/**
 * 首字母
 */
@property (nonatomic, strong) NSString *first_letter;
/**
 * 项目名称
 */
@property (nonatomic, strong) NSString *name;
/**
 * 业态ID
 */
@property (nonatomic, strong) NSString *cate_id;
/**
 * 业态名称
 */
@property (nonatomic, strong) NSString *cate_name;
/**
 * logo
 */
@property (nonatomic, strong) NSString *logo;
/**
 * 联系人数组
 */
@property (nonatomic, strong) NSArray *linkman_list;
/**
 * 联系人id
 */
@property (nonatomic, strong) NSString *linkman_id;
/**
 * 联系人名字
 */
@property (nonatomic, strong) NSString *linkman_name;
/**
 * 联系人手机号
 */
@property (nonatomic, strong) NSString *linkman_mobile;
@end
