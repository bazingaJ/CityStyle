//
//  CGAboutUsViewController.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/4/4.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGAboutUsViewController.h"
#import "CGAboutWebViewController.h"

static NSString *const cellIdentifier = @"aboutuscell1";

@interface CGAboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *originArr;
@end

@implementation CGAboutUsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"关于我们";
    self.originArr = @[@[@"关于城格租赁",@"客服电话"],@[@"",@"4000-025-114"]];
    self.versionLab.text = [NSString stringWithFormat:@"V %@",APP_Version];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.originArr[0][indexPath.row];
    cell.textLabel.textColor = COLOR3;
    
    
    cell.detailTextLabel.text = self.originArr[1][indexPath.row];
    cell.textLabel.textColor = COLOR6;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        CGAboutWebViewController *vc = [CGAboutWebViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4000-025-114"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
}

@end
