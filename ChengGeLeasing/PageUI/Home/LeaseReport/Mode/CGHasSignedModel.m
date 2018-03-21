//
//  CGHasSignedModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGHasSignedModel.h"

@implementation CGHasSignedModel

-(void)setStatistics:(NSDictionary *)statistics
{
    _statisticsModel = [CGStatisticsModel mj_objectWithKeyValues:statistics];
}

-(void)setCustomer:(NSDictionary *)customer
{
    _customerModel = [CGHasSignedCustomerModel mj_objectWithKeyValues:customer];
}

@end
