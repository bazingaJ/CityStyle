//
//  CGMineTeamGroupMemberAddViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamGroupMemberAddViewController.h"
#import "CGTeamGroupMemberAddCell.h"

@interface CGMineTeamGroupMemberAddViewController () {
    //搜索关键词
    NSString *keywordsStr;
}

@property (nonatomic, strong) CGMineSearchBarView *searchView;

@end

@implementation CGMineTeamGroupMemberAddViewController

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
    [self setRightButtonItemTitle:@"添加"];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.title = @"添加组员";
    
    //创建“搜索框”
    [self searchView];
    
}

/**
 *  添加成员事件
 */
- (void)rightButtonItemClick {
    NSLog(@"添加成员");
    
    [self.searchView.searchBar resignFirstResponder];
    
    NSMutableArray *itemArr = [NSMutableArray array];
    for (int i=0; i<self.dataArr.count; i++) {
        CGTeamMemberModel *model = [self.dataArr objectAtIndex:i];
        if(!model.is_selected) continue;
        
        [itemArr addObject:model];
    }
    
    //组员个数验证
    if(!itemArr.count) {
        [MBProgressHUD showError:@"请选择成员" toView:self.view];
        return;
    }
    
    if(self.callBack) {
        self.callBack(itemArr);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGTeamGroupMemberAddCell";
    CGTeamGroupMemberAddCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGTeamGroupMemberAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
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
                NSArray *dataList = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataList) {
                    CGTeamMemberModel *model = [CGTeamMemberModel mj_objectWithKeyValues:itemDic];
                    if([self.selectedArr containsObject:model.ID]) {
                        model.is_selected = YES;
                    }
                    [self.dataArr addObject:model];
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
