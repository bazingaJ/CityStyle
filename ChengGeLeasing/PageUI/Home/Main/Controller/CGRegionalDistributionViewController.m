//
//  CGRegionalDistributionViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGRegionalDistributionViewController.h"
#import "CGRegionalDistributionHeadView.h"
#import "CGRegionalDistributionModel.h"
@interface CGRegionalDistributionViewController ()

@property (nonatomic, strong) CGRegionalDistributionHeadView *headView;
@property (nonatomic, strong) CGRegionalDistributionModel *model;

@end

@implementation CGRegionalDistributionViewController

-(CGRegionalDistributionHeadView *)headView
{
    if (!_headView)
    {
        _headView =[[CGRegionalDistributionHeadView alloc]initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 240)];
        _headView.backgroundColor = WHITE_COLOR;
    }
    
    return  _headView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"区域铺位状态";
    
    self.view.backgroundColor = UIColorFromRGBWith16HEX(0xF5F5F5);
    
    [self createTopView];
    
    //创建"头部View"
    [self headView];
    
    CGRect rect = self.tableView.frame;
    rect.origin.y = 55;
    rect.size.height = SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT -55;
    self.tableView.frame = rect;
    
    [self.tableView setTableHeaderView:[self headView]];
}

-(void)createTopView
{
    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    bgView.backgroundColor = WHITE_COLOR;
    [self.view addSubview:bgView];
    
    //创建"标题"
    UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 45)];
    lbMsg.text = [NSString stringWithFormat:@"%@铺位状态分布",self.group_name];
    lbMsg.font = FONT15;
    lbMsg.textColor = COLOR3;
    [self.view addSubview:lbMsg];
}

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
    return 55;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGRegionalDistributionViewController";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    CGRegionalDistributionListModel *model = [self.model.list objectAtIndex:indexPath.row];
    
    //创建"标题";
    UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH -100, 20)];
    lbMsg.font = FONT16;
    lbMsg.textColor = COLOR3;
    lbMsg.text  = model.name;
    [cell.contentView addSubview:lbMsg];
    
    //创建"面积"
    UILabel *lbMsg1 =[[UILabel alloc]initWithFrame:CGRectMake(15, lbMsg.bottom +2, lbMsg.width, 15)];
    lbMsg1.font = FONT9;
    lbMsg1.textColor = COLOR9;
    lbMsg1.text = [NSString stringWithFormat:@"面积:%@㎡",model.area];
    [cell.contentView addSubview:lbMsg1];
    
    //创建"签约状态"
    UILabel *lbMsg2 =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-65, 45/2-9, 45, 18)];
    lbMsg2.layer.cornerRadius= 4;
    lbMsg2.clipsToBounds = YES;
    lbMsg2.font = FONT11;
    lbMsg2.textColor = WHITE_COLOR;
    lbMsg2.textAlignment = NSTextAlignmentCenter;
    if ([model.pos_status isEqualToString:@"1"])
    {
        lbMsg2.text = @"无意向";
        lbMsg2.backgroundColor = UIColorFromRGBWith16HEX(0xBBCDE9);
    }
    else if ([model.pos_status isEqualToString:@"2"])
    {
        lbMsg2.text = @"有意向";
        lbMsg2.backgroundColor = UIColorFromRGBWith16HEX(0x789BD4);
    }
    else if ([model.pos_status isEqualToString:@"3"])
    {
        lbMsg2.text = @"已签约";
        lbMsg2.backgroundColor = UIColorFromRGBWith16HEX(0xB9B9B9);
    }
    
    [cell.contentView addSubview:lbMsg2];
    
    //创建"线"
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 10)];
    lineView.backgroundColor = UIColorFromRGBWith16HEX(0xF2F6F8);
    [cell.contentView addSubview:lineView];
    return cell;
}

-(void)getDataList:(BOOL)isMore
{
    NSMutableDictionary *param =[NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getGroupStateInfo" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.group_id forKey:@"group_id"];

    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            self.model = [CGRegionalDistributionModel mj_objectWithKeyValues:json[@"data"]];
        }
        self.headView.dataDic = self.model.statistics;
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error)
    {
        [self endDataRefresh];
    }];
}



@end
