//
//  CGCustomerFunnelModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGCustomerFunnelModel.h"

@implementation CGCustomerFunnelModel

-(void)setStatistics:(NSArray *)statistics
{
    _statistics = [CGFunneStatisticsModel mj_objectArrayWithKeyValuesArray:statistics];
}

-(void)setCustomer:(NSDictionary *)customer
{
    _customerModel = [CGFunnelCustomerModel mj_objectWithKeyValues:customer];
}

@end
