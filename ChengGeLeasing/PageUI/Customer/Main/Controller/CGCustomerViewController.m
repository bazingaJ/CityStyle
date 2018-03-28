//
//  CGCustomerViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGCustomerViewController.h"
#import <zhPopupController/zhPopupController.h>
#import "XTHomeLeftView.h"
#import "CGMineCustomerAddViewController.h"
#import "CGCustomerDetailViewController.h"
#import "CGCustomerCopyViewController.h"
#import "CGFindViewController.h"
#import "CGSpotlightView.h"
#import "CGChuBeiCustomerViewController.h"
#import "CGTeamAddViewController.h"

@interface CGCustomerViewController () {
    //搜索关键词
    NSString *keywordStr;
    //意向度
    NSString *intention;
    //业态ID
    NSString *cateId;
    //A-Z
    NSString *simple_keywords;
    //业务员ID
    NSString *memberId;
}

@property (nonatomic, strong) UIButton *navLeftBtn;
@property (nonatomic, strong) UIButton *navRightBtn;
@property (nonatomic, strong) CGCustomerExTopView *topView;
@property (nonatomic, strong) NSArray *spotlightArr;

@end

@implementation CGCustomerViewController

/**
 * 懒加载
 */
-(NSArray *)spotlightArr
{
    
    if (!_spotlightArr)
    {
        _spotlightArr = @[
                          @[@{@"pic":@"customer_page1_pic1",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH-125,18, 125, 60)),@"type":@"1"},
                            @{@"pic":@"customer_page1_pic2",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH-170, 70, 70, 100)),@"type":@"1"},
                            @{@"pic":@"customer_page1_pic3",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-90/2,210,90, 150)),@"type":@"1"},
                            @{@"pic":@"customer_page1_pic4",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-200/2,400,200, 20)),@"type":@"1"},
                            @{@"pic":@"public_know",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-130/2,440,130, 35)),@"type":@"2"},
                            @{@"pic":@"public_nextTo",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-130/2,490,130, 35)),@"type":@"3"},],
                          @[@{@"pic":@"customer_page2_pic1",@"frame":NSStringFromCGRect(CGRectMake(0,SCREEN_HEIGHT-110, SCREEN_WIDTH, 110)),@"type":@"1"},
                            @{@"pic":@"customer_page1_pic2",@"frame":NSStringFromCGRect(CGRectMake(40, SCREEN_HEIGHT-220, 70, 100)),@"type":@"1"},
                            @{@"pic":@"customer_page2_pic2",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-200/2,SCREEN_HEIGHT-260,200, 20)),@"type":@"1"},
                            @{@"pic":@"public_know",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-130/2,SCREEN_HEIGHT-310,130, 35)),@"type":@"2"},
                            @{@"pic":@"public_nextTo",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-130/2,SCREEN_HEIGHT-360,130, 35)),@"type":@"3"},]
                          ];
        
    }
    return _spotlightArr;
    ;
}

//创建"导航左侧侧滑按钮"
-(UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(-10, 0, 130, 30)];
        [_navLeftBtn setTitle:[HelperManager CreateInstance].proName forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:FONT16];
        [_navLeftBtn setImage:[UIImage imageNamed:@"home_icon_left"] forState:UIControlStateNormal];
        [_navLeftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [_navLeftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_navLeftBtn addTarget:self action:@selector(btnNavLeftClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:_navLeftBtn];
        self.navigationItem.leftBarButtonItem = item;
    }
    return _navLeftBtn;
}

/**
 *  创建“新增客户按钮”
 */
- (UIButton *)navRightBtn {
    if(!_navRightBtn) {
        _navRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 28)];
        [_navRightBtn setTitle:@"新增客户" forState:UIControlStateNormal];
        [_navRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_navRightBtn.titleLabel setFont:FONT15];
        [_navRightBtn setImage:[UIImage imageNamed:@"mine_add_customer"] forState:UIControlStateNormal];
        [_navRightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [_navRightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [_navRightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_navRightBtn addTarget:self action:@selector(btnNavRightClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:_navRightBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    return _navRightBtn;
}

/**
 *  懒加载顶部视图
 */
- (CGCustomerExTopView *)topView {
    if(!_topView) {
        _topView = [[CGCustomerExTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        [_topView setDelegate:self];
        [self.view addSubview:_topView];
        
        intention = nil;
        cateId = nil;
        simple_keywords = nil;
        memberId = nil;
        
    }
    return _topView;
}

- (void)viewDidLoad
{
    [self setTopH:150];
    [self setBottomH:49];
    [self setLeftButtonItemHidden:YES];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    
    //创建“左侧按钮”
    [self navLeftBtn];
    
    //创建“新增客户按钮”
    [self navRightBtn];
    
    //创建“顶部视图”
    [self topView];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"customer"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"customer"];
        CGSpotlightView *spotlightVie = [[CGSpotlightView alloc]initWithFrame:self.view.bounds];
        spotlightVie.dataArr =[self.spotlightArr mutableCopy];
        [self.view addSubview:spotlightVie];
        [[[UIApplication sharedApplication] keyWindow]addSubview:spotlightVie];
        
    }
    
//    //更新项目
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProeject) name:@"UPDATEPROJECT" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    //设置当前左侧按钮名称
//    [_navLeftBtn setTitle:[HelperManager CreateInstance].proName forState:UIControlStateNormal];
//    if (IsStringEmpty(_navLeftBtn.titleLabel.text))
//    {
//        [_navLeftBtn setTitle:@"演示项目" forState:UIControlStateNormal];
//    }
//    //重新刷数据
//    [self.tableView.mj_header beginRefreshing];
    
    //获取项目列表
    if(IsStringEmpty([HelperManager CreateInstance].proId) ||
       IsStringEmpty([HelperManager CreateInstance].proName)) {
        [self getXiangmuList];
    }else{
        //设置左侧按钮名称
        [_navLeftBtn setTitle:[HelperManager CreateInstance].proName forState:UIControlStateNormal];
    }
    
    //刷新数据源
    [self.tableView.mj_header beginRefreshing];
    
}

///**
// * 更新项目
// */
//-(void)updateProeject
//{
//    //设置当前左侧按钮名称
//    [_navLeftBtn setTitle:[HelperManager CreateInstance].proName forState:UIControlStateNormal];
//    //重新刷数据
//    [self.tableView.mj_header beginRefreshing];
//}

/**
 *  左侧按钮事件
 */
- (void)btnNavLeftClick:(UIButton *)btnSender {
    NSLog(@"左侧按钮事件");
    
    [self.topView dismiss];
    
    XTHomeLeftView *leftView = [[XTHomeLeftView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, SCREEN_HEIGHT)];
    leftView.didClickItem = ^(XTHomeLeftView *view, CGTeamXiangmuModel *model, NSInteger index) {
        NSLog(@"回调成功索引值:%zd-%@",index,model.name);
        [self.zh_popupController dismiss];
        
        //本地项目存储
        [self setXiangmuID:model.id proName:model.name];
        
        //设置当前左侧按钮名称
        [_navLeftBtn setTitle:[HelperManager CreateInstance].proName forState:UIControlStateNormal];
        
        _topView = nil;
        //创建“顶部视图”
        [self topView];
        
        //清除搜索关键词
        keywordStr = @"";
        
        //获取数据源
        [self.tableView.mj_header beginRefreshing];
//        self.pageIndex = 1;
//        [self.dataArr removeAllObjects];
//        [self getDataList:NO];
        
    };
    leftView.didXiangmuClick = ^(XTHomeLeftView *view, NSString *myProNum) {
        NSLog(@"创建项目回调成功");
        
        [self.zh_popupController dismiss];
        
        //新建项目
        CGTeamAddViewController *addView = [[CGTeamAddViewController alloc] init];
        addView.callBack = ^{
            [self.tableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:addView animated:YES];
        
    };
    self.zh_popupController = [zhPopupController new];
    self.zh_popupController.layoutType = zhPopupLayoutTypeLeft;
    self.zh_popupController.allowPan = YES;
    [self.zh_popupController presentContentView:leftView];
}

/**
 *  新增客户按钮事件
 */
- (void)btnNavRightClick:(UIButton *)btnSender {
    NSLog(@"新增客户按钮");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    UIAlertController *alertController = [[UIAlertController alloc] init];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"新增客户" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"新增客户");
        
        CGMineCustomerAddViewController *addView = [[CGMineCustomerAddViewController alloc] init];
        addView.callBack = ^{
            [self.tableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:addView animated:YES];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从品牌资源库添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"从品牌资源库添加");
        
        CGFindViewController *findView = [[CGFindViewController alloc] init];
        findView.title = @"品牌资源库";
        findView.isAdd = YES;
        [self.navigationController pushViewController:findView animated:YES];

    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从储备客户添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"从储备客户添加");
        
        CGChuBeiCustomerViewController *customerView = [[CGChuBeiCustomerViewController alloc] init];
        [self.navigationController pushViewController:customerView animated:YES];
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0) {
        return 10;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGCustomerCell";
    CGCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGCustomerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGCustomerModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:100];
    [cell setDelegate:self];
    [cell setCustomerModel:model indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CGCustomerModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    if(!model) return;
    
    //客户详情
    CGCustomerDetailViewController *detailView = [[CGCustomerDetailViewController alloc] init];
    [detailView setTitle:model.name];
    detailView.cust_id = model.id;
    detailView.isMine = model.is_mine;
    detailView.cust_cover = model.logo;
    if ([model.intent isEqualToString:@"90"] ||[model.intent isEqualToString:@"100"]) {
        detailView.isSign = YES;
    }
    [self.navigationController pushViewController:detailView animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //隐藏键盘
    [self.topView.searchView.tbxContent resignFirstResponder];
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    //设置已办按钮
    UIButton *btnFunc2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFunc2 setTitle:@"复制" forState:UIControlStateNormal];
    [btnFunc2 setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc2.titleLabel setFont:FONT14];
    [btnFunc2 setBackgroundColor:GRAY_COLOR];
    [btnFunc2 setImage:[UIImage imageNamed:@"copy_icon_big"] forState:UIControlStateNormal];
    [btnFunc2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnFunc2 setTitleEdgeInsets:UIEdgeInsetsMake(btnFunc2.imageView.frame.size.height+70 ,-btnFunc2.imageView.frame.size.width-60, 0, 0)];
    //图片距离右边框距离减少图片的宽度，其它不边
    [btnFunc2 setImageEdgeInsets:UIEdgeInsetsMake(30, -30, 50, -btnFunc2.titleLabel.bounds.size.width)];
    [btnFunc2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [rightUtilityButtons addObject:btnFunc2];
    
    //设置删除按钮
    UIButton *btnFunc = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFunc setTitle:@"删除" forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT14];
    [btnFunc setBackgroundColor:GRAY_COLOR];
    [btnFunc setImage:[UIImage imageNamed:@"delete_icon_big"] forState:UIControlStateNormal];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(btnFunc.imageView.frame.size.height+70 ,-btnFunc.imageView.frame.size.width-60, 0, 0)];
    //图片距离右边框距离减少图片的宽度，其它不边
    [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(30, -30, 50, -btnFunc.titleLabel.bounds.size.width)];
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
    
    CGCustomerCell *tCell = (CGCustomerCell *)cell;
    NSIndexPath *indexPath = tCell.indexPath;
    
    CGCustomerModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    if(!model) return;
    
    switch (index) {
        case 0: {
            //复制
            
            CGCustomerCopyViewController *copyView = [[CGCustomerCopyViewController alloc] init];
            copyView.old_proId = model.pro_id;
            copyView.cust_id = model.id;
            copyView.callBack = ^{
                NSLog(@"复制客户回调成功");
                
                [self.tableView.mj_header beginRefreshing];
            };
            [self.navigationController pushViewController:copyView animated:YES];
            
            break;
        }
        case 1: {
            //删除
            
            UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"警告" message:@"您确定要删除吗?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"删除");
                
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"ucenter" forKey:@"app"];
                [param setValue:@"dropCust" forKey:@"act"];
                [param setValue:model.id forKey:@"cust_id"];
                [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                    NSString *msg = [json objectForKey:@"msg"];
                    NSString *code = [json objectForKey:@"code"];
                    if([code isEqualToString:SUCCESS]) {
                        
                        [self.dataArr removeObject:model];
                        
                        //界面上移除
                        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
                        [self.tableView beginUpdates];
                        [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                        //延迟一秒返回
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [MBProgressHUD showSuccess:@"删除成功" toView:self.view];
                        });
                        
                    }else{
                        [MBProgressHUD showError:msg toView:self.view];
                    }
                } failure:^(NSError *error) {
                    NSLog(@"%@",[error description]);
                }];
                
            }];
            [aler addAction:cancelAction];
            [aler addAction:okAction];
            [self presentViewController:aler animated:YES completion:nil];
            
            break;
        }
            
        default:
            break;
    }
    
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
 *  A-Z委托代理
 */
- (void)CGCustomerTopViewAZSelectClick:(NSString *)letterStr {
    NSLog(@"A-Z委托代理");
    
    simple_keywords = letterStr;
    [self.tableView.mj_header beginRefreshing];
    
}

/**
 *  意向度委托代理
 */
- (void)CGCustomerTopViewIntentionSelectClick:(NSString *)intentionStr {
    NSLog(@"意向度委托代理");
    
    intention = intentionStr;
    [self.tableView.mj_header beginRefreshing];
    
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
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
 *  业务员委托代理
 */
- (void)CGCustomerTopViewTeamMemberSelectClick:(NSString *)member_id {
    NSLog(@"业务员委托代理");
    
    memberId = member_id;
    [self.tableView.mj_header beginRefreshing];
    
}

/**
 *  获取客户数据
 */
- (void)getDataList:(BOOL)isMore {
    
    if(![HelperManager CreateInstance].isLogin) {
        [self endDataRefresh];
        
        //设置空白页面
        [self.tableView emptyViewShowWithDataType:EmptyViewTypeCustomer
                                          isEmpty:YES
                              emptyViewClickBlock:^(NSInteger tIndex) {
                                  NSLog(@"回调成功");
                                  //登录验证
                                  if(![[HelperManager CreateInstance] isLogin:NO completion:^(NSInteger tIndex) {
                                      //[self.tableView.mj_header beginRefreshing];
                                      //获取最新项目
                                      [self getXiangmuList];
                                  }]) return;
                              }];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"index" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:keywordStr forKey:@"keywords"];
    [param setValue:simple_keywords forKey:@"simple_keywords"];
    [param setValue:cateId forKey:@"cate_id"];
    [param setValue:intention forKey:@"intent"];
    [param setValue:memberId forKey:@"member"];
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
                
                //设置客户资源数
                self.topView.customerNum = dataNum;
                
                //我的客户数
                NSString *mineNum = [dataDic objectForKey:@"mine"];
                self.topView.mineNum = mineNum;
                
            }
            
            //设置空白页面
            [self.tableView emptyViewShowWithDataType:EmptyViewTypeCustomer
                                              isEmpty:self.dataArr.count<=0
                                  emptyViewClickBlock:nil];
            
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
    }];
    
}

/**
 *  获取项目列表(主要获取第一个项目的ID和名称)
 */
- (void)getXiangmuList
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getProjectList" forKey:@"act"];
    [param setValue:@"1" forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataList = [dataDic objectForKey:@"list"];
                if(dataList && dataList.count>0) {
                    //获取第一个项目
                    NSDictionary *xiangmuDic = dataList[0];
                    NSString *proId = [xiangmuDic objectForKey:@"id"];
                    NSString *proName = [xiangmuDic objectForKey:@"name"];
                    [self setXiangmuID:proId proName:proName];
                    [_navLeftBtn setTitle:proName forState:UIControlStateNormal];
                    
                    //获取最新数据源
                    [self.tableView.mj_header beginRefreshing];
                    
                }
            }
        }
        if (IsStringEmpty(_navLeftBtn.titleLabel.text))
        {
            [_navLeftBtn setTitle:@"演示项目" forState:UIControlStateNormal];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
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
