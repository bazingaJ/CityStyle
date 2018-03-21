//
//  CGMineTeamListViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMineTeamXiangmuCell.h"

@interface CGMineTeamListViewController : BaseTableViewController<SWTableViewCellDelegate>

/**
 *  类型:1我创建的 2我加入的 3我曾经加入的 
 */
@property (nonatomic, assign) NSInteger type;
/**
 *  刷新项目列表
 */
- (void)reloadXiangmuList;

@end
