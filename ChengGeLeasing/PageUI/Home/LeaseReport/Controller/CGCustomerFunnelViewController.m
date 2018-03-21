//
//  CGCustomerFunnelViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGCustomerFunnelViewController.h"
#import "CGCustomerFunnelHeadView.h"
#import "CGCustomerFunnelCell.h"
#import "CGEmailPopView.h"
#import "CGCustomerFunnelModel.h"
#import "CGDropDownMenu.h"
#import "CGCustomerDetailViewController.h"

@interface CGCustomerFunnelViewController ()<CGEmailPopViewDelegate,CGCustomerFunnelHeadViewDelegate> {
    //意向度
    NSString *intentStr;
}

@property (nonatomic, strong) NSString *cate_id;
@property (nonatomic, strong) NSString *date_id;
@property (nonatomic, strong) NSString *area_id;
@property (nonatomic, strong) NSString *member_id;
@property (nonatomic, strong) CGCustomerFunnelModel *model;
@property (nonatomic, strong) CGCustomerFunnelHeadView *headView;
@property (nonatomic, strong) CGEmailPopView *popView;
@property (nonatomic, strong) KLCPopup *popup;
@property (nonatomic, strong) CGDropDownMenu *dropDownMenu;

@end

@implementation CGCustomerFunnelViewController

//创建"底部导出"按钮
-(void)createBottomBtn
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45);
    btn.backgroundColor = UIColorFromRGBWith16HEX(0x789BD4);
    [btn setTitle:@"导出" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClickDaoChuEmailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

//创建"头部View'
- (CGCustomerFunnelHeadView *)headView
{
    if (!_headView)
    {
        _headView =[[CGCustomerFunnelHeadView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 205)];
        _headView.backgroundColor = WHITE_COLOR;
        _headView.layer.cornerRadius = 5;
        _headView.clipsToBounds = YES;
        _headView.delegate = self;
    }
    return _headView;
}

- (void)viewDidLoad
{
    [self setBottomH:45];
    [super viewDidLoad];
    
    self.title = @"客户漏斗";
    
    if ([self.fromWhere isEqualToString:@"1"])
    {
        //创建“筛选框”
        NSMutableArray *titleArr = [NSMutableArray array];
        [titleArr addObject:@[@"全部时间",@"3000"]];
        [titleArr addObject:@[@"全部业态",@"301"]];
        self.dropDownMenu = [[CGDropDownMenu alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) titleArr:titleArr];
        WS(weakSelf);
        self.dropDownMenu.callTimeBack = ^(NSString *time_id, NSString *time_name) {
            NSLog(@"当前时间：%@-%@",time_id,time_name);
            weakSelf.date_id = time_id;
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        self.dropDownMenu.callFormatBack = ^(NSString *cate_id, NSString *cate_name) {
            NSLog(@"业态回调成功：%@-%@",cate_id,cate_name);
            weakSelf.cate_id = cate_id;
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        [self.view addSubview:self.dropDownMenu];
    }
    else
    {
        //创建“筛选框”
        NSMutableArray *titleArr = [NSMutableArray array];
        [titleArr addObject:@[@"全部时间",@"3000"]];
        [titleArr addObject:@[@"全部业态",@"301"]];
        [titleArr addObject:@[@"意向区域",@"4000"]];
        [titleArr addObject:@[@"业务员",@"200"]];
        self.dropDownMenu = [[CGDropDownMenu alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) titleArr:titleArr];
        WS(weakSelf);
        self.dropDownMenu.callTimeBack = ^(NSString *time_id, NSString *time_name) {
            NSLog(@"当前时间：%@-%@",time_id,time_name);
            weakSelf.date_id = time_id;
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        self.dropDownMenu.callFormatBack = ^(NSString *cate_id, NSString *cate_name) {
            NSLog(@"业态回调成功：%@-%@",cate_id,cate_name);
            weakSelf.cate_id = cate_id;
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        self.dropDownMenu.callTeamAreaBack = ^(NSString *area_id, NSString *area_name) {
            NSLog(@"意向区域：%@-%@",area_id,area_name);
            weakSelf.area_id = area_id;
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        self.dropDownMenu.callTeamMemberBack = ^(NSString *member_id, NSString *member_name) {
            NSLog(@"业务员回调成功:%@-%@",member_id,member_name);
            weakSelf.member_id = member_id;
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        [self.view addSubview:self.dropDownMenu];
    }
    
    //创建"底部"
    [self createBottomBtn];
    
    CGRect rect = self.tableView.frame;
    rect.size.height =SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT-45-TAB_BAR_HEIGHT;
    rect.origin.y = 45;
    self.tableView.frame = rect;
    [self.tableView setTableHeaderView:[self headView]];
}

-(void)leftButtonItemClick
{
    [super leftButtonItemClick];
    [self.dropDownMenu dismiss];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.customerModel.list.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    
    //创建"白色"背景
    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30)];
    bgView.backgroundColor = WHITE_COLOR;
    [headView addSubview:bgView];
    
    //创建"蓝色竖条"
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 10, 4, 30)];
    lineView.backgroundColor = UIColorFromRGBWith16HEX(0x789BD4);
    [headView addSubview:lineView];
    
    //创建"签约客户数"
    UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH -50, 30)];
    lbMsg.textColor = COLOR3;
    lbMsg.font = FONT16;
    NSString *count;
    if (IsStringEmpty(self.model.customerModel.count))
    {
        count =@"0";
    }
    else
    {
        count =self.model.customerModel.count;
    }
    lbMsg.text = [NSString stringWithFormat:@"客户数:%@",count];
    [headView addSubview:lbMsg];
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGHasSignedCell";
    CGCustomerFunnelCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[CGCustomerFunnelCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    [cell setModel:self.model.customerModel.list[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CGHasSignedCustomerListModel *model;
    if(self.model.customerModel.list.count) {
        model = [self.model.customerModel.list objectAtIndex:indexPath.row];
    }
    if(!model) return;
    
    //客户详情
    CGCustomerDetailViewController *detailView = [[CGCustomerDetailViewController alloc] init];
    [detailView setTitle:model.name];
    detailView.cust_id = model.id;
    detailView.isMine = model.is_own;
    detailView.cust_cover = model.logo;
    if ([model.intent isEqualToString:@"90"] ||[model.intent isEqualToString:@"100"]) {
        detailView.isSign = YES;
    }
    [self.navigationController pushViewController:detailView animated:YES];
}

/**
 *  选择百分比委托代理
 */
- (void)CGCustomerFunnelHeadViewClick:(NSString *)tagStr {
    NSLog(@"选择百分比委托代理:%@",tagStr);
    
    //意向度
    intentStr = [tagStr stringByReplacingOccurrencesOfString:@"%" withString:@""];
    
    //筛选
    [self.tableView.mj_header beginRefreshing];
    
}

//导出邮箱
-(void)btnClickDaoChuEmailBtnClick:(UIButton *)sender
{
    self.popView = [[CGEmailPopView alloc]initWithFrame:CGRectMake(25, SCREEN_HEIGHT/2-200, SCREEN_WIDTH-50, 155)];
    self.popView.delegate =self;
    self.popup = [KLCPopup popupWithContentView:self.popView
                                       showType:KLCPopupShowTypeBounceInFromTop
                                    dismissType:KLCPopupDismissTypeGrowOut
                                       maskType:KLCPopupMaskTypeDimmed
                       dismissOnBackgroundTouch:NO
                          dismissOnContentTouch:NO];
    self.popup.layer.cornerRadius = 10.0;
    [self.popup show];
}

//邮箱点击事件
-(void)cgEmailPopView:(UIButton *)sender
{
    switch (sender.tag) {
        case 20:
        {
            //取消
            
        }
            break;
        case 21:
        {
            //确定
            [self sendeEmail];
        }
            break;
            
        default:
            break;
    }
    [self.popup dismiss:YES];
}

//获取招租报表内数据漏斗信息
-(void)getDataList:(BOOL)isMore
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getLetReportWithFunnel" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.fromWhere forKey:@"type"];
    [param setValue:self.date_id forKey:@"timeInterval"];
    [param setValue:self.cate_id forKey:@"cate_id"];
    [param setValue:self.member_id forKey:@"member"];
    [param setValue:self.area_id forKey:@"group"];
    [param setValue:intentStr forKey:@"intent"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
    {
        NSString *code = [json objectForKey:@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            self.model = [CGCustomerFunnelModel mj_objectWithKeyValues:json[@"data"]];
            
            [self.headView setDataArr:self.model.statistics];
        }
        else
        {
            [MBProgressHUD showError:json[@"msg"] toView:self.view];
        }
        [self.tableView reloadData];
        [self endDataRefresh];
        
    } failure:^(NSError *error)
    {
         [self endDataRefresh];
    }];
}

//邮件导出
-(void)sendeEmail
{
    if (IsStringEmpty(self.popView.textField.text))
    {
        [MBProgressHUD showError:@"请输入邮箱" toView:self.view];
        return;
    }
    if (![self.popView.textField.text isEmail])
    {
        [MBProgressHUD showError:@"请输入正确的邮箱" toView:self.view];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"exportData" forKey:@"act"];
    [param setValue:self.popView.textField.text forKey:@"email"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.cate_id forKey:@"cate_id"];
    [param setValue:self.member_id forKey:@"member"];
    [param setValue:self.date_id forKey:@"timeInterval"];
    [param setValue:self.fromWhere forKey:@"type"];
    [param setValue:self.area_id forKey:@"group"];
    [MBProgressHUD showMsg:@"导出中..." toView:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *code = json[@"code"];
        NSString *msg = json[@"msg"];
        if ([code isEqualToString:SUCCESS])
        {
            [MBProgressHUD showSuccess:@"导出成功" toView:self.view];
        }
        else
        {
            [MBProgressHUD showError:msg toView:self.view];
        }
        
    } failure:^(NSError *error)
     {
        
    }];
}

@end
