//
//  CGPayOrderVC.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CGEnterpriseModel.h"

@interface CGPayOrderVC : BaseTableViewController

@property (nonatomic, strong) NSString *wholeSeats;

/**
 账户到期时间
 */
@property (nonatomic, strong) NSString *endTime;

@property (nonatomic, strong) CGEnterpriseModel *model;

@end
