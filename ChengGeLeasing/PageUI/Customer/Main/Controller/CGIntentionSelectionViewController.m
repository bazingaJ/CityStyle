//
//  CGIntentionSelectionViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGIntentionSelectionViewController.h"

@interface CGIntentionSelectionViewController ()

@end

@implementation CGIntentionSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"合作意向";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGIntentionSelectionViewController";
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
    
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    NSDictionary *dataDic = [self.dataArr objectAtIndex:indexPath.row];
    
    //创建"意向度"
    UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 10, 45)];
    lbMsg.font = FONT15;
    lbMsg.textColor = UIColorFromRGBWith16HEX(0x789BD4);
    lbMsg.text = [NSString stringWithFormat:@"%@%%",dataDic[@"num"]];
    [lbMsg sizeToFit];
    lbMsg.height = 45;
    [cell.contentView addSubview:lbMsg];
    
    //创建"副标题'
    UILabel *lbMsg1 = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 200, 45)];
    lbMsg1.font = FONT15;
    lbMsg1.textColor = COLOR3;
    lbMsg1.text = dataDic[@"title"];
    [lbMsg1 sizeToFit];
    lbMsg1.height =45;
    [cell.contentView addSubview:lbMsg1];
    
    //创建"线"
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, .5)];
    lineView.backgroundColor = LINE_COLOR;
    [cell.contentView addSubview:lineView];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dataDic = [self.dataArr objectAtIndex:indexPath.row];
    
    //从招租事项跳过来选择意向度
    if (self.type ==1)
    {
        if ([dataDic[@"num"] isEqualToString:@"100"] && [self.is_can_hundred isEqualToString:@"2"])
        {
            [MBProgressHUD showError:@"不可以选择100%" toView:self.view];
            return;
        }
        
        //回调数据
        if (self.callBack)
        {
            self.callBack(dataDic);
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getDataList:(BOOL)isMore
{
    NSArray *numArr =@[@"0",@"15",@"25",@"40",@"60",@"100"];
    NSArray *titleArr = @[@"(终止合作)",@"(初步洽谈)",@"(现场考察)",@"(谈合作方案)",@"(谈合同)",@"(已收款)"];
    for (int i=0; i<numArr.count; i++)
    {
        [self.dataArr addObject:@{@"num":numArr[i],@"title":titleArr[i]}];
    }
    [self.tableView reloadData];
    [self endDataRefresh];
}

@end
