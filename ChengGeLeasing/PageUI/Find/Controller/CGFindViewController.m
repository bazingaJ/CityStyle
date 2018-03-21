//
//  CGFindViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGFindViewController.h"
#import "CGFindDetailViewController.h"
#import "CGFindAddToCustomerViewController.h"
#import "CGFindSearchViewController.h"
#import "CGDropDownMenu.h"
#import "CGSpotlightView.h"

@interface CGFindViewController () {
    //第1分类ID
    NSString *first_cate_id;
    //第2分类ID
    NSString *second_cate_id;
    //第3分类ID
    NSString *third_cate_id;
    //是否连锁:1是 2否
    NSString *is_chain_shop;
    //拼音 【所有】传 all , 【0-9】传 num
    NSString *pinyin;
}

@property (nonatomic, strong) CGDropDownMenu *dropDownMenu;
@property (nonatomic, strong) NSArray *spotlightArr;

@end

@implementation CGFindViewController

/**
 * 懒加载
 */
-(NSArray *)spotlightArr
{
    if (!_spotlightArr)
    {
        _spotlightArr = @[
                          @[@{@"pic":@"resources_page1_pic1",@"frame":NSStringFromCGRect(CGRectMake(0, 164+50, SCREEN_WIDTH, 120)),@"type":@"1"},
                            @{@"pic":@"resources_page1_pic2",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-70/2, 220+50, 70, 120)),@"type":@"1"},
                            @{@"pic":@"resources_page1_pic4",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-80, 220+60, 55, 15)),@"type":@"1"},
                            @{@"pic":@"resources_page1_pic3",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-70/2-90, 290+50, 80, 17)),@"type":@"1"},
                            @{@"pic":@"public_know",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-130/2,360+50,130, 35)),@"type":@"2"},],];
        
    }
    return _spotlightArr;
    ;
}

- (void)viewDidLoad {
    [self setTopH:50];
    if(!self.isAdd) {
        [self setBottomH:49];
        [self setLeftButtonItemHidden:YES];
    }
    [self setRightButtonItemImageName:@"find_icon_search"];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WS(weakSelf);
    
    //创建“筛选框”
    NSMutableArray *titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"业态",@"300"]];
    [titleArr addObject:@[@"A-Z",@"1000"]];
    [titleArr addObject:@[@"类型",@"100"]];
//    [titleArr addObject:@[@"意向度",@"10000"]];
//     [titleArr addObject:@[@"业态2",@"301"]];
    self.dropDownMenu = [[CGDropDownMenu alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) titleArr:titleArr];
    self.dropDownMenu.callAZBack = ^(NSString *letter) {
        NSLog(@"字母回调成功：%@",letter);
        
        //拼音 【所有】传 all , 【0-9】传 num
        if([letter isEqualToString:@"ALL"]) {
            pinyin = @"all";
        }else if([letter isEqualToString:@"0-9"]) {
            pinyin = @"num";
        }else{
            pinyin = letter;
        }
        [weakSelf.tableView.mj_header beginRefreshing];
        
    };
    self.dropDownMenu.callTypeBack = ^(NSString *typd_id, NSString *type_name) {
        NSLog(@"类型回调成功:%@-%@",typd_id,type_name);
        
        is_chain_shop = typd_id;
        [weakSelf.tableView.mj_header beginRefreshing];
        
    };
    self.dropDownMenu.callFormatListBack = ^(NSString *first_cate, NSString *second_cate, NSString *third_cate) {
        NSLog(@"业态回调成功:%@-%@-%@",first_cate,second_cate,third_cate);
        
        first_cate_id = first_cate;
        second_cate_id = second_cate;
        third_cate_id = third_cate;
        [weakSelf.tableView.mj_header beginRefreshing];
        
    };
    [self.view addSubview:self.dropDownMenu];
    
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"Resources"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"Resources"];
        CGSpotlightView *spotlightVie = [[CGSpotlightView alloc]initWithFrame:self.view.bounds];
        spotlightVie.dataArr =[self.spotlightArr mutableCopy];
        [self.view addSubview:spotlightVie];
        [[[UIApplication sharedApplication] keyWindow]addSubview:spotlightVie];
        
    }

}

/**
 *  返回按钮事件
 */
- (void)leftButtonItemClick {
    [super leftButtonItemClick];
    
    //隐藏
    [self.dropDownMenu dismiss];
    
}

/**
 *  搜索按钮事件
 */
- (void)rightButtonItemClick {
    NSLog(@"搜索");
    
    //隐藏
    [self.dropDownMenu dismiss];
    
    CGFindSearchViewController *searchView = [[CGFindSearchViewController alloc] init];
    [self.navigationController pushViewController:searchView animated:YES];
    
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
//    if(!self.isAdd) {
        [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:100];
        [cell setDelegate:self];
//    }
    [cell setFindModel:model indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGFindModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    
    if(!self.isAdd) {
        
        //品牌详情
        CGFindDetailViewController *detailView = [[CGFindDetailViewController alloc] init];
        detailView.findModel = model;
        [self.navigationController pushViewController:detailView animated:YES];
        
    }else{
        
//        //选择品牌加为客户
//        CGFindAddToCustomerViewController *customerView = [[CGFindAddToCustomerViewController alloc] init];
//        customerView.old_id = model.brand_id;
//        [self.navigationController pushViewController:customerView animated:YES];
        
    }
    
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
    customerView.chuBeiKeHuID = self.chuBeiKeHuID;
    [self.navigationController pushViewController:customerView animated:YES];

}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}

/**
 *  获取数据信息
 */
- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"depot" forKey:@"app"];
    [param setValue:@"getCustList" forKey:@"act"];
    [param setValue:first_cate_id forKey:@"first_cate"];
    [param setValue:second_cate_id forKey:@"second_cate"];
    [param setValue:third_cate_id forKey:@"third_cate"];
    [param setValue:is_chain_shop forKey:@"is_chain_shop"];
    [param setValue:pinyin forKey:@"pinyin"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
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
