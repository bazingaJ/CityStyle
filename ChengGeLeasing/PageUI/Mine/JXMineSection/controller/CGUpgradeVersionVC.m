//
//  CGUpgradeVersionVC.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/21.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGUpgradeVersionVC.h"
#import "CGVersionCell.h"

static NSString *const currentTitle = @"升级版本";
static NSString *const updateText = @"立即升级";
static const NSInteger headerViewHeight = 200;
static NSString *const headViewText = @"企业VIP版/n¥99/人/月";
static NSString *const versionText1 = @"个人免费版";
static NSString *const versionText2 = @"企业VIP版";
static NSString *const cellItem1 = @"项目数";
static NSString *const cellItem2 = @"项目团队用户数";
static NSString *const cellItem3 = @"铺位数";
static NSString *const cellItem4 = @"业态数";
static NSString *const cellItem5 = @"网盘文件数";

@interface CGUpgradeVersionVC ()
@property (nonatomic, strong) NSMutableArray *originArr;
@end

@implementation CGUpgradeVersionVC

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    self.topH = headerViewHeight;
    [super viewDidLoad];
    self.title = currentTitle;
    [self prepareForData];
    [self createUI];
    
}
// setup UI view
- (void)createUI
{
    // create bottom button "update now"
    [self createBottomBtn];
    
}
// setup dataOrigin
- (void)prepareForData
{
    self.dataArr = [NSMutableArray array];
    [self.dataArr addObject:@[@"",versionText1,versionText2]];
    [self.dataArr addObject:@[cellItem1,@"",@""]];
    [self.dataArr addObject:@[cellItem2,@"",@""]];
    [self.dataArr addObject:@[cellItem3,@"",@""]];
    [self.dataArr addObject:@[cellItem4,@"",@""]];
    [self.dataArr addObject:@[cellItem5,@"",@""]];
    
    
}

- (void)createBottomBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:updateText forState:UIControlStateNormal];
    [btn setBackgroundColor:MAIN_COLOR];
    [btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
    }];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGVersionCell *cell = [CGVersionCell cellWithTableView:tableView];
    cell.itemLab.text = self.dataArr[indexPath.row][0];
    cell.detailLab1.text = self.dataArr[indexPath.row][1];
    cell.detailLab2.text = self.dataArr[indexPath.row][2];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10.f;
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
