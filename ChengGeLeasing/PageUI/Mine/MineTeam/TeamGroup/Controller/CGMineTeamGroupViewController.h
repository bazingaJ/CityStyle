//
//  CGMineTeamGroupViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGMineTeamGroupViewController : BaseTableViewController

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSInteger groupNum);

@end
