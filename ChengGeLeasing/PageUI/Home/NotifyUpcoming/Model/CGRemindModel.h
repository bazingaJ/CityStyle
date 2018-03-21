//
//  CGRemindModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/21.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGRemindModel : NSObject

/**
 * 详情
 */
@property (nonatomic, strong) NSString *content;
/**
 * 客户id
 */
@property (nonatomic, strong) NSString *cust_id;
/**
 * 客户名字
 */
@property (nonatomic, strong) NSString *cust_name;
/**
 * 待办id
 */
@property (nonatomic, strong) NSString *id;
/**
 * 1是否已办 2否
 */
@property (nonatomic, strong) NSString *is_do;
/**
 * 联系人名字
 */
@property (nonatomic, strong) NSString *linkman_name;
/**
 * 联系人id
 */
@property (nonatomic, strong) NSString *linkman_id;
/**
 * 时间
 */
@property (nonatomic, strong) NSString *time;
/**
 * 提醒时间名字
 */
@property (nonatomic, strong) NSString *type_name;
/**
 * 提醒时间id
 */
@property (nonatomic, strong) NSString *type;
/**
 * 周几
 */
@property (nonatomic, strong) NSString *week;
/**
 * 天
 */
@property (nonatomic, strong) NSString *date_day;
/**
 * 时
 */
@property (nonatomic, strong) NSString *date_min;
/**
 * 高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
