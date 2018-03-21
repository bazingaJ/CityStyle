//
//  BaseTableViewController.h
//  wulian_user
//
//  Created by 相约在冬季 on 2017/6/1.
//  Copyright © 2017年 wlqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) CGFloat topH;
@property (nonatomic, assign) CGFloat bottomH;

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger totalNum;

/**
 *  是否隐藏顶部刷新
 */
@property (nonatomic, assign) BOOL hiddenHeaderRefresh;
/**
 *  是否隐藏底部刷新
 */
@property (nonatomic, assign) BOOL showFooterRefresh;
/**
 *  获取数据信息
 */
- (void)getDataList:(BOOL)isMore;
/**
 *  结束刷新
 */
- (void)endDataRefresh;

@end
