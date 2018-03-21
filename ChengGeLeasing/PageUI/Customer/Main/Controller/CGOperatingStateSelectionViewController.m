//
//  CGOperatingStateSelectionViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGOperatingStateSelectionViewController.h"

@interface CGOperatingStateSelectionViewController ()

@end

@implementation CGOperatingStateSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"经营状态";
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGOperatingStateSelectionViewController";
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
    
    NSDictionary *dataDic = [self.dataArr objectAtIndex:indexPath.row];
    
    //创建"标题"
    UILabel * lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 45)];
    lbMsg.textColor = COLOR3;
    lbMsg.font = FONT15;
    lbMsg.text = dataDic[@"state"];
    [cell.contentView addSubview:lbMsg];
    
    //创建"线"
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH,.5)];
    lineView.backgroundColor = LINE_COLOR;
    [cell.contentView addSubview:lineView];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dataDic = [self.dataArr objectAtIndex:indexPath.row];
    if (self.callBack)
    {
        self.callBack(dataDic);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getDataList:(BOOL)isMore
{
    [self.dataArr addObject:@{@"state":@"稳营",@"state_id":@"2"}];
    [self.dataArr addObject:@{@"state":@"预动",@"state_id":@"3"}];
    [self.dataArr addObject:@{@"state":@"退铺",@"state_id":@"4"}];
    [self.tableView reloadData];
    [self endDataRefresh];
}

@end
