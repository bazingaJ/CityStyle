//
//  CGPayOrderVC.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGPayOrderVC.h"
#import "CGPayOrderCell.h"
#import "CGOrderDetailVC.h"
#import "CGRenewPayVC.h"
#import "CGBuySeatVC.h"

static NSString *const currentTitle = @"支付与订单";

static NSString *const cellIdentifier = @"CGPayOrderCell1";

static NSString *const payBtnText = @"去续费";

static NSString *const seatBtnText = @"购买席位";

static const CGFloat topHeight = 60;

static const CGFloat bottomHeight = 45;

@interface CGPayOrderVC ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *bottomBtn;

@end

@implementation CGPayOrderVC

- (void)viewDidLoad
{
    self.topH = topHeight;
    self.bottomH = bottomHeight;
    [super viewDidLoad];
    self.title = currentTitle;
    [self prepareForData];
    [self createUI];
}
- (void)prepareForData
{
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:@[@"",@"",@""]];
}
- (void)createUI
{
    UIButton *renewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [renewBtn setTitle:@"续费订单" forState:UIControlStateNormal];
    [renewBtn setBackgroundColor:NAV_COLOR];
    renewBtn.titleLabel.font= FONT15;
    [renewBtn addTarget:self action:@selector(renewBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:renewBtn];
    [renewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.5);
        make.height.mas_equalTo(topHeight);
    }];
    
    UIButton *seatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [seatBtn setTitle:@"席位订单" forState:UIControlStateNormal];
    [seatBtn setBackgroundColor:NAV_COLOR];
    seatBtn.titleLabel.font= FONT15;
    [seatBtn addTarget:self action:@selector(seatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seatBtn];
    [seatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self.view);
        make.left.mas_equalTo(renewBtn.mas_right).offset(1);
        make.height.mas_equalTo(renewBtn);
    }];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = LINE_COLOR;
    self.lineView.alpha = 0.5;
    [self.view addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(renewBtn);
        make.height.mas_equalTo(3);
    }];
    
    self.bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomBtn setTitle:payBtnText forState:UIControlStateNormal];
    [self.bottomBtn setBackgroundColor:MAIN_COLOR];
    self.bottomBtn.titleLabel.font = FONT15;
    [self.bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-HOME_INDICATOR_HEIGHT);
        make.height.mas_equalTo(45);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGPayOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CGPayOrderCell class]) owner:nil options:nil]objectAtIndex:0];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CGOrderDetailVC *vc = [[CGOrderDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)renewBtnClick
{
    if (self.lineView.frame.origin.x > SCREEN_WIDTH * 0.5 - 100)
    {
        [UIView animateWithDuration:.3f delay:0.01 usingSpringWithDamping:.5f initialSpringVelocity:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.lineView.transform = CGAffineTransformIdentity;
            [self.tableView.mj_header beginRefreshing];
            [self.bottomBtn setTitle:payBtnText forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

- (void)seatBtnClick
{
    
    if (self.lineView.frame.origin.x < 100)
    {
        [UIView animateWithDuration:.3f delay:0.01 usingSpringWithDamping:0.5f initialSpringVelocity:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.lineView.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH * 0.5, 0);
            [self.tableView.mj_header beginRefreshing];
            [self.bottomBtn setTitle:seatBtnText forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            
            
        }];
    }
}

- (void)bottomBtnClick
{
    if ([self.bottomBtn.currentTitle isEqualToString:payBtnText])
    {
        CGRenewPayVC *vc = [[CGRenewPayVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else
    {
        CGBuySeatVC *vc = [[CGBuySeatVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)getDataList:(BOOL)isMore
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endDataRefresh];
    });
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
