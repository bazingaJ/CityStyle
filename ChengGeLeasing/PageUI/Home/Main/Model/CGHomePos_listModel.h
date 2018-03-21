//
//  CGHomePos_listModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/15.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGHomePos_listModel : NSObject
/**
 * 铺位ID
 */
@property (nonatomic ,strong) NSString *pos_id;
/**
 * 铺位名称
 */
@property (nonatomic ,strong) NSString *pos_name;
/**
 * 铺位面积
 */
@property (nonatomic ,strong) NSString *pos_area;
/**
 * 铺位状态 1无意向 2有意向 3已签约 4已付款
 */
@property (nonatomic ,strong) NSString *pos_status;
/**
 * 经营状态 1空置 2稳赢 3预动 4退铺
 */
@property (nonatomic ,strong) NSString *pos_operate_status;
/**
 * 签约的客户ID
 */
@property (nonatomic ,strong) NSString *cust_id;
/**
 * 签约的客户名称
 */
@property (nonatomic ,strong) NSString *cust_name;
/**
 * 签约的客户首字母
 */
@property (nonatomic ,strong) NSString *cust_first_letter;
/**
 * 签约的客户LOGO
 */
@property (nonatomic ,strong) NSString *cust_logo;
/**
 * 是否为自己的客户 1是2否
 */
@property (nonatomic ,strong) NSString *is_owner;

@end
