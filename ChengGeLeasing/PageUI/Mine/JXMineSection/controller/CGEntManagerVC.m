//
//  CGEntManagerVC.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGEntManagerVC.h"
#import "CGNetdiscNamePopupView.h"
#import "CGMemberInfoVC.h"
#import "CGPayOrderVC.h"
#import "CGRemoveVC.h"

static NSString *const currentTitle = @"VIP企业账户管理";
static NSString *const accountIDText = @"账户ID";
static NSString *const accountNameText = @"账户名称";
static NSString *const expireTimeText = @"到期时间";
static NSString *const memberInfoText = @"成员信息";
static NSString *const payOrderText = @"支付与订单";
static NSString *const transforAccountText = @"移交账户";


@interface CGEntManagerVC ()
@property (nonatomic, strong) KLCPopup *popup;
@end

@implementation CGEntManagerVC

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = currentTitle;
    // set origin data
    [self prepareForData];
}

- (void)prepareForData
{
    
    [self.dataArr removeAllObjects];
    [self.dataArr addObject:@[accountIDText,@"12354445131"]];
    [self.dataArr addObject:@[accountNameText,@"纯粹建筑"]];
    [self.dataArr addObject:@[expireTimeText,@"2018.07.18"]];
    [self.dataArr addObject:@[memberInfoText,@"27/30"]];
    [self.dataArr addObject:@[payOrderText,@""]];
    [self.dataArr addObject:@[transforAccountText,@""]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"entManagerIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [cell.contentView addSubview:lineView];
    }
    if (indexPath.row == 0 || indexPath.row == 2)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = self.dataArr[indexPath.row][0];
    cell.textLabel.textColor = COLOR3;
    cell.detailTextLabel.text = self.dataArr[indexPath.row][1];
    cell.detailTextLabel.textColor = COLOR6;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        // change account name
        [self jumpChangeNameWindow];
    }
    else if (indexPath.row == 3)
    {
        CGMemberInfoVC *vc = [CGMemberInfoVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 4)
    {
        CGPayOrderVC *vc = [CGPayOrderVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 5)
    {
        CGRemoveVC *vc = [CGRemoveVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)jumpChangeNameWindow
{
    CGNetdiscNamePopupView *popupView = [[CGNetdiscNamePopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 300, 175) titleStr:@"账户名称" placeholderStr:@"请输入账户名称" contentStr:@""];
    popupView.callBack = ^(NSInteger tIndex, NSString *content) {
        
        [self.popup dismiss:YES];
        
        if(tIndex==0) return ;
        
        //上传
        [self.dataArr replaceObjectAtIndex:1 withObject:@[accountNameText,content]];
        [self.tableView reloadData];
    };
    self.popup = [KLCPopup popupWithContentView:popupView
                                       showType:KLCPopupShowTypeGrowIn
                                    dismissType:KLCPopupDismissTypeGrowOut
                                       maskType:KLCPopupMaskTypeDimmed
                       dismissOnBackgroundTouch:NO
                          dismissOnContentTouch:NO];
    [self.popup show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
