//
//  CGBuySeatVC.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CGLevelUpCell.h"
#import "CGPaymentVC.h"
#import "CGRenewModel.h"
#import "CGRenewModel.h"
#import "Order.h"
#import "RSADataSigner.h"

@interface CGBuySeatVC : BaseTableViewController<JXLevelUpDelegate,WXApiDelegate>

/**
 账户到期时间
 */
@property (nonatomic, strong) NSString *endTime;

@property (nonatomic, strong) NSString *account_id;

@end
