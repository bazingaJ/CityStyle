//
//  CGChuBeiCustomerViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/20.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGChuBeiCustomerViewController.h"
#import "CGFindSearchViewController.h"
#import "CGCustomerCopyViewController.h"
#import "CGCustomerModel.h"

@interface CGChuBeiCustomerViewController () {
    //搜索关键词
    NSString *keywordStr;
    //A-Z
    NSString *simple_keywords;
    //业态
    NSString *cateId;
}

@property (nonatomic, strong) CGChubeiCustomerTopView *topView;

@end

@implementation CGChuBeiCustomerViewController

/**
 *  懒加载顶部视图
 */
- (CGChubeiCustomerTopView *)topView {
    if(!_topView) {
        _topView = [[CGChubeiCustomerTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        [_topView setDelegate:self];
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (void)viewDidLoad {
    [self setTopH:110];
    [self setRightButtonItemImageName:@"find_icon_search"];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的储备客户";
    
    //创建“顶部视图”
    [self topView];
    
}

/**
 *  返回按钮事件
 */
- (void)leftButtonItemClick {
    [super leftButtonItemClick];
    
    [self.topView dismiss];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGFindChubeiCustomerCell";
    CGFindChubeiCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGFindChubeiCustomerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGCustomerModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:100];
    [cell setDelegate:self];
    [cell setCustomerModel:model indexPath:indexPath];
    
    return cell;
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
    
    CGFindChubeiCustomerCell *tCell = (CGFindChubeiCustomerCell *)cell;
    NSIndexPath *indexPath = tCell.indexPath;
    
    CGCustomerModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    
    //复制客户
    CGCustomerCopyViewController *copyView = [[CGCustomerCopyViewController alloc] init];
    copyView.old_proId = model.pro_id;
    copyView.cust_id = model.id;
    copyView.proId = [HelperManager CreateInstance].proId;
    copyView.proName = [HelperManager CreateInstance].proName;
    copyView.callBack = ^{
        NSLog(@"复制客户回调成功");
        [self.navigationController popViewControllerAnimated:YES];
        //[self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:copyView animated:YES];
    
}

/**
 *  搜索委托代理
 */
- (void)CGCustomerTopViewSearchBarViewClick:(NSString *)searchStr {
    NSLog(@"搜索委托代理");
    keywordStr = searchStr;
    //搜索
    [self.tableView.mj_header beginRefreshing];
    
}

/**
 *  项目委托委托代理
 */
- (void)CGCustomerTopViewTeamXiangmuSelectClick:(NSString *)pro_id {
    NSLog(@"项目委托委托代理");
    
}

/**
 *  A-Z委托代理
 */
- (void)CGCustomerTopViewAZSelectClick:(NSString *)letterStr {
    NSLog(@"A-Z委托代理");
    
    simple_keywords = letterStr;
    [self.tableView.mj_header beginRefreshing];
    
}

/**
 *  业态委托代理
 */
- (void)CGCustomerTopViewFormatSelectClick:(NSString *)formatId {
    NSLog(@"业态委托代理");
    
    cateId = formatId;
    [self.tableView.mj_header beginRefreshing];
}


/**
 *  获取信息
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getMyTrunk" forKey:@"act"];
    [param setValue:keywordStr forKey:@"keywords"];
    [param setValue:simple_keywords forKey:@"simple_keywords"];
    [param setValue:cateId forKey:@"cate_id"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[CGCustomerModel mj_objectWithKeyValues:itemDic]];
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
