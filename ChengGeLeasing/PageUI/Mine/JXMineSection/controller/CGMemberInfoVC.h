//
//  CGMemberInfoVC.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseTableViewController.h"

@interface CGMemberInfoVC : BaseTableViewController

/**
 企业ID
 */
@property (nonatomic, strong) NSString *account_id;

/**
 到期时间
 */
@property (nonatomic, strong) NSString *endDate;

/**
 总席位数
 */
@property (nonatomic, strong) NSString *wholeSeatNum;
@end
