//
//  CGTeamMemberDeleteViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGTeamMemberDeleteViewController.h"
#import "CGMineTeamMemberDeleteCell.h"

@interface CGTeamMemberDeleteViewController () {
    //搜索关键词
    NSString *keywordsStr;
}

@property (nonatomic, strong) CGMineSearchBarView *searchView;

@end

@implementation CGTeamMemberDeleteViewController

/**
 *  懒加载搜索框
 */
- (CGMineSearchBarView *)searchView {
    if(!_searchView) {
        _searchView = [[CGMineSearchBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [_searchView setDelegate:self];
        [self.view addSubview:_searchView];
    }
    return _searchView;
}

- (void)viewDidLoad {
    [self setTopH:45];
    [self setShowFooterRefresh:YES];
    [self setRightButtonItemTitle:@"删除"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"移除成员";
    
    //创建“搜索框”
    [self searchView];
    
}

/**
 *  返回按钮事件
 */
- (void)leftButtonItemClick {
    [super leftButtonItemClick];
    
    if(self.callBack) {
        self.callBack();
    }
}

/**
 *  删除成员事件
 */
- (void)rightButtonItemClick {
    NSLog(@"删除成员");
    [self.searchView.searchBar resignFirstResponder];
    
    NSMutableArray *itemArr = [NSMutableArray array];
    for (int i=0; i<self.dataArr.count; i++) {
        CGTeamMemberModel *model = [self.dataArr objectAtIndex:i];
        if(model.is_selected) {
            [itemArr addObject:model.ID];
        }
    }
    if(!itemArr.count) {
        [MBProgressHUD showError:@"请选择需要移除的成员" toView:self.view];
        return;
    }
    NSString *memberIdStr = [itemArr componentsJoinedByString:@","];
    
    [MBProgressHUD showMsg:@"移除中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"dropUser" forKey:@"act"];
    [param setValue:memberIdStr forKey:@"member"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"移除成功" toView:self.view];
            
            //刷新数据源
            [self.tableView.mj_header beginRefreshing];
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [MBProgressHUD hideHUD:self.view];
    }];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGMineTeamMemberDeleteCell";
    CGMineTeamMemberDeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGMineTeamMemberDeleteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGTeamMemberModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setTeamMemberModel:model];
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchView.searchBar resignFirstResponder];
}

/**
 *  搜索委托代理
 */
- (void)CGMineSearchBarViewClick:(NSString *)searchStr {
    NSLog(@"搜索委托代理:%@",searchStr);
    
    keywordsStr = searchStr;
    
    //获取数据源
    [self.dataArr removeAllObjects];
    
    //清空界面
    [self.tableView beginUpdates];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    
    [self getDataList:NO];
    
}

/**
 *  获取数据源
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getUserListByPro" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [param setValue:keywordsStr forKey:@"keyword"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if([dataDic isKindOfClass:[NSDictionary class]]) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                if([dataArr isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *itemDic in dataArr) {
                        [self.dataArr addObject:[CGTeamMemberModel mj_objectWithKeyValues:itemDic]];
                    }
                }
                
                //当前总数
                NSString *dataNum = [dataDic objectForKey:@"count"];
                if(!IsStringEmpty(dataNum)) {
                    self.totalNum = [dataNum intValue];
                }else{
                    self.totalNum = 0;
                }
            }
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
    }];
    
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
