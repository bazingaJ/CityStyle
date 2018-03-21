//
//  CGOperationDynamicModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGOperationDynamicModel : NSObject

/**
 * 总铺位数量
 */
@property (nonatomic ,strong) NSString * total;
/**
 * 空置数据
 */
@property (nonatomic ,strong) NSDictionary * empty;
/**
 * 稳赢数据
 */
@property (nonatomic ,strong) NSDictionary * profit;
/**
 * 预动数据
 */
@property (nonatomic ,strong) NSDictionary * togo;
/**
 * 退铺数据
 */
@property (nonatomic ,strong) NSDictionary * out;
/**
 * 铺位租控
 */
@property (nonatomic ,strong) NSArray * position;

@end

@interface CGOperationDynamicPositionModel : NSObject

/**
 * 面积
 */
@property (nonatomic ,strong) NSString * area;
/**
 * 客户首字
 */
@property (nonatomic ,strong) NSString * cust_first_letter;
/**
 * 客户ID
 */
@property (nonatomic ,strong) NSString * cust_id;
/**
 * 客户log0
 */
@property (nonatomic ,strong) NSString * cust_logo;
/**
 * 客户名字
 */
@property (nonatomic ,strong) NSString * cust_name;
/**
 * 铺位id
 */
@property (nonatomic ,strong) NSString * id;
/**
 * 铺位名称
 */
@property (nonatomic ,strong) NSString * name;
/**
 * 铺位状态 1无意向 2有意向 3已签约
 */
@property (nonatomic ,strong) NSString * operate_status;
/**
 * 铺位状态 1无意向 2有意向 3已签约
 */
@property (nonatomic ,strong) NSString * status;
/**
 * 是否是自己
 */
@property (nonatomic ,strong) NSString *is_mine;



@end
