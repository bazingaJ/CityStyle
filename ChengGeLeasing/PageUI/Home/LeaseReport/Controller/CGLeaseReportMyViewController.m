//
//  CGLeaseReportMyViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLeaseReportMyViewController.h"
#import "CGHasSignedViewController.h"
#import "CGCustomerFunnelViewController.h"
#import "CGWorkBriefingViewController.h"
#import "CGLeaseReportMyModel.h"
@interface CGLeaseReportMyViewController ()

@property (nonatomic ,strong) CGLeaseReportMyModel *model;

@end

@implementation CGLeaseReportMyViewController

- (void)viewDidLoad
{
    self.hiddenHeaderRefresh =YES;
    
    [super viewDidLoad];
   
    //设置表
    CGRect rect = self.tableView.frame;
    rect.size.height = SCREEN_HEIGHT -45-10-NAVIGATION_BAR_HEIGHT;
    rect.origin.y = 10;
    self.tableView.frame = rect;
    
    //获取数据
    [self getLetReport];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==2)
    {
        return self.model.intent_InfoModel.list.count;
    }
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==2)
    {
        return 70;
    }
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==2)
    {
        CGLeaseIntent_InfoListModel *model = self.model.intent_InfoModel.list[indexPath.row];
        return model.cellHeight+80;
    }
    return 75;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    headView.backgroundColor = UIColorFromRGBWith16HEX(0x779AD4);
    

    
    //创建"图标"
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 20, 45)];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.image =[UIImage imageNamed:@[@"home_hassigned_icon",@"home_ customerfunnel_icon",@"home_workbriefing_icon"][section]];
    [headView addSubview:imageView];
    
    //创建"创建标题"
    UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(imageView.right +5, 0, 80, 45)];
    lbMsg.font = FONT15;
    lbMsg.textColor = WHITE_COLOR;
    lbMsg.text = @[@"已签约",@"客户漏斗",@"工作简报"][section];
    [headView addSubview:lbMsg];
    
    //创建"白色"箭头
    UIImageView *imageView1 =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -15,0, 6, 45)];
    imageView1.contentMode = UIViewContentModeRight;
    imageView1.image = [UIImage imageNamed:@"right_arrow_white"];
    [headView addSubview:imageView1];
    
    //创建"本周"
    UILabel *lbMsg2 =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -90 -15, 0, 85, 45)];
    lbMsg2.font = FONT14;
    lbMsg2.textAlignment = NSTextAlignmentRight;
    lbMsg2.textColor = WHITE_COLOR;
    [headView addSubview:lbMsg2];
    
    //创建总拜访
    UILabel *lbMsg3 =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -120-30-10, 0, 110, 45)];
    lbMsg3.font = FONT14;
    lbMsg3.textAlignment = NSTextAlignmentRight;
    lbMsg3.textColor = WHITE_COLOR;
    [headView addSubview:lbMsg3];
    
    //创建"按钮"蒙版
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = headView.bounds;
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(goToBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 10+section;
    [headView addSubview:btn];
    
    if (section == 0)
    {
        NSString *weekNum = self.model.sign_InfoModel.sign_num_week;
        NSString *totalNum = self.model.sign_InfoModel.sign_num_week;
        if (IsStringEmpty(weekNum))
        {
            weekNum = @"0";
        }
        if (IsStringEmpty(totalNum))
        {
            totalNum = @"0";
        }
        lbMsg2.text =[NSString stringWithFormat:@"本周签约:%@家",weekNum];
        lbMsg3.text =[NSString stringWithFormat:@"总签约:%@家",totalNum];
    }
    else if (section ==1)
    {
        NSString *weekNum = self.model.cust_InfoModel.cust_num_week;
        NSString *totalNum = self.model.cust_InfoModel.cust_num_total;
        if (IsStringEmpty(weekNum))
        {
            weekNum = @"0";
        }
        if (IsStringEmpty(totalNum))
        {
            totalNum = @"0";
        }
        
        lbMsg2.text = [NSString stringWithFormat:@"本周:%@家",weekNum];
        lbMsg3.text =[NSString stringWithFormat:@"客户总数:%@家",totalNum];
    }
    else if (section ==2)
    {
        NSString *weekNum = self.model.intent_InfoModel.intent_num_week;
        NSString *totalNum = self.model.intent_InfoModel.intent_num_total;
        if (IsStringEmpty(weekNum))
        {
            weekNum = @"0";
        }
        if (IsStringEmpty(totalNum))
        {
            totalNum = @"0";
        }
        lbMsg2.text =  [NSString stringWithFormat:@"本周:%@家",weekNum];
        lbMsg3.text =[NSString stringWithFormat:@"总拜访:%@家",totalNum];
        
        UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 25)];
        bgView.backgroundColor = WHITE_COLOR;
        [headView addSubview:bgView];
        
        //创建"标题"
        UILabel *lbMsg4 =[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 100, 20)];
        lbMsg4.text = @"最近事项";
        lbMsg4.font = FONT15;
        lbMsg4.textColor = COLOR3;
        [bgView addSubview:lbMsg4];
    }
    
    [lbMsg2 sizeToFit];
    CGRect rect = lbMsg3.frame;
    rect.origin.x = SCREEN_WIDTH -125-15-lbMsg2.width;
    lbMsg3.frame = rect;
    lbMsg2.height =45;
    lbMsg2.x = SCREEN_WIDTH -15-lbMsg2.width-10;
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGLeaseReportMyViewController";
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
        //创建"标题"
        UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 100, 20)];
        lbMsg.text = @"最近签约";
        lbMsg.font = FONT15;
        lbMsg.textColor = COLOR3;
        [cell.contentView addSubview:lbMsg];
        
        //创建"商铺名字"
        UILabel *lbMsg1 = [[UILabel alloc]initWithFrame:CGRectMake(15, lbMsg.bottom+5, SCREEN_WIDTH, 15)];
        lbMsg1.font = FONT14;
        lbMsg1.textColor = COLOR3;
        lbMsg1.text = self.model.sign_InfoModel.cust_name;
        [cell.contentView addSubview:lbMsg1];
        
        CGSize size =[lbMsg1 sizeThatFits:CGSizeMake(SCREEN_WIDTH -15-120, 15)];
        CGRect rect = lbMsg1.frame;
        rect.size.width = size.width;
        lbMsg1.frame = rect;
        
        //创建"业态名字"
        UILabel *lbMsg2 =[[UILabel alloc]initWithFrame:CGRectMake(lbMsg1.right+10, lbMsg1.top, 100, 15)];
        lbMsg2.textColor = COLOR9;
        lbMsg2.font = FONT14;
        lbMsg2.text = self.model.sign_InfoModel.cate_name;
        [cell.contentView addSubview:lbMsg2];
        
        //创建"签约铺位"
        UILabel *lbMsg3 =[[UILabel alloc]initWithFrame:CGRectMake(15, lbMsg2.bottom+5, 200, 15)];
        lbMsg3.font = FONT14;
        lbMsg3.textColor = COLOR9;
        if (!IsStringEmpty(self.model.sign_InfoModel.pos_name))
        {
            lbMsg3.text = [NSString stringWithFormat:@"签约铺位:%@",self.model.sign_InfoModel.pos_name];
        }
        else
        {
            lbMsg3.text = [NSString stringWithFormat:@"签约铺位:%@",@"暂无"];
        }
        [cell.contentView addSubview:lbMsg3];
        
        //创建"日期"
        UILabel *lbMsg4 =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -80, lbMsg2.top,70, 15)];
        lbMsg4.text = self.model.sign_InfoModel.sign_date;
        lbMsg4.font = FONT14;
        lbMsg4.textColor = COLOR9;
        lbMsg4.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:lbMsg4];
        
        //创建'名字"
        UILabel *lbMsg5 =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -80, lbMsg4.bottom+5,70, 15)];
//        lbMsg5.text = self.model.sign_InfoModel.
        lbMsg5.font = FONT14;
        lbMsg5.textColor = COLOR9;
        lbMsg5.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:lbMsg5];
    }
    else if (indexPath.section ==1)
    {
        //创建"标题"
        UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 100, 20)];
        lbMsg.text = @"最近新增";
        lbMsg.font = FONT15;
        lbMsg.textColor = COLOR3;
        [cell.contentView addSubview:lbMsg];
        
        //创建"商铺名字"
        UILabel *lbMsg1 = [[UILabel alloc]initWithFrame:CGRectMake(15, lbMsg.bottom+5, SCREEN_WIDTH, 15)];
        lbMsg1.font = FONT14;
        lbMsg1.textColor = COLOR3;
        lbMsg1.text = self.model.cust_InfoModel.cust_name;
        [cell.contentView addSubview:lbMsg1];
        
        CGSize size =[lbMsg1 sizeThatFits:CGSizeMake(200, MAXFLOAT)];
        CGRect rect = lbMsg1.frame;
        if (size.width>200)
        {
            rect.size.width = 200;
        }
        else
        {
            rect.size.width = size.width;
        }
        lbMsg1.frame = rect;
        
        //创建"业态名字"
        UILabel *lbMsg2 =[[UILabel alloc]initWithFrame:CGRectMake(lbMsg1.right+10, lbMsg1.top, 100, 15)];
        lbMsg2.textColor = COLOR9;
        lbMsg2.font = FONT14;
        lbMsg2.text = self.model.cust_InfoModel.cust_cate_name;
        [cell.contentView addSubview:lbMsg2];
        
        //创建"签约铺位"
        UILabel *lbMsg3 =[[UILabel alloc]initWithFrame:CGRectMake(15, lbMsg2.bottom+5, 200, 15)];
        lbMsg3.font = FONT14;
        lbMsg3.textColor = COLOR9;
        if (IsStringEmpty(self.model.cust_InfoModel.linkman_name))
        {
            lbMsg3.text = [NSString stringWithFormat:@"联系人:%@",@"暂无"];
        }
        else
        {
            lbMsg3.text = [NSString stringWithFormat:@"联系人:%@",self.model.cust_InfoModel.linkman_name];
        }
        
        [cell.contentView addSubview:lbMsg3];
        
        //创建"日期"
        UILabel *lbMsg4 =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -80, lbMsg2.top,70, 15)];
        lbMsg4.text = self.model.cust_InfoModel.add_time;
        lbMsg4.font = FONT14;
        lbMsg4.textColor = COLOR9;
        lbMsg4.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:lbMsg4];

    }
    else if (indexPath.section ==2)
    {
    
        //创建"商铺名字"
        UILabel *lbMsg1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH, 15)];
        lbMsg1.font = FONT14;
        lbMsg1.textColor = COLOR3;
        CGLeaseIntent_InfoListModel *infoListModel;
        if (self.model.intent_InfoModel.list.count)
        {
            infoListModel =self.model.intent_InfoModel.list[indexPath.row];
        }
        lbMsg1.text = infoListModel.cust_name;
        [cell.contentView addSubview:lbMsg1];
        
        CGSize size =[lbMsg1 sizeThatFits:CGSizeMake(SCREEN_WIDTH -15-120, 15)];
        CGRect rect = lbMsg1.frame;
        if (size.width>200)
        {
            rect.size.width = 200;
        }
        else
        {
            rect.size.width = size.width;
        }
        lbMsg1.frame = rect;
        
        //创建"业态名字"
        UILabel *lbMsg2 =[[UILabel alloc]initWithFrame:CGRectMake(lbMsg1.right+10, lbMsg1.top, 100, 15)];
        lbMsg2.textColor = COLOR9;
        lbMsg2.font = FONT14;
        lbMsg2.text = infoListModel.cate_name;
        [cell.contentView addSubview:lbMsg2];
        
        //创建"签约铺位"
        UILabel *lbMsg3 =[[UILabel alloc]initWithFrame:CGRectMake(15, lbMsg2.bottom+5, 200, 15)];
        lbMsg3.font = FONT14;
        lbMsg3.textColor = COLOR9;
        lbMsg3.text =[NSString stringWithFormat:@"意向铺位:%@",infoListModel.pos_name];
        [cell.contentView addSubview:lbMsg3];
        
        //创建"日期"
        UILabel *lbMsg4 =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -80, lbMsg2.top,70, 15)];
        lbMsg4.text = infoListModel.time;
        lbMsg4.font = FONT14;
        lbMsg4.textColor = COLOR9;
        lbMsg4.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:lbMsg4];
        
        //创建'名字"
        UILabel *lbMsg5 =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -80, lbMsg4.bottom+5,70, 15)];
        lbMsg5.text = infoListModel.linkman_name;
        lbMsg5.font = FONT14;
        lbMsg5.textColor = COLOR9;
        lbMsg5.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:lbMsg5];
        
        //创建"意向度"
        UILabel *lbMsg6 =[[UILabel alloc]initWithFrame:CGRectMake(15, lbMsg3.bottom +5, 200, 15)];
        lbMsg6.text = [NSString stringWithFormat:@"意向度:%@%%",infoListModel.intent];
        lbMsg6.font = FONT14;
        lbMsg6.textColor = COLOR9;
        [cell.contentView addSubview:lbMsg6];
        
        //创建"事项详情"
        UILabel *lbMsg7 =[[UILabel alloc]initWithFrame:CGRectMake(15, lbMsg6.bottom+5, SCREEN_WIDTH-30, infoListModel.cellHeight)];
        lbMsg7.numberOfLines = 0;
        lbMsg7.font = FONT14;
        lbMsg7.textColor = COLOR9;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:infoListModel.intro];
        NSMutableParagraphStyle   *paragraphStyle   = [[NSMutableParagraphStyle alloc] init];
        //行间距
        [paragraphStyle setLineSpacing:5.0];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [infoListModel.intro length])];
        [lbMsg7 setAttributedText:attributedString];
        [cell.contentView addSubview:lbMsg7];
        
        //创建"线"
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, lbMsg7.bottom, SCREEN_WIDTH, 10)];
        lineView.backgroundColor = UIColorFromRGBWith16HEX(0xF5F5F5);
        [cell.contentView addSubview:lineView];
    }
    
    return cell;
}

-(void)goToBtnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:
        {
            //已签约
            CGHasSignedViewController *hasSignedView =[[CGHasSignedViewController alloc]init];
            hasSignedView.fromWhere = @"1";
            [self.navigationController pushViewController:hasSignedView animated:YES];
        }
            break;
        case 11:
        {
            CGCustomerFunnelViewController *customerFunnelView =[[CGCustomerFunnelViewController alloc]init];
            customerFunnelView.fromWhere = @"1";
            [self.navigationController pushViewController:customerFunnelView animated:YES];
            
        }
            break;
        case 12:
        {
            CGWorkBriefingViewController *workBriefingView =[[CGWorkBriefingViewController alloc]init];
            workBriefingView.fromWhere = @"1";
            [self.navigationController pushViewController:workBriefingView animated:YES];
        }
            break;
            
        default:
            break;
    }
}

//获取招租报表内页封面
-(void)getLetReport
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getLetReport" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:@"1" forKey:@"type"];
    [MBProgressHUD showMsg:@"加载中..." toView:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
    {
        [MBProgressHUD hideHUD:self.view];
        NSString *code = [json objectForKey:@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            self.model = [CGLeaseReportMyModel mj_objectWithKeyValues:json[@"data"]];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error)
    {
        [MBProgressHUD hideHUD:self.view];
    }];
}
@end
