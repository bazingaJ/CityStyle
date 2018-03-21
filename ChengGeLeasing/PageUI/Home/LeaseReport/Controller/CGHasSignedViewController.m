//
//  CGHasSignedViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGHasSignedViewController.h"
#import "CGHasSignedHeadView.h"
#import "CGHasSignedCell.h"
#import "CGHasSignedModel.h"
#import "CGDropDownMenu.h"
#import "CGCustomerDetailViewController.h"

@interface CGHasSignedViewController ()

@property (nonatomic, strong) NSString *cate_id;
@property (nonatomic, strong) NSString *date_id;
@property (nonatomic, strong) NSString *member_id;
@property (nonatomic, strong) CGHasSignedModel *model;
@property (nonatomic, strong) CGHasSignedHeadView *hasSignedHeadView;
@property (nonatomic, strong) CGDropDownMenu *dropDownMenu;

@end

@implementation CGHasSignedViewController

//创建"头部View'
- (CGHasSignedHeadView *)hasSignedHeadView
{
    if (!_hasSignedHeadView)
    {
        _hasSignedHeadView =[[CGHasSignedHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    }
    return _hasSignedHeadView;
}

- (void)viewDidLoad
{
    [self setBottomH:45];
    
    [super viewDidLoad];
    
    self.title = @"已签约";
    
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
        self.dropDownMenu.callTeamMemberBack = ^(NSString *member_id, NSString *member_name) {
            NSLog(@"业务员回调成功:%@-%@",member_id,member_name);
            weakSelf.member_id = member_id;
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        [self.view addSubview:self.dropDownMenu];
    }
    
    CGRect rect = self.tableView.frame;
    rect.size.height =SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT;
    rect.origin.y = 45;
    self.tableView.frame = rect;
    [self.tableView setTableHeaderView:[self hasSignedHeadView]];
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
    lbMsg.text = [NSString stringWithFormat:@"签约客户数:%@",count];
    [headView addSubview:lbMsg];
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGHasSignedCell";
    CGHasSignedCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[CGHasSignedCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
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
    
    //跳转至客户详情
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

-(void)getDataList:(BOOL)isMore
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getLetReportWithSign" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.fromWhere forKey:@"type"];
    [param setValue:self.date_id forKey:@"timeInterval"];
    [param setValue:self.cate_id forKey:@"cate_id"];
    [param setValue:self.member_id forKey:@"member"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
    {
        NSString *code = json[@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            self.model = [CGHasSignedModel mj_objectWithKeyValues:json[@"data"]];
            
            //刷新头部View
            [self.hasSignedHeadView setDataArr:[self.model.statisticsModel.list mutableCopy]];
        }
        else
        {
            [MBProgressHUD showError:json[@"msg"] toView:self.view];
        }
        [self.tableView reloadData];
        [self endDataRefresh];
        
    } failure:^(NSError *error) {
         [self endDataRefresh];
    }];
}
@end
