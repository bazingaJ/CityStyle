//
//  CGMemberAddMobileVC.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/28.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseTableViewController.h"


@interface CGMemberAddMobileVC : BaseTableViewController 
/**
 *  企业ID
 */
@property (nonatomic, strong) NSString *account_id;

/**
 该账户总席位
 */
@property (nonatomic, strong) NSString *wholeCount;

/**
 当前已经有的席位
 */
@property (nonatomic, strong) NSString *nowCount;

@end
