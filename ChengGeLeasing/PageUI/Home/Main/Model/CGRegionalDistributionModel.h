//
//  CGRegionalDistributionModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/19.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGRegionalDistributionModel : NSObject
/**
 * list
 */
@property (nonatomic, strong) NSArray *list;
/**
 * 统计数据
 */
@property (nonatomic, strong) NSDictionary *statistics;

@end

@interface CGRegionalDistributionListModel : NSObject

/**
 * 铺位ID
 */
@property (nonatomic, strong) NSString *id;
/**
 * 铺位名称
 */
@property (nonatomic, strong) NSString *name;
/**
 * 铺位面积
 */
@property (nonatomic, strong) NSString *area;
/**
 * 铺位状态 1无意向 2有意向 3已签约
 */
@property (nonatomic, strong) NSString *pos_status;
/**
 * 铺位状态名称
 */
@property (nonatomic, strong) NSString *pos_status_name;

@end
