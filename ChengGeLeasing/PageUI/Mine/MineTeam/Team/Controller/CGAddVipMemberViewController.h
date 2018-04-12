//
//  CGAddVipMemberViewController.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/4/2.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "BaseTableViewController.h"

@interface CGAddVipMemberViewController : BaseTableViewController
@property (nonatomic, strong) NSString *pro_id;
@property (nonatomic, strong) NSString *account_id;
/**
 之前就有的成员
 */
@property (nonatomic, strong) NSMutableArray *selectdArr;

/**
 1.添加 2.移除
 */
@property (nonatomic, strong) NSString *isAdd;
@end
