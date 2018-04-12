//
//  CGOrderDetailVC.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGOrderDetailVC.h"

static NSString *const currentTitle = @"订单详情";
static NSString *const orderNumberText = @"订单号";
static NSString *const orderTimeText = @"订单时间";
static NSString *const operationManText = @"操作人";
static NSString *const memberSeatText = @"成员席位";
static NSString *const buyingTimeText = @"购买时长";
static NSString *const amountText = @"金额";


static NSString *cellIdentifier = @"CGOrderDeteailIdentifier";

@interface CGOrderDetailVC ()
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *detailArr;
@end

@implementation CGOrderDetailVC

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = currentTitle;
    self.titleArr = [NSMutableArray array];
    self.detailArr = [NSMutableArray array];
    [self.titleArr addObjectsFromArray:@[@[orderNumberText,orderTimeText,operationManText],@[memberSeatText,buyingTimeText],@[amountText]]];
    
    // 数据准备
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.model.add_date integerValue]];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy.MM.dd"];
    NSString *order_time = [format stringFromDate:date];
    NSString *member_seatNum = [NSString stringWithFormat:@"%@个",self.model.member_num];
    NSString *buy_time = [NSString stringWithFormat:@"%@月",self.model.vip_time];
    NSString *amount = [NSString stringWithFormat:@"￥%@",self.model.total_price];
    [self.detailArr addObjectsFromArray:@[@[self.model.order_num,order_time,self.model.user_name],@[member_seatNum,buy_time],@[amount]]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return 3;
    }
    else if (section == 1)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [cell.contentView addSubview:lineView];
    }
    cell.textLabel.text = self.titleArr[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = self.detailArr[indexPath.section][indexPath.row];
    if (indexPath.section == 2 && indexPath.row == 0)
    {
        cell.detailTextLabel.textColor = MAIN_COLOR;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
