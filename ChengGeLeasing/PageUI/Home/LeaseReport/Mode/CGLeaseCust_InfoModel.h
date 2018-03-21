//
//  CGLeaseCust_InfoModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGLeaseCust_InfoModel : NSObject
/**
 * 添加时间
 */
@property (nonatomic, strong) NSString *add_time;
/**
 * 业态名称
 */
@property (nonatomic, strong) NSString *cust_cate_name;
/**
 * 客户名字
 */
@property (nonatomic, strong) NSString *cust_name;
/**
 * 客户总数
 */
@property (nonatomic, strong) NSString *cust_num_total;
/**
 * 本周数
 */
@property (nonatomic, strong) NSString *cust_num_week;
/**
 * 联系人名称
 */
@property (nonatomic, strong) NSString *linkman_name;

@end
