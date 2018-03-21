//
//  CGEditNotifyBacklogViewController.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGRemindModel.h"
@interface CGEditNotifyBacklogViewController : BaseTableViewController

@property (nonatomic, strong) CGRemindModel *model;
/**
 * 客户id
 */
@property (nonatomic, strong) NSString *cust_id;
/**
 *  客户ID
 */
@property (nonatomic, strong) NSString *cust_name;
/**
 * 1客户 2加号
 */
@property (nonatomic, assign) NSInteger type;

@end
