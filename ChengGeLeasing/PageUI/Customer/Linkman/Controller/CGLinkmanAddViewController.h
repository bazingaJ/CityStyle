//
//  CGLinkmanAddViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGLinkmanModel.h"

@interface CGLinkmanAddViewController : BaseTableViewController

/**
 *  客户ID
 */
@property (nonatomic, strong) NSString *cust_id;
/**
 *  联系人对象
 */
@property (nonatomic, strong) CGLinkmanModel *linkModel;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)();

@end
