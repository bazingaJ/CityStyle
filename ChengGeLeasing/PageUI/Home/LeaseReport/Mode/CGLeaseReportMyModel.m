//
//  CGLeaseReportMyModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLeaseReportMyModel.h"

@implementation CGLeaseReportMyModel

-(void)setCust_info:(NSDictionary *)cust_info
{
    _cust_InfoModel = [CGLeaseCust_InfoModel mj_objectWithKeyValues:cust_info];
}

-(void)setRank_info:(NSDictionary *)rank_info
{
    _rank_InfoModel = [CGLeaseRank_InfoModel mj_objectWithKeyValues:rank_info];
}

-(void)setIntent_info:(NSDictionary *)intent_info
{
    _intent_InfoModel = [CGLeaseIntent_InfoModel mj_objectWithKeyValues:intent_info];
}

-(void)setSign_info:(NSDictionary *)sign_info
{
    _sign_InfoModel = [CGLeaseSign_InfoModel mj_objectWithKeyValues:sign_info];
}

@end
