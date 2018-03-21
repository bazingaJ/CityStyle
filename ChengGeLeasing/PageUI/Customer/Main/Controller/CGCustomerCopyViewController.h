//
//  CGCustomerCopyViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/21.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGCustomerCopyViewController : BaseTableViewController

/**
 *  原项目ID(复制客户用)
 */
@property (nonatomic, strong) NSString *old_proId;
/**
 *  客户ID
 */
@property (nonatomic, strong) NSString *cust_id;
/**
 *  所选择项目ID
 */
@property (nonatomic, strong) NSString *proId;
/**
 *  所选择项目名称
 */
@property (nonatomic, strong) NSString *proName;

/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)();

@end
