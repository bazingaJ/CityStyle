//
//  CGTeamBunkViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGTeamBunkCell.h"

@interface CGTeamBunkViewController : BaseTableViewController<CGTeamBunkCellDelegate>

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;

@end
