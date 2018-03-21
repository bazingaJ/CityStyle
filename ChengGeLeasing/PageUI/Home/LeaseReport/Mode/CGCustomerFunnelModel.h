//
//  CGCustomerFunnelModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGFunneStatisticsModel.h"
#import "CGFunnelCustomerModel.h"
@interface CGCustomerFunnelModel : NSObject
/**
 * 数据统计
 */
@property (nonatomic, strong) NSArray *statistics;
/**
 * 客户
 */
@property (nonatomic, strong) NSDictionary *customer;
@property (nonatomic, strong) CGFunnelCustomerModel *customerModel;
@end
