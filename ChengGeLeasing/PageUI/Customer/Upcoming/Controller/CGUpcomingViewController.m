//
//  CGUpcomingViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGUpcomingViewController.h"
#import "CGEditNotifyBacklogViewController.h"
#import "CGNotifyBacklogDetailsViewController.h"

@interface CGUpcomingViewController () {
    //类型：1已完成 2未完成
    NSInteger doType;
}

@property (nonatomic, strong) CGUpcomingTopView *topView;

@end

@implementation CGUpcomingViewController

/**
 *  顶部视图
 */
- (CGUpcomingTopView *)topView {
    if(!_topView) {
        _topView = [[CGUpcomingTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
        [_topView setDelegate:self];
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (void)viewDidLoad {
    [self setTopH:35];
    if ([self.isMine isEqualToString:@"1"])
    {
        if (self.isAllCust)
        {
            [self setBottomH:45];
        }
        else
        {
            [self setBottomH:90];
        }
       
    }
    else
    {
         [self setBottomH:45];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"待办";
    
    //初始化
    doType = 2;
    
    //创建“头视图”
    [self topView];
    
    if ([self.isMine isEqualToString:@"1"])
    {
        if (!self.isAllCust)
        {
            //创建“添加待办”按钮
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-90, SCREEN_WIDTH, 45)];
            [btnFunc setTitle:@"添加待办" forState:UIControlStateNormal];
            [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT17];
            [btnFunc setImage:[UIImage imageNamed:@"upcoming_icon_add"] forState:UIControlStateNormal];
            [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            [btnFunc setBackgroundColor:MAIN_COLOR];
            [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btnFunc];
        }
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGUpcomingCell";
    CGUpcomingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGUpcomingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGMineMessageUpcomingModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setRightUtilityButtons:[self rightButtons:model] WithButtonWidth:80];
    [cell setDelegate:self];
    [cell setUpcomingModel:model indexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGMineMessageUpcomingModel *model;
    if(self.dataArr.count)
    {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if (!model) return;
    
    CGNotifyBacklogDetailsViewController * notifyBacklogDetailsView = [[CGNotifyBacklogDetailsViewController alloc]init];
    notifyBacklogDetailsView.toDo_id = model.id;
    notifyBacklogDetailsView.is_do = model.is_do;
    [self.navigationController pushViewController:notifyBacklogDetailsView animated:YES];
}


- (NSArray *)rightButtons:(CGMineMessageUpcomingModel *)model
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    //设置已办按钮
    if([model.is_do isEqualToString:@"2"]) {
        UIButton *btnFunc2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnFunc2 setTitle:@"已办" forState:UIControlStateNormal];
        [btnFunc2 setTitleColor:COLOR3 forState:UIControlStateNormal];
        [btnFunc2.titleLabel setFont:FONT13];
        [btnFunc2 setBackgroundColor:LINE_COLOR];
        [btnFunc2 setImage:[UIImage imageNamed:@"mine_icon_yiban"] forState:UIControlStateNormal];
        [btnFunc2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btnFunc2 setTitleEdgeInsets:UIEdgeInsetsMake(btnFunc2.imageView.frame.size.height+40 ,-btnFunc2.imageView.frame.size.width-25, 0, 0)];
        //图片距离右边框距离减少图片的宽度，其它不边
        [btnFunc2 setImageEdgeInsets:UIEdgeInsetsMake(-20, 0,0, -btnFunc2.titleLabel.bounds.size.width)];
        [btnFunc2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [rightUtilityButtons addObject:btnFunc2];
    }
    
    //设置删除按钮
    UIButton *btnFunc = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFunc setTitle:@"删除" forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT13];
    [btnFunc setBackgroundColor:GRAY_COLOR];
    [btnFunc setImage:[UIImage imageNamed:@"delete_icon_small"] forState:UIControlStateNormal];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(btnFunc.imageView.frame.size.height+40 ,-btnFunc.imageView.frame.size.width-25, 0, 0)];
    //图片距离右边框距离减少图片的宽度，其它不边
    [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(-20, 0,0, -btnFunc.titleLabel.bounds.size.width)];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [rightUtilityButtons addObject:btnFunc];
    
    return rightUtilityButtons;
}

/**
 *  滑动删除委托代理
 */
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSLog(@"滑动删除委托代理");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGUpcomingCell *tCell = (CGUpcomingCell *)cell;
    NSIndexPath *indexPath = tCell.indexPath;
    
    CGMineMessageUpcomingModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    
    switch (index) {
        case 0: {
            //已办
            
            if([model.is_do isEqualToString:@"1"]) {
                //已办
                
                [self deleteToDo:model indexPath:indexPath];
                
            }else{
                //未办
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"ucenter" forKey:@"app"];
                [param setValue:@"setListDo" forKey:@"act"];
                [param setValue:model.id forKey:@"id"];
                [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
                [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                    NSString *code = [json objectForKey:@"code"];
                    if([code isEqualToString:SUCCESS]) {
                        
                        model.is_do = @"1";
                        
                        //刷新
                        [self.tableView beginUpdates];
                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                        //延迟1秒退出
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [MBProgressHUD showSuccess:@"设置成功" toView:self.view];
                        });
                        
                    }
                } failure:^(NSError *error) {
                    NSLog(@"%@",[error description]);
                }];
            }
            
            break;
        }
        case 1: {
            //删除
            
            [self deleteToDo:model indexPath:indexPath];
            
            break;
        }
            
        default:
            break;
    }
    
}

/**
 *  删除
 */
- (void)deleteToDo:(CGMineMessageUpcomingModel *)model indexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"dropList" forKey:@"act"];
    [param setValue:model.id forKey:@"id"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            
            [self.dataArr removeObject:model];
            
            //移除
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView endUpdates];
            
            //延迟1秒退出
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"删除成功" toView:self.view];
            });
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
}

/**
 *  顶部筛选委托代理
 */
- (void)CGUpcomingTopViewClick:(NSInteger)tIndex {
    NSLog(@"当前头的值:%zd",tIndex);
    
    if(doType==tIndex) return;
    
    doType = tIndex;
    
    self.pageIndex = 1;
    [self.dataArr removeAllObjects];
    
    //刷新
    [self.tableView beginUpdates];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    
    [self.tableView.mj_header beginRefreshing];
    
}

/**
 *  添加待办按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"添加待办按钮事件");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGEditNotifyBacklogViewController *addView = [[CGEditNotifyBacklogViewController alloc] init];
    addView.cust_id = self.cust_id;
    addView.cust_name = self.cust_name;
    addView.title = @"添加待办";
    addView.type = 1;
    [self.navigationController pushViewController:addView animated:YES];
    
}

/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"getToDoList" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.cust_id forKey:@"cust_id"];
    [param setValue:@(doType) forKey:@"is_do"];//1已完成 2未完成
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[CGMineMessageUpcomingModel mj_objectWithKeyValues:itemDic]];
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


@end
