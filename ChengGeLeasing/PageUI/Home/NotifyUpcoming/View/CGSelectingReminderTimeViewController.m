//
//  CGSelectingReminderTimeViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/21.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGSelectingReminderTimeViewController.h"

@interface CGSelectingReminderTimeViewController ()

@end

@implementation CGSelectingReminderTimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"提醒时间";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    NSDictionary *dataDic =self.dataArr[indexPath.row];
    
    //创建"lbMsg"
    UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 45)];
    lbMsg.textColor =  COLOR3;
    lbMsg.font = FONT15;
    lbMsg.text = dataDic[@"title"];
    [cell.contentView addSubview:lbMsg];
    
    //创建"线"
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, .5)];
    lineView.backgroundColor = LINE_COLOR;
    [cell.contentView addSubview:lineView];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dataDic = self.dataArr[indexPath.row];
    if (self.callBack)
    {
        self.callBack(dataDic);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getDataList:(BOOL)isMore
{
    [self.dataArr addObject:@{@"title":@"无",@"id":@"1"}];
    [self.dataArr addObject:@{@"title":@"事件发生时",@"id":@"2"}];
    [self.dataArr addObject:@{@"title":@"10分钟前",@"id":@"3"}];
    [self.dataArr addObject:@{@"title":@"30分钟前",@"id":@"4"}];
    [self.dataArr addObject:@{@"title":@"一小时前",@"id":@"5"}];
    [self.dataArr addObject:@{@"title":@"两小时前",@"id":@"6"}];
    [self.dataArr addObject:@{@"title":@"一天前 ",@"id":@"7"}];
    [self.dataArr addObject:@{@"title":@"两天前",@"id":@"8"}];
    [self.tableView reloadData];
    [self endDataRefresh];
}

@end
