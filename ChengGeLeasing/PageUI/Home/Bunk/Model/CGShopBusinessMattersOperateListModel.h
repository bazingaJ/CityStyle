//
//  CGShopBusinessMattersOperateListModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/19.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGShopBusinessMattersOperateListModel : NSObject
/**
 * 动态ID
 */
@property (nonatomic, strong) NSString *id;
/**
 * 客户ID
 */
@property (nonatomic, strong) NSString *cust_id;
/**
 * 客户名称
 */
@property (nonatomic, strong) NSString *cust_name;
/**
 * 首字母
 */
@property (nonatomic, strong) NSString *cust_first_letter;
/**
 * logo
 */
@property (nonatomic, strong) NSString *cust_logo;
/**
 * 联系人ID
 */
@property (nonatomic, strong) NSString *linkman_id;
/**
 * 联系人姓名
 */
@property (nonatomic, strong) NSString *linkman_name;
/**
 * 经营状态 1空置 2稳赢 3预动 4退铺
 */
@property (nonatomic, strong) NSString *status;
/**
 * 经营状态 名称
 */
@property (nonatomic, strong) NSString *status_name;
/**
 * 详情
 */
@property (nonatomic, strong) NSString *intro;
/**
 * 添加时间
 */
@property (nonatomic, strong) NSString *add_time;
/**
 * cell高度
 */
@property (nonatomic, assign) CGFloat cellHeight;
/**
 * 是否是自己
 */
@property (nonatomic, strong) NSString *is_own;
/**
 * 意向度
 */
@property (nonatomic, strong) NSString *intent;

@end
