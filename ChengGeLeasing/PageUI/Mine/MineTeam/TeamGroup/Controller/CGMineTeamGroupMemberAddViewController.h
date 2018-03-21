//
//  CGMineTeamGroupMemberAddViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMineSearchBarView.h"

@interface CGMineTeamGroupMemberAddViewController : BaseTableViewController<CGMineSearchBarViewDelegate>

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;
@property (nonatomic, strong) NSMutableArray *selectedArr;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSMutableArray *memberArr);

@end
