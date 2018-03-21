//
//  CGMineReceiverViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMineReceiverCell.h"

@interface CGMineReceiverViewController : BaseTableViewController<CGMineReceiverCellDelegate>

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;
/**
 *  人员ID
 */
@property (nonatomic, strong) NSString *member_id;
/**
 *  交接客户ID集合
 */
@property (nonatomic, strong) NSString *customerStr;

@end
