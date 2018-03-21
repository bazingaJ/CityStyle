//
//  CGCustomerInfoExViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGCustomerInfoExViewController : BaseTableViewController

/**
 *  客户ID
 */
@property (nonatomic, strong) NSString *cust_id;
/**
 *  是否为我的客户:1是 2否
 */
@property (nonatomic, strong) NSString *isMine;

@end
