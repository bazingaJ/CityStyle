//
//  CGMineTeamAreaViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMineTeamAreaCell.h"
#import "CGMTableView.h"

@interface CGMineTeamAreaViewController : BaseViewController<JXMovableCellTableViewDataSource, JXMovableCellTableViewDelegate,CGMineTeamAreaCellDelegate>

@property (nonatomic, strong) CGMTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;

@end
