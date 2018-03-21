//
//  CGLeaseMattersViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGLeaseMattersViewController : BaseTableViewController

/**
 *  客户ID
 */
@property (nonatomic, strong) NSString *cust_id;
/**
 *  客户名称
 */
@property (nonatomic, strong) NSString *cust_name;
/**
 *  是否签约
 */
@property (nonatomic, strong) NSString *isMine;
/**
 *  type 4是储备客户
 */
@property (nonatomic, assign) NSInteger type;
/**
 *  是否从全部客户界面进去
 */
@property (nonatomic, assign) BOOL isAllCust;

@end
