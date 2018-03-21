//
//  CGMineTeamAreaSelectedViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGMineTeamAreaSelectedViewController : BaseTableViewController

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSString *group_id, NSString *group_name);

@end
