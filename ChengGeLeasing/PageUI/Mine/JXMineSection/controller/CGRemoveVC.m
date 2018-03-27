//
//  CGRemoveVC.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGRemoveVC.h"
#import "CGMemberModel.h"
#import "CGMemberCell.h"

static NSString *const currentTitle = @"移交账户";

static NSString *const unselectPicText = @"mine_icon_normal";

static NSString *const selectPicText = @"select";

static NSString *const bottomBtnText = @"确定";

static NSString *const cellIdentifier = @"CGMemberCell1";

static const CGFloat bottomBtnHeight = 45.f;

@interface CGRemoveVC ()
@property (nonatomic, strong) NSIndexPath *beforeIndex;
@end

@implementation CGRemoveVC

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    self.bottomH = bottomBtnHeight;
    [super viewDidLoad];
    self.title = currentTitle;
    [self prepareData];
    [self createUI];
}

- (void)prepareData
{
    
    CGMemberModel *model = [CGMemberModel new];
    model.name = @"王红红";
    model.mobile = @"13260894473";
    [self.dataArr removeAllObjects];
    [self.dataArr addObject:model];
    [self.dataArr addObject:model];
    [self.dataArr addObject:model];
    [self.dataArr addObject:model];
    [self.dataArr addObject:model];
    
}

- (void)createUI
{
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setTitle:bottomBtnText forState:UIControlStateNormal];
    [bottomBtn setBackgroundColor:MAIN_COLOR];
    bottomBtn.titleLabel.font = FONT15;
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-HOME_INDICATOR_HEIGHT);
        make.height.mas_equalTo(45);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CGMemberCell class]) owner:nil options:nil]objectAtIndex:1];
    }
    CGMemberModel *model = self.dataArr[indexPath.row];
    cell.remove_model = model;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.beforeIndex)
    {
        CGMemberCell *cell = [tableView cellForRowAtIndexPath:self.beforeIndex];
        cell.removeBtn.selected = NO;
    }
    CGMemberCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
    currentCell.removeBtn.selected = YES;
    self.beforeIndex = indexPath;
    
}

- (void)bottomBtnClick
{
    
    [MBProgressHUD showMessage:@"已移除" toView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
