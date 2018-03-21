//
//  CGShopBusinessMattersModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGShopBusinessMattersHistoryListModel.h"
#import "CGShopBusinessMattersOperateListModel.h"
#import "CGShopBusinessMattersIntentModel.h"
@interface CGShopBusinessMattersModel : NSObject
/**
 * 区域ID
 */
@property (nonatomic, strong) NSString *group_id;
/**
 * 区域名称
 */
@property (nonatomic, strong) NSString *group_name;
/**
 * 铺位名称
 */
@property (nonatomic, strong) NSString *name;
/**
 * 面积
 */
@property (nonatomic, strong) NSString *area;
/**
 * 经营状态 1空置 2稳赢 3预动 4退铺
 */
@property (nonatomic, strong) NSString *operate_status;
/**
 * 经营状态名称
 */
@property (nonatomic, strong) NSString *operate_status_name;
/**
 * 历史租户
 */
@property (nonatomic, strong) NSArray *history_list;
/**
 * 经营动态列表
 */
@property (nonatomic, strong) NSArray *operate_list;
/**
 * 意向租户列表
 */
@property (nonatomic, strong) NSArray *intent_list;
/**
 *  当前租户ID
 */
@property (nonatomic, strong) NSString *sign_cust_id;
/**
 *  当前租户名称
 */
@property (nonatomic, strong) NSString *sign_cust_name;
/**
 *  当前租户首字母
 */
@property (nonatomic, strong) NSString *sign_cust_first_letter;
/**
 *  当前租户LOGO
 */
@property (nonatomic, strong) NSString *sign_cust_logo;
/**
 *  当前租户意向度
 */
@property (nonatomic, strong) NSString *sign_cust_intent;

@property (nonatomic, assign) BOOL isShow3;
@property (nonatomic, assign) BOOL isShow2;
@property (nonatomic, assign) NSInteger numLine2;
@property (nonatomic, assign) CGFloat sectionH2;
@property (nonatomic, assign) CGFloat sectionH3;
@property (nonatomic, assign) NSInteger numLine3;
@end
