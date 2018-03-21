//
//  CGBusinessMattersViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGBusinessMattersViewController : BaseTableViewController

/**
 *  客户ID
 */
@property (nonatomic, strong) NSString *cust_id;
/**
 *  客户名字
 */
@property (nonatomic, strong) NSString *cust_name;
/**
 *  客户封面
 */
@property (nonatomic, strong) NSString *cust_cover;
/**
 *  是否签约
 */
@property (nonatomic, assign) BOOL isSign;
/**
 *  是否是自己
 */
@property (nonatomic, strong) NSString *isMine;
/**
 *  是否从全部客户界面进去
 */
@property (nonatomic, assign) BOOL isAllCust;

@end
