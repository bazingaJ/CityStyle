//
//  CGPaymentVC.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGPaymentVC.h"
#import "CGPaymentTopV.h"

static NSString *const currentCompleteTitle = @"支付完成";
static NSString *const currentFailTitle = @"支付失败";
static NSString *const cellTitleText1 = @"单价";
static NSString *const cellTitleText2 = @"席位购买";
static NSString *const cellTitleText3 = @"购买时长";
static NSString *const cellTitleText4 = @"合计";
static NSString *const alertPicText = @"remind";
static NSString *const attentionText = @"如需发票，请联系";
static NSString *const attentionMobile = @"4000-025-114";
static NSString *const sureBtnText = @"确定";
static NSString *const repayText = @"重新支付";
static NSString *const cellIdentifier = @"CGPaymentCell1";

static const CGFloat topHeight = 270.f;

static const CGFloat bottomHeight = 60.f;

@interface CGPaymentVC ()
@property (nonatomic, strong) CGPaymentTopV *topView;
@end

@implementation CGPaymentVC

- (void)viewDidLoad
{
    self.topH = topHeight;
    self.bottomH = bottomHeight;
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = self.payStatus == YES ?  currentCompleteTitle : currentFailTitle;
    [self prepareForData];
    [self createUI];
    
}

- (void)prepareForData
{
    
    [self.dataArr removeAllObjects];
    [self.dataArr addObject:@[cellTitleText1,cellTitleText2,cellTitleText3,cellTitleText4]];
    [self.dataArr addObject:@[@"99元/人/月",@"5个",@"12月",@"5940元"]];
    
}

- (void)createUI
{
    self.view.backgroundColor = GRAY_COLOR;
    [self.view addSubview:self.topView];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(15, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT -HOME_INDICATOR_HEIGHT - 60, SCREEN_WIDTH - 30, 45);
    [sureBtn setTitle:repayText forState:UIControlStateNormal];
    [sureBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:MAIN_COLOR];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 5;
    [self.view addSubview:sureBtn];
    
    if (self.payStatus)
    {
        [sureBtn setTitle:sureBtnText forState:UIControlStateNormal];
    }
    
    self.tableView.scrollEnabled = NO;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *arr = self.dataArr[0];
    return arr.count;
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
    cell.textLabel.text = self.dataArr[0][indexPath.row];
    cell.detailTextLabel.text = self.dataArr[1][indexPath.row];
    cell.detailTextLabel.textColor = COLOR3;
    if (indexPath.row == 0 || indexPath.row == 3)
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
    
    return 40.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    
    UIImageView *alertImage = [[UIImageView alloc] init];
    alertImage.frame = CGRectMake(15, (40 - 15) * 0.5, 15, 15);
    alertImage.image = [UIImage imageNamed:alertPicText];
    [view addSubview:alertImage];
    
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.frame = CGRectMake(40, (40 - 20) * 0.5, SCREEN_WIDTH - 40, 20);
    detailLab.text = attentionText;
    detailLab.font = FONT11;
    detailLab.textColor = COLOR3;
    [view addSubview:detailLab];
    
    UIButton *attentionMobileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    attentionMobileBtn.frame = CGRectMake(123, (40 - 30) * 0.5, 100, 30);
    [attentionMobileBtn setTitle:attentionMobile forState:UIControlStateNormal];
    [attentionMobileBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    attentionMobileBtn.titleLabel.font = FONT11;
    [attentionMobileBtn addTarget:self action:@selector(attentionMobileBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:attentionMobileBtn];
    
    return view;
}

- (void)attentionMobileBtnClick
{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",attentionMobile];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}


- (CGPaymentTopV *)topView
{
    if (!_topView)
    {
        _topView = [[CGPaymentTopV alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, topHeight) payStatus:self.payStatus];
        
    }
    return _topView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
