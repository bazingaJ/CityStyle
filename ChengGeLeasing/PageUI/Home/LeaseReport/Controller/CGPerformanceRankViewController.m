//
//  CGPerformanceRankViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGPerformanceRankViewController.h"
#import "CGPerformanceRankModel.h"
#import "CGDropDownMenu.h"

@interface CGPerformanceRankViewController ()

@property (nonatomic, strong) UIView *lineView;
//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *currenBtn;
@property (nonatomic, strong) NSString *type;//类型 2小组 3团队
@property (nonatomic, strong) NSString *timeInterval;//时间
@property (nonatomic, strong) NSString *cate_id;//业态ID
@property (nonatomic, strong) NSString *mode;//查询方式 1按签约面积 2按签约数量
@property (nonatomic, strong) NSString *subgroup;// 1按小组 2按成员
//@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) CGPerformanceRankModel *model;
@property (nonatomic, strong) CGDropDownMenu *dropDownMenu;

@end

@implementation CGPerformanceRankViewController

//- (NSMutableArray *)dataArr
//{
//    if (!_dataArr)
//    {
//        _dataArr = [NSMutableArray array];
//    }
//    return _dataArr;
//}

-(void)createTopView
{
    UIView *topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    topView.backgroundColor = UIColorFromRGBWith16HEX(0x2E374F);
    [self.view addSubview:topView];
    
    for (int i=0; i<2; i++)
    {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(SCREEN_WIDTH/2), 0, SCREEN_WIDTH/2, 45);
        [btn setTitle:@[@"按小组",@"按成员"][i] forState:UIControlStateNormal];
        [btn setTitleColor:WHITE_COLOR forState:UIControlStateSelected];
        [btn setTitleColor:UIColorFromRGBWith16HEX(0x999999) forState:UIControlStateNormal];
        btn.titleLabel.font = FONT15;
        if (i==1)
        {
            btn.selected =YES;
            _currenBtn = btn;
        }
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:btn];
    }
    
    //创建"蓝色下划线"
    self.lineView =[[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4-45/2+(SCREEN_WIDTH/2), 43, 45, 2)];
    self.lineView.backgroundColor = UIColorFromRGBWith16HEX(0x799CD6);
    [topView addSubview:self.lineView];
}

- (void)viewDidLoad {
    [self setTopH:90];
    [super viewDidLoad];
   
    self.title = @"业绩排名";
    
    //创建"头部view"
    [self createTopView];
    
    //创建“筛选框”
    NSMutableArray *titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"全部时间",@"3000"]];
    [titleArr addObject:@[@"全部业态",@"301"]];
    [titleArr addObject:@[@"按签约面积",@"5000"]];
    self.dropDownMenu = [[CGDropDownMenu alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 45) titleArr:titleArr];
    WS(weakSelf);
    self.dropDownMenu.callTimeBack = ^(NSString *time_id, NSString *time_name) {
        NSLog(@"当前时间：%@-%@",time_id,time_name);
        weakSelf.timeInterval = time_id;
        //[weakSelf getLetReportWithRank];
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    self.dropDownMenu.callFormatBack = ^(NSString *cate_id, NSString *cate_name) {
        NSLog(@"业态回调成功：%@-%@",cate_id,cate_name);
        weakSelf.cate_id = cate_id;
        //[weakSelf getLetReportWithRank];
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    self.dropDownMenu.callSignAreaBack = ^(NSString *sign_id, NSString *sign_name) {
        NSLog(@"按签约面积:%@-%@",sign_id,sign_name);
        weakSelf.mode = sign_id;
        //[weakSelf getLetReportWithRank];
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    [self.view addSubview:self.dropDownMenu];
    
    
    //[self setUpView];
    
    //默认按成员
    self.subgroup =@"2";
    self.mode = @"1";
    //获取数据
    //[self getLetReportWithRank];
    [weakSelf.tableView.mj_header beginRefreshing];
}

//返回按钮事件
- (void)leftButtonItemClick {
    [super leftButtonItemClick];
    
    [self.dropDownMenu dismiss];
}

//-(void)setUpView
//{
//    //创建"表"
//    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 90, SCREEN_WIDTH-20, SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT-NAV_BAR_HEIGHT-90) style:UITableViewStyleGrouped];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.backgroundColor = [UIColor clearColor];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_tableView];
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.list.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.001;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return nil;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return nil;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGPerformanceRankViewController";
    UITableViewCell *cell =[tableView  dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    CGPerformanceRankListModel *model1 = [self.model.list objectAtIndex:indexPath.row];
    
    NSInteger sortNum = indexPath.row+1;
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-150, 20)];
    [lbMsg setText:[NSString stringWithFormat:@"NO.%zd  %@",sortNum,model1.name]];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [cell.contentView addSubview:lbMsg];
    
    //创建“面积”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-140, 15, 110, 20)];
    if ([self.mode isEqualToString:@"1"]) {
        [lbMsg2 setText:[NSString stringWithFormat:@"%@m²",model1.area]];
    }else{
        [lbMsg2 setText:[NSString stringWithFormat:@"%@个",model1.num]];
    }
    [lbMsg2 setTextColor:UIColorFromRGBWith16HEX(0x8BDCCA)];
    [lbMsg2 setTextAlignment:NSTextAlignmentRight];
    [lbMsg2 setFont:FONT15];
    [cell.contentView addSubview:lbMsg2];
    
    //创建“升降”1不变 2上升 3下降
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 20, 11.5, 10)];
    if([model1.ratio isEqualToString:@"2"]) {
        //上升
        [imgView setImage:[UIImage imageNamed:@"work_icon_up2"]];
    }else if([model1.ratio isEqualToString:@"3"]) {
        //下降
        [imgView setImage:[UIImage imageNamed:@"work_icon_down2"]];
    }
    [cell.contentView addSubview:imgView];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [cell.contentView addSubview:lineView];
    
//    //创建"标题'
//    UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 15)];
//    lbMsg.textColor = COLOR3;
//    lbMsg.font = FONT14;
//    lbMsg.text = model1.name;
//    [cell.contentView addSubview:lbMsg];
//
//    //创建"灰色条"
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 30,self.tableView.width -10-80, 12)];
//    lineView.layer.cornerRadius = 4;
//    lineView.clipsToBounds = YES;
//    lineView.backgroundColor = UIColorFromRGBWith16HEX(0xEBEBEB);
//    [cell.contentView addSubview:lineView];
//
//    float ration;
//    if ([self.mode isEqualToString:@"1"])
//    {
//        ration = [model1.area floatValue]/[self.model.totalArea floatValue];
//        if (IsStringEmpty(model1.area) || [model1.area isEqualToString:@"0"])
//        {
//            ration = 0;
//        }
//    }
//    else
//    {
//         ration = [model1.num floatValue]/[self.model.totalNum floatValue];
//        if (IsStringEmpty(model1.num) || [model1.num isEqualToString:@"0"])
//        {
//            ration = 0;
//        }
//    }
//
//    //创建"绿色条"
//    UIView *lineView1 =[[UIView alloc]initWithFrame:CGRectMake(10, 30, lineView.width*ration, 12)];
//    lineView1.backgroundColor = UIColorFromRGBWith16HEX(0x8BDCCA);
//    lineView1.layer.cornerRadius =4;
//    lineView1.clipsToBounds = YES;
//    [cell.contentView addSubview:lineView1];
//
//    //创建"平方米"
//    UILabel *lbMsg1 =[[UILabel alloc]initWithFrame:CGRectMake(self.tableView.width-80, 30, 70, 12)];
//    lbMsg1.font = FONT12;
//    lbMsg1.textColor = UIColorFromRGBWith16HEX(0x8BDCCA);
//    if ([self.mode isEqualToString:@"1"])
//    {
//        lbMsg1.text = [NSString stringWithFormat:@"%@m²",model1.area];
//    }
//    else
//    {
//        lbMsg1.text = [NSString stringWithFormat:@"%@个",model1.num];
//    }
//    lbMsg1.textAlignment = NSTextAlignmentRight;
//    [cell.contentView addSubview:lbMsg1];
    return cell;
}

-(void)btnClick:(UIButton *)sender
{
    if (_currenBtn ==sender) return;
    
    sender.selected = YES;
    _currenBtn.selected =NO;
    _currenBtn = sender;
    
    [UIView animateWithDuration:.25 animations:^{
        CGRect rect = self.lineView.frame;
        rect.origin.x =(SCREEN_WIDTH/4-45/2) +(sender.tag -10)*(SCREEN_WIDTH/2);
        rect.size.width = 45;
        self.lineView.frame = rect;
    }];
    
    if (sender.tag ==10)
    {
        //按小组
        self.subgroup =@"1";
    }
    else
    {
        //按成员
        self.subgroup =@"2";
    }
    
    //获取业绩排名
    //[self getLetReportWithRank];
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  获取信息
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getLetReportWithRank" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.fromWhere forKey:@"type"];
    [param setValue:self.timeInterval forKey:@"timeInterval"];
    [param setValue:self.cate_id forKey:@"cate_id"];
    [param setValue:self.mode forKey:@"mode"];
    [param setValue:self.subgroup forKey:@"subgroup"];
    [MBProgressHUD showMsg:@"加载中..." toView:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if ([code isEqualToString:SUCCESS]) {
            self.model = [CGPerformanceRankModel mj_objectWithKeyValues:json[@"data"]];
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
        [self.tableView reloadData];
        [self endDataRefresh];
     } failure:^(NSError *error) {
         [MBProgressHUD hideHUD:self.view];
         [self endDataRefresh];
     }];
    
}

////获取业绩排名
//-(void)getLetReportWithRank
//{
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:@"home" forKey:@"app"];
//    [param setValue:@"getLetReportWithRank" forKey:@"act"];
//    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
//    [param setValue:self.fromWhere forKey:@"type"];
//    [param setValue:self.timeInterval forKey:@"timeInterval"];
//    [param setValue:self.cate_id forKey:@"cate_id"];
//    [param setValue:self.mode forKey:@"mode"];
//    [param setValue:self.subgroup forKey:@"subgroup"];
//    [MBProgressHUD showMsg:@"加载中..." toView:self.view];
//    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
//    {
//        [MBProgressHUD hideHUD:self.view];
//        NSString *code = json[@"code"];
//        if ([code isEqualToString:SUCCESS])
//        {
//            self.model = [CGPerformanceRankModel mj_objectWithKeyValues:json[@"data"]];
//            [self.tableView reloadData];
//        }
//        else
//        {
//            [MBProgressHUD showError:json[@"msg"] toView:self.view];
//        }
//
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUD:self.view];
//    }];
//}

@end
