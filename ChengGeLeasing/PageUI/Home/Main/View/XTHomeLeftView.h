//
//  XTHomeLeftView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGLeftViewCell.h"
#import "CGMTableView.h"

@interface XTHomeLeftView : UIView<JXMovableCellTableViewDataSource, JXMovableCellTableViewDelegate>

@property (nonatomic, strong) CGMTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

/**
 *  数据回调函数
 */
@property (nonatomic, copy) void(^didClickItem)(XTHomeLeftView *view, CGTeamXiangmuModel *model,NSInteger index);
/**
 *  创建项目回调函数
 */
@property (nonatomic, copy) void(^didXiangmuClick)(XTHomeLeftView *view,NSString *myProNum);

@end
