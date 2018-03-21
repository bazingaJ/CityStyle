//
//  CGNotifyBacklogDetailsViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGNotifyBacklogDetailsViewController.h"
#import "CGEditNotifyBacklogViewController.h"
#import "CGRemindModel.h"
@interface CGNotifyBacklogDetailsViewController ()

@property (nonatomic, strong) CGRemindModel *model;

@end

@implementation CGNotifyBacklogDetailsViewController

//创建"底部按钮"
-(void)createBottomBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-45, SCREEN_WIDTH, 45);
    btn.backgroundColor = UIColorFromRGBWith16HEX(0x789BD4);
    [btn setTitle:@"删除" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(deleteToDo) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

- (void)viewDidLoad
{
    if ([self.is_do isEqualToString:@"2"])
    {
         [self setRightButtonItemTitle:@"编辑"];
    }
    
    [super viewDidLoad];
    
    self.title = @"待办详情";
    
    [self createBottomBtn];
    
    //设置表
    CGRect rect = self.tableView.frame;
    rect.size.height = SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT -45;
    self.tableView.frame = rect;
    
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self.tableView.mj_header beginRefreshing];
//}

-(void)rightButtonItemClick
{
    CGEditNotifyBacklogViewController *editNotifyBacklogView =[[CGEditNotifyBacklogViewController alloc]init];
    editNotifyBacklogView.title = @"编辑待办";
    editNotifyBacklogView.model = self.model;
    [self.navigationController pushViewController:editNotifyBacklogView animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(!self.model) {
        return 0;
    }
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==1)
    {
        return 2;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0)
    {
        return 0.001;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {
         return 110;
    }
    else if (indexPath.section ==1)
    {
        return 45;
    }
    
    return self.model.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGNotifyBacklogDetailsViewController";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    if (indexPath.section ==0)
    {
        //创建"时间"
        UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 50)];
        lbMsg.font = SYSTEM_FONT_SIZE(40);
        lbMsg.textColor  = COLOR3;
        lbMsg.text = self.model.date_day;
        lbMsg.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:lbMsg];
        
        //创建"日期"
        UILabel *lbMsg1 =[[UILabel alloc]initWithFrame:CGRectMake(0, lbMsg.bottom +10, SCREEN_WIDTH, 20)];
        lbMsg1.textAlignment = NSTextAlignmentCenter;
        lbMsg1.text =[NSString stringWithFormat:@"%@ %@",self.model.date_day,self.model.date_min];
        lbMsg1.font = FONT17;
        lbMsg1.textColor = COLOR3;
        [cell.contentView addSubview:lbMsg1];
    }
    else if (indexPath.section ==1)
    {
        //创建"标题"
        UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 45)];
        lbMsg.font = FONT17;
        lbMsg.textColor = COLOR3;
        lbMsg.text = @[@"联系人",@"提醒"][indexPath.row];
        [cell.contentView addSubview:lbMsg];
        
        //创建"内容"
        UILabel *lbMsg1 =[[UILabel alloc]initWithFrame:CGRectMake(95, 0, SCREEN_WIDTH -115, 45)];
        lbMsg1.textColor = COLOR3;
        lbMsg1.font = FONT17;
        [cell.contentView addSubview:lbMsg1];
        //创建"电话"
        if (indexPath.row ==0)
        {
            UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(SCREEN_WIDTH -50, 0, 50, 45);
            [btn setImage:[UIImage imageNamed:@"cust_tel_icon"] forState:UIControlStateNormal];
            [cell.contentView addSubview:btn];
            lbMsg1.text = self.model.linkman_name;
        }
        else
        {
            lbMsg1.text = self.model.type_name;
        }
        
        //创建"线"
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 44.5,SCREEN_WIDTH,.5)];
        lineView.backgroundColor = LINE_COLOR;
        [cell.contentView addSubview:lineView];
    }
    else if (indexPath.section ==2)
    {
        UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 80)];
        lbMsg.textColor = COLOR9;
        lbMsg.font = FONT17;
        lbMsg.text = self.model.content;
        lbMsg.numberOfLines = 0;
        [lbMsg sizeToFit];
        lbMsg.top =15;
        [cell.contentView addSubview:lbMsg];
        self.model.cellHeight = lbMsg.bottom+15;
    }
    
    return cell;
}

-(void)getDataList:(BOOL)isMore
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"getToDoDetailInfo" forKey:@"act"];
    [param setValue:self.toDo_id forKey:@"id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
    {
        NSString *code = json[@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            self.model = [CGRemindModel mj_objectWithKeyValues:json[@"data"]];
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        [self endDataRefresh];
    }];
}

//删除待办
-(void)deleteToDo
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"dropToDoList" forKey:@"act"];
    [param setValue:self.model.id forKey:@"id"];
    [MBProgressHUD showMsg:@"删除中..." toView:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *code = json[@"code"];
        NSString *msg = json[@"msg"];
        if ([code isEqualToString:SUCCESS])
        {
            [MBProgressHUD showSuccess:@"删除成功" toView:self.view];
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error)
    {
        [MBProgressHUD hideHUD:self.view];
    }];
}


@end
