//
//  CGHasSignedModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGStatisticsModel.h"
#import "CGHasSignedCustomerModel.h"
@interface CGHasSignedModel : NSObject
/**
 * 数据统计
 */
@property (nonatomic, strong) NSDictionary *statistics;
@property (nonatomic, strong) CGStatisticsModel *statisticsModel;
/**
 * 客户
 */
@property (nonatomic, strong) NSDictionary *customer;
@property (nonatomic, strong) CGHasSignedCustomerModel *customerModel;
@end
