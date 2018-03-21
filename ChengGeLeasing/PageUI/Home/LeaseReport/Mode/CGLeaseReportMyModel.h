//
//  CGLeaseReportMyModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGLeaseCust_InfoModel.h"
#import "CGLeaseRank_InfoModel.h"
#import "CGLeaseSign_InfoModel.h"
#import "CGLeaseIntent_InfoModel.h"
@interface CGLeaseReportMyModel : NSObject

@property (nonatomic, assign) CGFloat cellHeight;

/**
 * 客户漏斗
 */
@property (nonatomic, strong) NSDictionary *cust_info;
@property (nonatomic, strong) CGLeaseCust_InfoModel *cust_InfoModel;
/**
 * 工作简报
 */
@property (nonatomic, strong) NSDictionary *intent_info;
@property (nonatomic, strong) CGLeaseIntent_InfoModel *intent_InfoModel;
/**
 * 工作排名
 */
@property (nonatomic, strong) NSDictionary *rank_info;
@property (nonatomic, strong) CGLeaseRank_InfoModel *rank_InfoModel;
/**
 * 签约信息
 */
@property (nonatomic, strong) NSDictionary *sign_info;
@property (nonatomic, strong) CGLeaseSign_InfoModel *sign_InfoModel;
@end
