//
//  CGUpgradeVersionVC.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/21.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGUpgradeVersionVC.h"
#import "CGVersionCell.h"
#import "CGVersionHeaderV.h"
#import "CGLevelUpVC.h"


static const CGFloat headerViewHeight = 220.f;

static NSString *const currentTitle = @"升级版本";
static NSString *const updateText = @"立即升级";
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
@property (nonatomic, strong) CGVersionHeaderV *topView;
@end

@implementation CGUpgradeVersionVC

- (void)viewDidLoad {
    self.bottomH = 50;
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = currentTitle;
    // setup dataOrigin
    [self prepareForData];
    // setup UI view
    [self createUI];
    
}

- (void)createUI
{
    self.tableView.tableHeaderView = self.topView;
    // create bottom button "update now"
    [self createBottomBtn];

}

- (void)prepareForData
{
    self.dataArr = [NSMutableArray array];
    [self.dataArr addObject:@[@"",versionText1,versionText2]];
    [self.dataArr addObject:@[cellItem1,@"3",@"不限"]];
    [self.dataArr addObject:@[cellItem2,@"2",@"不限"]];
    [self.dataArr addObject:@[cellItem3,@"不限",@"不限"]];
    [self.dataArr addObject:@[cellItem4,@"不限",@"不限"]];
    [self.dataArr addObject:@[cellItem5,@"3",@"不限"]];
    
}

- (void)createBottomBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:updateText forState:UIControlStateNormal];
    [btn setBackgroundColor:MAIN_COLOR];
    [btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(updateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(self.view).offset(-HOME_INDICATOR_HEIGHT);
        make.left.right.mas_equalTo(self.view);
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGVersionCell *cell = [CGVersionCell cellWithTableView:tableView];
    cell.itemLab.text = self.dataArr[indexPath.row][0];
    cell.detailLab1.text = self.dataArr[indexPath.row][1];
    cell.detailLab2.text = self.dataArr[indexPath.row][2];
    if (indexPath.row == 0)
    {
        cell.detailLab1.textColor = COLOR3;
        cell.detailLab2.textColor = COLOR3;
    }
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

- (void)updateBtnClick
{
    CGLevelUpVC *vc = [[CGLevelUpVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGVersionHeaderV *)topView
{
    if (!_topView)
    {
        _topView = [[CGVersionHeaderV alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerViewHeight)];
        
    }
    return _topView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
