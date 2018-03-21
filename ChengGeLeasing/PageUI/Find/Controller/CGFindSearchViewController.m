//
//  CGFindSearchViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/22.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGFindSearchViewController.h"
#import "CGFindDetailViewController.h"
#import "CGFindAddToCustomerViewController.h"

@interface CGFindSearchViewController () {
    //搜索关键词
    NSString *keywordStr;
}

@property (nonatomic, strong) CGMineSearchBarView *searchView;

@end

@implementation CGFindSearchViewController

/**
 *  懒加载搜索框
 */
- (CGMineSearchBarView *)searchView {
    if(!_searchView) {
        _searchView = [[CGMineSearchBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, 45)];
        _searchView.searchBar.placeholder = @"请输入品牌名称";
        [_searchView setDelegate:self];
        self.navigationItem.titleView = _searchView;
    }
    return _searchView;
}

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"资源搜索";
    
    //创建“搜索框”
    [self searchView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGFindCell";
    CGFindCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGFindCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFindModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:100];
    [cell setDelegate:self];
    [cell setFindModel:model indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFindModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    
    //品牌详情
    CGFindDetailViewController *detailView = [[CGFindDetailViewController alloc] init];
    detailView.findModel = model;
    [self.navigationController pushViewController:detailView animated:YES];
    
}

- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    UIButton *btnFunc = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFunc setTitle:@"加为客户" forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT14];
    [btnFunc setBackgroundColor:GRAY_COLOR];
    [btnFunc setImage:[UIImage imageNamed:@"customer_add_orange"] forState:UIControlStateNormal];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(btnFunc.imageView.frame.size.height+40 ,-btnFunc.imageView.frame.size.width-20, 0, 0)];
    //图片距离右边框距离减少图片的宽度，其它不边
    [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(-20, 35, 0, -btnFunc.titleLabel.bounds.size.width)];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [rightUtilityButtons addObject:btnFunc];
    
    return rightUtilityButtons;
}

/**
 *  滑动委托委托代理
 */
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSLog(@"滑动委托委托代理");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGFindCell *tCell = (CGFindCell *)cell;
    NSIndexPath *indexPath = tCell.indexPath;
    
    CGFindModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    
    //加为客户
    CGFindAddToCustomerViewController *customerView = [[CGFindAddToCustomerViewController alloc] init];
    customerView.old_id = model.brand_id;
    [self.navigationController pushViewController:customerView animated:YES];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchView.searchBar resignFirstResponder];
}

/**
 *  搜索委托代理
 */
- (void)CGMineSearchBarViewClick:(NSString *)searchStr {
    NSLog(@"搜索委托代理");
    
    keywordStr = searchStr;
    
    self.pageIndex = 1;
    [self.dataArr removeAllObjects];
    
    //刷新
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView beginUpdates];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    
    [self getDataList:NO];

}

/**
 *  获取数据信息
 */
- (void)getDataList:(BOOL)isMore {
    [MBProgressHUD showMsg:@"搜索中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"depot" forKey:@"app"];
    [param setValue:@"getCustList" forKey:@"act"];
    [param setValue:keywordStr forKey:@"keyword"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSArray *dataArr = [json objectForKey:@"data"];
            for (NSDictionary *itemDic in dataArr) {
                [self.dataArr addObject:[CGFindModel mj_objectWithKeyValues:itemDic]];
            }
            
            //当前总数
            NSInteger totalNum = [self.dataArr count];
            NSInteger dataNum = [dataArr count];
            if(dataNum<20) {
                self.totalNum = totalNum;
            }else{
                self.totalNum = totalNum+1;
            }
            
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
        [MBProgressHUD hideHUD:self.view];
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
