//
//  BaseTableViewController.m
//  wulian_user
//
//  Created by 相约在冬季 on 2017/6/1.
//  Copyright © 2017年 wlqq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

/**
 *  创建“tableView”
 */
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _topH, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-_topH-_bottomH) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = BACK_COLOR;
        [self.view addSubview:_tableView];
        
        //顶部刷新
        if(!self.hiddenHeaderRefresh) {
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [self.dataArr removeAllObjects];
                self.pageIndex = 1;
                [self getDataList:NO];
            }];
            [self.tableView.mj_header beginRefreshing];
        }
        
        //底部刷新
        if(self.showFooterRefresh) {
            self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                self.pageIndex++;
                if (self.dataArr.count >= self.totalNum) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    return ;
                }
                [self getDataList:YES];
            }];
        }
    }
    return _tableView;
}

/**
 *  懒加载
 */
- (NSMutableArray *)dataArr {
    if(!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(!_topH) {
        _topH = 0;
    }
    if(!_bottomH) {
        _bottomH = 0;
    }
    
    if(!self.hiddenHeaderRefresh) {
        self.hiddenHeaderRefresh = NO;
    }
    
//    if(!self.hiddenFooterRefresh) {
//        self.hiddenFooterRefresh = YES;
//    }

    //初始化“tableView”
    [self tableView];
    
}

- (void)setHiddenHeaderRefresh:(BOOL)hiddenHeaderRefresh {
    _hiddenHeaderRefresh = hiddenHeaderRefresh;
}

- (void)setShowFooterRefresh:(BOOL)showFooterRefresh {
    _showFooterRefresh = showFooterRefresh;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

/**
 *  获取数据信息
 */
- (void)getDataList:(BOOL)isMore {
    NSLog(@"数据加载...");
}

/**
 *  结束刷新
 */
- (void)endDataRefresh {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
