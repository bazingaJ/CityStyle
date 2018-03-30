//
//  CGOrderListModel.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/29.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGOrderListModel : NSObject


/**
 订单标题
 */
@property (nonatomic, strong) NSString *title;

/**
 订单号
 */
@property (nonatomic, strong) NSString *order_num;

/**
 席位数量
 */
@property (nonatomic, strong) NSString *member_num;

/**
 订单时长
 */
@property (nonatomic, strong) NSString *vip_time;

/**
 订单金额
 */
@property (nonatomic, strong) NSString *total_price;

/**
 订单ID
 */
@property (nonatomic, strong) NSString *order_id;

/**
 订单单价
 */
@property (nonatomic, strong) NSString *price;

/**
 订单类型 1.升级 2.续费 3.席位购买
 */
@property (nonatomic, strong) NSString *type;

/**
 购买用户ID
 */
@property (nonatomic, strong) NSString *user_id;

/**
 购买用户名
 */
@property (nonatomic, strong) NSString *user_name;

/**
 VIP用户的类型 1.个人免费版 2.基础VIP版
 */
@property (nonatomic, strong) NSString *vip_type;

/**
 VIP用户的类型名称
 */
@property (nonatomic, strong) NSString *vip_type_name;

/**
 订单时间
 */
@property (nonatomic, strong) NSString *add_date;
@end
