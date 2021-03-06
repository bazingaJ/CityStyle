//
//  CGHomeViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGHomeViewController.h"
#import <zhPopupController/zhPopupController.h>
#import "XTHomeLeftView.h"
#import "CGHomeViewController+Version.h"
#import "CGHomeCell.h"
#import "CGHomeCollectionView.h"
#import "CGOperationDynamicViewController.h"
#import "CGLeaseReportViewController.h"
#import "CGNetdiscViewController.h"
#import "CGRegionalDistributionViewController.h"
#import "CGShopDetailsViewController.h"
#import "CGMineMessageViewController.h"
#import "CGTeamAddViewController.h"
#import "CGSpotlightView.h"
#import "CGUpdateView.h"
#import "CGUpgradeVersionVC.h"

@interface CGHomeViewController ()<CGVersionPopupViewDelegate,UITableViewDelegate,UITableViewDataSource,CGHomeCellDelegate>

@property (nonatomic, strong) UIButton *navLeftBtn;
@property (nonatomic, strong) UIButton *navRightBtn;
@property (nonatomic, strong) UILabel  *navMsgNumLab;
@property (nonatomic, strong) NSString *msgNum;//消息数量
@property (nonatomic, strong) KLCPopup *popup;
@property (nonatomic, strong) NSString *trackViewUrl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CGHomeCollectionView *homeCollectionView;
@property (nonatomic, strong) CGHomeModel *model;
@property (nonatomic, strong) NSArray *spotlightArr;
@property (nonatomic, strong) NSString *my_pro_num;
@end

@implementation CGHomeViewController

/**
 * 懒加载
 */
-(NSArray *)spotlightArr
{
    if (!_spotlightArr)
    {
        _spotlightArr = @[@[@{@"pic":@"home_bg1",@"frame":NSStringFromCGRect(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)),@"type":@"1"},
                            
                            @{@"pic":@"home_page1_pic2",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-150/2,290,150, 75)),@"type":@"1"},
                            @{@"pic":@"home_page1_pic3",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-130/2, 390, 130, 35)),@"type":@"3"},],
                          @[@{@"pic":@"home_page2_pic1",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH-65, 0,65, 90)),@"type":@"1"},
                            @{@"pic":@"home_page2_arrow1",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH-100, 100, 50, 60)),@"type":@"1"},
                            @{@"pic":@"home_page2_pic2",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH-200,180,150, 150)),@"type":@"1"},
                            @{@"pic":@"public_know",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-130/2,350,130, 35)),@"type":@"2"},
                            @{@"pic":@"public_nextTo",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-130/2,400,130, 35)),@"type":@"3"},],
                          @[@{@"pic":@"home_page3_pic1",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-210/2, SCREEN_HEIGHT-290-50-50-180,210, 160)),@"type":@"1"},
                            @{@"pic":@"public_know",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-130/2,SCREEN_HEIGHT-290-50-50,130, 35)),@"type":@"2"},
                            @{@"pic":@"public_nextTo",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-130/2,SCREEN_HEIGHT-290-50,130, 35)),@"type":@"3"},
                            @{@"pic":@"home_page3_arrow1",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-30, SCREEN_HEIGHT-290, 60, 200)),@"type":@"1"},
                            @{@"pic":@"home_page3_pic2",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-85/2,SCREEN_HEIGHT-70,85, 70)),@"type":@"1"},],
                          
                          @[@{@"pic":@"home_page4_pic1",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-40/2, SCREEN_HEIGHT-40,40, 40)),@"type":@"1"},
                            
                            @{@"pic":@"home_page4_pic2",@"frame":NSStringFromCGRect(CGRectMake(50,SCREEN_HEIGHT-160,50, 70)),@"type":@"1"},
                            @{@"pic":@"home_page4_pic3",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-25,SCREEN_HEIGHT-160,50, 70)),@"type":@"1"},
                            @{@"pic":@"home_page4_pic4",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH-100,SCREEN_HEIGHT-160,50, 70)),@"type":@"1"},
                            @{@"pic":@"home_page4_pic5",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH-185,SCREEN_HEIGHT-160-190,85, 185)),@"type":@"1"},
                            @{@"pic":@"public_know",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-130/2,SCREEN_HEIGHT-160-190-40,130, 35)),@"type":@"2"},
                            @{@"pic":@"public_nextTo",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-130/2,SCREEN_HEIGHT-160-190-40-40,130, 35)),@"type":@"3"},
                            @{@"pic":@"home_page4_pic6",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-205/2,SCREEN_HEIGHT-160-190-40-40-170,205, 155)),@"type":@"1"},]];
    }
    return _spotlightArr;
    ;
}

//创建"导航左侧侧滑按钮"
-(UIButton *)navLeftBtn
{
    
    if (!_navLeftBtn)
    {
        //创建"背景"按钮
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(-10, 0, 130, 30)];
        [_navLeftBtn setTitle:[HelperManager CreateInstance].proName forState:UIControlStateNormal];
        [_navLeftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_navLeftBtn.titleLabel setFont:FONT16];
        [_navLeftBtn setImage:[UIImage imageNamed:@"home_icon_left"] forState:UIControlStateNormal];
        [_navLeftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [_navLeftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_navLeftBtn addTarget:self action:@selector(btnLeftOpenClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:_navLeftBtn];
        self.navigationItem.leftBarButtonItem = item;
    }
    return _navLeftBtn;
}

//创建"导航右侧待办通知按钮"
-(UIButton *)navRightBtn
{
    
    if (!_navRightBtn)
    {
        //创建"通知待办"
        _navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _navRightBtn.frame =CGRectMake(0, 0, 30, 30);
        [_navRightBtn setImage:[UIImage imageNamed:@"home_icon_right"] forState:UIControlStateNormal];
        [_navRightBtn addTarget:self action:@selector(goToNotifyBacklogBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_navRightBtn];
        
        
        UIButton *cloundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cloundBtn.frame =CGRectMake(0, 0, 30, 30);
        [cloundBtn setImage:[UIImage imageNamed:@"mypan"] forState:UIControlStateNormal];
        [cloundBtn addTarget:self action:@selector(goTocloundBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cloundBtn];
        
        NSArray *barBtnItemArr = @[leftBarButtonItem,rightBarButtonItem];
        
        self.navigationItem.rightBarButtonItems = barBtnItemArr;
        //创建"小红点"
        _navMsgNumLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, 10, 10)];
        _navMsgNumLab.layer.cornerRadius = 5;
        _navMsgNumLab.clipsToBounds = YES;
        _navMsgNumLab.textAlignment = NSTextAlignmentCenter;
        _navMsgNumLab.font = [UIFont systemFontOfSize:7];
        [_navRightBtn addSubview:_navMsgNumLab];
        
    }
    if ([_msgNum isEqualToString:@"0"])
    {
        _navMsgNumLab.hidden = YES;
    }
    else if ([_msgNum integerValue]>0)
    {
        _navMsgNumLab.backgroundColor = [UIColor redColor];
        _navMsgNumLab.textColor = [UIColor whiteColor];
        _navMsgNumLab.hidden = NO;
//        _navMsgNumLab.text = _msgNum;
    }
    return _navRightBtn;
}

//创建"表"
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -690 ,SCREEN_WIDTH, 690) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled =NO; //设置tableview 不能滚动
        _tableView.contentOffset = CGPointMake(0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(CGHomeCollectionView *)homeCollectionView
{
    if (!_homeCollectionView)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(66 , 66);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 12, 12, 12);
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumLineSpacing = 12;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _homeCollectionView = [[CGHomeCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT -TAB_BAR_HEIGHT) collectionViewLayout:flowLayout];
        _homeCollectionView.contentInset = UIEdgeInsetsMake(690, 0, 0, 0);
        _homeCollectionView.backgroundColor = [UIColor whiteColor];
        _homeCollectionView.userInteractionEnabled = YES;
        _homeCollectionView.contentOffset = CGPointMake(0, -690);
        [self.view addSubview:_homeCollectionView];
        [_homeCollectionView addSubview:[self tableView]];
        
        WS(weakSelf);
        //回调 跳转 编辑铺位界面
        _homeCollectionView.callBack = ^(NSString *pos_id)
        {
            //登录验证
            if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
            
            CGShopDetailsViewController *shopDetailsView =[CGShopDetailsViewController new];
            shopDetailsView.pos_id = pos_id;
            shopDetailsView.type = 2;
            [weakSelf.navigationController pushViewController:shopDetailsView animated:YES];
        };
        
        //跳转区域铺位状态
        _homeCollectionView.callRegionalUnitState = ^(NSString *group_id, NSString *name)
        {
            //登录验证
            if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
            
            CGRegionalDistributionViewController *regionalDistributionView =[CGRegionalDistributionViewController new];
            regionalDistributionView.group_id = group_id;
            regionalDistributionView.group_name = name;
            [weakSelf.navigationController pushViewController:regionalDistributionView animated:YES];
        };
    }
    return _homeCollectionView;
}

- (void)viewDidLoad {
    [self setRightButtonItemImageName:@"home_icon_right"];
    [super viewDidLoad];
    
    //创建"导航左侧按钮"
    [self navLeftBtn];
    
    //创建"导航右侧按钮"
    [self navRightBtn];
    
    //创建"表"
    [self tableView];
    
    //创建"collectionView"
    [self homeCollectionView];
    

    //获取数据
    [self getHomeData];
    
    // 获取个人信息-vip类型
    [self getMineInfo];
    
    // 获取VIP配置信息
    [self getVipConfigInfo];
    
    
    
    //版本检测
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkSystemVersion];
    });
    
    //展示引导页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showYinDaoYe) name:@"显示引导页" object:nil];

    
    
    //更新项目
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProeject) name:@"UPDATEPROJECT" object:nil];
    
}

-(void)showYinDaoYe
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"home"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"home"];
        CGSpotlightView *spotlightVie = [[CGSpotlightView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        spotlightVie.dataArr = [self.spotlightArr mutableCopy];
        [self.view addSubview:spotlightVie];
        [[[UIApplication sharedApplication] keyWindow]addSubview:spotlightVie];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //获取消息数量个数
    [self getNoRedNum];
    
    //获取首页数据
    [self getHomeData];
    
    //获取项目列表
    if(IsStringEmpty([HelperManager CreateInstance].proId) ||
       IsStringEmpty([HelperManager CreateInstance].proName)) {
        [self getXiangmuList];
    }else{
        //设置左侧按钮名称
        [_navLeftBtn setTitle:[HelperManager CreateInstance].proName forState:UIControlStateNormal];
    }
}

-(void)updateProeject
{
    //设置当前左侧按钮名称
    [_navLeftBtn setTitle:[HelperManager CreateInstance].proName forState:UIControlStateNormal];
    //重新刷数据
    [self getHomeData];
}

/**
 *  左侧按钮事件
 */
- (void)btnLeftOpenClick:(UIButton *)btnSender
{
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:^(NSInteger tIndex) {
        [self getXiangmuList];
    }]) return;
    
    XTHomeLeftView *leftView = [[XTHomeLeftView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, SCREEN_HEIGHT)];
    leftView.didClickItem = ^(XTHomeLeftView *view, CGTeamXiangmuModel *model, NSInteger index) {
        
        NSLog(@"回调成功索引值:%zd",index);
        [self.zh_popupController dismiss];
        
        //本地项目存储
        [self setXiangmuID:model.user_id proName:model.name];
        
        //设置当前左侧按钮名称
        [_navLeftBtn setTitle:[HelperManager CreateInstance].proName forState:UIControlStateNormal];
        
        //重新刷数据
        [self getHomeData];
    };
    leftView.didXiangmuClick = ^(XTHomeLeftView *view, NSString *myProNum) {
        NSLog(@"创建项目回调成功");
        
        // 判断是否能够继续创建新的项目 与本地存储的 免费或者vip账户进行比对
        if ([HelperManager CreateInstance].isFree)
        {
            
            if ([myProNum integerValue] >= [FREE_PRONUM integerValue])
            {
                CGUpdateView *view = [[CGUpdateView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 275, 345) contentStr:@"创建更多项目\n邀请小伙伴一起合作"];
                view.clickCallBack = ^(NSInteger tIndex) {
                    [self.popup dismiss:YES];
                    if (tIndex == 0)
                    {
                        return ;
                    }
                    else
                    {
                        [self.zh_popupController dismiss];
                        CGUpgradeVersionVC *vc = [CGUpgradeVersionVC new];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                };
                self.popup = [KLCPopup popupWithContentView:view
                                                   showType:KLCPopupShowTypeGrowIn
                                                dismissType:KLCPopupDismissTypeGrowOut
                                                   maskType:KLCPopupMaskTypeDimmed
                                   dismissOnBackgroundTouch:NO
                                      dismissOnContentTouch:NO];
                [self.popup show];
                return ;
            }
            
        }
        else
        {
            // VIP账户的 数量如果是0 意思就是 不限制数量
            if ([VIP_PRONUM integerValue] != 0)
            {
                if ([myProNum integerValue] >= [VIP_PRONUM integerValue])
                {
                    CGUpdateView *view = [[CGUpdateView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 275, 345) contentStr:@"创建更多项目\n邀请小伙伴一起合作"];
                    view.clickCallBack = ^(NSInteger tIndex) {
                        [self.popup dismiss:YES];
                        if (tIndex == 0)
                        {
                            return ;
                        }
                        else
                        {
                            [self.zh_popupController dismiss];
                            CGUpgradeVersionVC *vc = [CGUpgradeVersionVC new];
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    };
                    self.popup = [KLCPopup popupWithContentView:view
                                                       showType:KLCPopupShowTypeGrowIn
                                                    dismissType:KLCPopupDismissTypeGrowOut
                                                       maskType:KLCPopupMaskTypeDimmed
                                       dismissOnBackgroundTouch:NO
                                          dismissOnContentTouch:NO];
                    [self.popup show];
                    return ;
                }
            }
            
        }
        [self.zh_popupController dismiss];
        //新建项目
        CGTeamAddViewController *addView = [[CGTeamAddViewController alloc] init];
        addView.callBack = ^{
            [self.tableView.mj_header beginRefreshing];
        };
        if (![[HelperManager CreateInstance].account_id isEqualToString:@""] || [HelperManager CreateInstance].account_id != nil)
        {
            addView.account_id = [HelperManager CreateInstance].account_id;
        }
        
        [self.navigationController pushViewController:addView animated:YES];
        
    };
    self.zh_popupController = [zhPopupController new];
    self.zh_popupController.layoutType = zhPopupLayoutTypeLeft;
    self.zh_popupController.allowPan = YES;
    [self.zh_popupController presentContentView:leftView];
}

/**
 *  右侧按钮事件
 */
- (void)goToNotifyBacklogBtnClick {
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGMineMessageViewController *messageView = [[CGMineMessageViewController alloc] init];
    messageView.segmentIndex = 1;
    [self.navigationController pushViewController:messageView animated:YES];
}

- (void)goTocloundBtnClick
{
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    //网盘
    CGNetdiscViewController *netdiscView = [[CGNetdiscViewController alloc]init];
    [self.navigationController pushViewController:netdiscView animated:YES];
}

#pragma mark -Cell代理方法

-(void)CGHomeCellProjectNetworkLocation {
    
    //登陆验证
//    if (![[HelperManager CreateInstance]isLogin:NO completion:nil]) return;
    
    //网盘
//    CGNetdiscViewController *netdiscView = [[CGNetdiscViewController alloc]init];
//    [self.navigationController pushViewController:netdiscView animated:YES];
    
}

//经营动态
-(void)CGHomeCell:(CGHomeCell *)cell withGoToUnit:(UIButton *)sender
{
    //登陆验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGOperationDynamicViewController * operationDynamicViewController = [CGOperationDynamicViewController new];
    operationDynamicViewController.fromWhere = sender.tag -100;
    [self.navigationController pushViewController:operationDynamicViewController animated:YES];
}

//查看招租报表
-(void)CGHomeCell:(CGHomeCell *)cell showTable:(UIButton *)sender
{
    //登陆验证
    if (![[HelperManager CreateInstance]isLogin:NO completion:nil]) return;
    
    CGLeaseReportViewController *leaseReportView =[[CGLeaseReportViewController alloc]init];
    [self.navigationController pushViewController:leaseReportView animated:YES];
}

#pragma mark -表的协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            return 190;
        }
            break;
        case 1:
        {
            return 90;
        }
            break;
        case 2:
        {
            return 300;
        }
            break;
        default:
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSArray *titleArr = @[@"经营动态",@"招租数据",@"铺位租控"];
    if (section ==0 ||section ==1 ||section ==2)
    {
        UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = kRGB(245, 245, 245);
        
        //创建"蓝色竖线"
        UILabel *lineLab =[[UILabel alloc]initWithFrame:CGRectMake(0.5, 12.5, 5, 25)];
        lineLab.backgroundColor = UIColorFromRGBWith16HEX(0x7D9ACE);
        [backView addSubview:lineLab];
        
        //创建"标题"
        UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 150, 50)];
        lbMsg.textColor = COLOR3;
        lbMsg.font = FONT15;
        lbMsg.text = titleArr[section];
        [backView addSubview:lbMsg];
        return backView;
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        UICollectionReusableView *backView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CGHomeCollectionViewHeader" forIndexPath:indexPath];
        reusableView = backView;
    }
    
    return reusableView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGHomeCell";
    CGHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[CGHomeCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (UIView * view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    [cell setModel:self.model withIndexPath:indexPath];
    cell.delegate = self;
    return cell;
}

-(void)getHomeData
{
    NSMutableDictionary *parm =[NSMutableDictionary dictionary];
    [parm setValue:@"home" forKey:@"app"];
    [parm setValue:@"getIndexPage" forKey:@"act"];
    [parm setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:parm
                       success:^(id json)
     {
         [MBProgressHUD hideHUD:self.view];
         
         NSString *code =[json objectForKey:@"code"];
         if ([code isEqualToString:SUCCESS])
         {
             self.model =[CGHomeModel mj_objectWithKeyValues:[json objectForKey:@"data"]];
         }
         [self.tableView reloadData];
         
         self.homeCollectionView.model = self.model;
         [self.homeCollectionView reloadData];
     } failure:^(NSError *error)
     {

         [MBProgressHUD hideHUD:self.view];

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
            
            self.my_pro_num = dataDic[@"my_pro_num"];
            NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
            [us setObject:self.my_pro_num forKey:@"my_pro_num"];
            [us synchronize];
            
            
            if(dataDic && [dataDic count]>0) {
                NSArray *dataList = [dataDic objectForKey:@"list"];
                if(dataList && dataList.count>0) {
                    //获取第一个项目
                    NSDictionary *xiangmuDic = dataList[0];
                    NSString *proId = [xiangmuDic objectForKey:@"id"];
                    NSString *proName = [xiangmuDic objectForKey:@"name"];
                    [self setXiangmuID:proId proName:proName];
                    [_navLeftBtn setTitle:proName forState:UIControlStateNormal];
                    
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

- (void)getNoRedNum
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"getTodoNum" forKey:@"act"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
     {
         NSString *code = json[@"code"];
         if ([code isEqualToString:SUCCESS])
         {
             NSString *num = json[@"data"][@"num"];
             _msgNum =num;
             [self navRightBtn];
         }
     } failure:^(NSError *error) {
         
     }];
}

/**
 获取个人信息 只为获取VIP类型
 */
- (void)getMineInfo
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"ucenter";
    param[@"act"] = @"getMyInfo";
    
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               NSDictionary *dict = [json objectForKey:@"data"];
                               NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
                               [us setObject:dict[@"vip_type"] forKey:@"vip_type"];
                               [us synchronize];
                           }
                           else
                           {
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                       }];
}

/**
 获取VIP配置信息
 */
- (void)getVipConfigInfo
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"ucenter";
    param[@"act"] = @"getVipConfig";
    
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               NSDictionary *dict = [json objectForKey:@"data"];
                               NSArray *listArr = dict[@"list"];
                               
                               NSDictionary *dic1 = [listArr firstObject];
                               if ([dic1[@"vip_id"] isEqualToString:@"1"])
                               {
                                   [self saveFreeConfig:dic1];
                               }
                               else
                               {
                                   [self saveVipConfig:dic1];
                               }
                               NSDictionary *dic2 = [listArr lastObject];
                               if ([dic2[@"vip_id"] isEqualToString:@"1"])
                               {
                                   [self saveFreeConfig:dic2];
                               }
                               else
                               {
                                   [self saveVipConfig:dic2];
                               }
                               
                           }
                           else
                           {
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                       }];
}

- (void)saveFreeConfig:(NSDictionary *)dict
{
    NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
    [us setObject:dict[@"cate_num"] forKey:@"free_cate_num"];
    [us setObject:dict[@"name"] forKey:@"free_name"];
    [us setObject:dict[@"pos_num"] forKey:@"free_pos_num"];
    [us setObject:dict[@"price"] forKey:@"free_price"];
    [us setObject:dict[@"pro_num"] forKey:@"free_pro_num"];
    [us setObject:dict[@"sky_drive_num"] forKey:@"free_sky_drive_num"];
    [us setObject:dict[@"user_num"] forKey:@"free_user_num"];
    [us setObject:dict[@"vip_id"] forKey:@"free_vip_id"];
    [us synchronize];
}

- (void)saveVipConfig:(NSDictionary *)dict
{
    NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
    [us setObject:dict[@"cate_num"] forKey:@"vip_cate_num"];
    [us setObject:dict[@"name"] forKey:@"vip_name"];
    [us setObject:dict[@"pos_num"] forKey:@"vip_pos_num"];
    [us setObject:dict[@"price"] forKey:@"vip_price"];
    [us setObject:dict[@"pro_num"] forKey:@"vip_pro_num"];
    [us setObject:dict[@"sky_drive_num"] forKey:@"vip_sky_drive_num"];
    [us setObject:dict[@"user_num"] forKey:@"vip_user_num"];
    [us setObject:dict[@"vip_id"] forKey:@"vip_vip_id"];
    [us synchronize];
}



@end
