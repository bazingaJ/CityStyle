//
//  CGLevelUpVC.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/21.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGLevelUpVC.h"
#import "CGLevelUpCell.h"

static NSString *const currentTitle = @"升级";
static NSString *const priceText = @"单价";
static NSString *const seatSaleText = @"席位购买";
static NSString *const timingSaleText = @"购买时长";
static NSString *const tatolText = @"合计";
static NSString *const detailText = @"席位购买最低5个起，购买时长最低12月起。";
static NSString *const payTypeText = @"付款方式";
static NSString *const wechatPayText = @"微信钱包支付";
static NSString *const wechatDetailText = @"储蓄卡、信用卡都可以使用";
static NSString *const aliPayText = @"支付宝支付";
static NSString *const aliPayDetailText = @"储蓄卡、信用卡都可以使用";
static NSString *const readText = @"我已阅读并同意签署";
static NSString *const agreementText = @"《服务协议》";

static NSString *const alertPhotoText = @"remind";
static NSString *const agreePhotoText = @"agree_blank";
static NSString *const agredPhotoText = @"agree";

static const NSInteger minNumberCount = 5;
static const NSInteger minMonthCount = 12;

@interface CGLevelUpVC ()<JXLevelUpDelegate>
@property (nonatomic, strong) NSArray *originArr;
@end

@implementation CGLevelUpVC

- (void)viewDidLoad {
    self.bottomH = 45;
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = currentTitle;
    [self prepareForData];
    [self createUI];
}

- (void)prepareForData
{
    self.originArr = @[@[priceText,seatSaleText,timingSaleText,tatolText,wechatDetailText],
                       @[payTypeText,wechatPayText,aliPayText,aliPayDetailText]];
}

- (void)createUI 
{
    UIView *bottomView = [UIView new];
    bottomView.frame = CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT- 45, SCREEN_WIDTH, 45);
    bottomView.backgroundColor = MAIN_COLOR;
    [self.view addSubview:bottomView];
    
    UIButton *countBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    countBtn.frame = CGRectMake(0, 1, SCREEN_WIDTH * 0.5, 44);
    [countBtn setTitle:@"合计：5940元" forState:UIControlStateNormal];
    [countBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    countBtn.titleLabel.font = FONT20;
    [countBtn setBackgroundColor:WHITE_COLOR];
    [bottomView addSubview:countBtn];

    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(SCREEN_WIDTH * 0.5, 0, SCREEN_WIDTH * 0.5, 45);
    [payBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    payBtn.titleLabel.font = FONT20;
    [payBtn setBackgroundColor:MAIN_COLOR];
    [bottomView addSubview:payBtn];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return 4;
    }
    else
    {
        return 3;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        return 50;
    }
    else
    {
        if (indexPath.row == 0)
        {
            return 50;
        }
        else
        {
            return 80;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier1 = @"CGLevelUpCell1";
    static NSString *cellIdentifier2 = @"CGLevelUpCell2";
    static NSString *cellIdentifier3 = @"CGLevelUpCell3";
    CGLevelUpCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    CGLevelUpCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
    CGLevelUpCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0 || indexPath.row == 3)
        {
            if (!cell1)
            {
                cell1 = [[[NSBundle mainBundle] loadNibNamed:@"CGLevelUpCell" owner:nil options:nil]objectAtIndex:0];
            }
            cell1.itemLab1.text = self.originArr[0][indexPath.row];
            cell1.detailLab1.text = @[@"99元/人/月",@"",@"",@"5940元"][indexPath.row];
            return cell1;
        }
        else
        {
            if (!cell2)
            {
                cell2 = [[[NSBundle mainBundle] loadNibNamed:@"CGLevelUpCell" owner:nil options:nil]objectAtIndex:1];
            }
            cell2.delegate = self;
            cell2.itemLab2.text = self.originArr[0][indexPath.row];
            cell2.countLab.text = @[@"",@"5",@"12",@""][indexPath.row];
            cell2.detailLab2.text = @[@"",@"个",@"月",@""][indexPath.row];
            return cell2;
        }
    }
    else
    {
        if (indexPath.section == 1 && indexPath.row == 0)
        {
            if (!cell1)
            {
                cell1 = [[[NSBundle mainBundle] loadNibNamed:@"CGLevelUpCell" owner:nil options:nil]objectAtIndex:0];
            }
            cell1.itemLab1.text = payTypeText;
            return cell1;
        }
        else
        {
            if (!cell3)
            {
                cell3 = [[[NSBundle mainBundle] loadNibNamed:@"CGLevelUpCell" owner:nil options:nil]objectAtIndex:2];
            }
            cell3.delegate = self;
            cell3.payTitleLab.text = self.originArr[1][indexPath.row];
            if (indexPath.row == 2)
            {
                cell3.payImage.image = [UIImage imageNamed:@"alipay"];
                cell3.selectBtn.hidden = YES;
            }
            return cell3;
        }
    }
    
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
    
    if (section == 0)
    {
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        
        UIImageView *alertImage = [[UIImageView alloc] init];
        alertImage.frame = CGRectMake(15, (40 - 15) * 0.5, 15, 15);
        alertImage.image = [UIImage imageNamed:alertPhotoText];
        [view addSubview:alertImage];
        
        UILabel *detailLab = [[UILabel alloc] init];
        detailLab.frame = CGRectMake(40, (40 - 20) * 0.5, SCREEN_WIDTH - 40, 20);
        detailLab.text = detailText;
        detailLab.font = FONT11;
        detailLab.textColor = COLOR3;
        [view addSubview:detailLab];
        return view;
    }
    else
    {
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        
        UIButton *alertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        alertBtn.frame =CGRectMake(15, (40 - 15) * 0.5, 15, 15);
        [alertBtn setImage:[UIImage imageNamed:agreePhotoText] forState:UIControlStateNormal];
        [alertBtn setImage:[UIImage imageNamed:agredPhotoText] forState:UIControlStateSelected];
        [alertBtn addTarget:self action:@selector(alertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        alertBtn.selected = NO;
        [view addSubview:alertBtn];
        
        UILabel *detailLab = [[UILabel alloc] init];
        detailLab.frame = CGRectMake(40, (40 - 20) * 0.5, 110, 20);
        detailLab.text = readText;
        detailLab.font = FONT11;
        detailLab.textColor = COLOR6;
        [view addSubview:detailLab];
        
        UIButton *agreementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        agreementBtn.frame = CGRectMake(123, (40 - 30) * 0.5, 100, 30);
        [agreementBtn setTitle:agreementText forState:UIControlStateNormal];
        [agreementBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        agreementBtn.titleLabel.font = FONT11;
        [agreementBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:agreementBtn];
        
        return view;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:2 inSection:1];
        CGLevelUpCell *cell1 = [self.tableView cellForRowAtIndexPath:indexPath];
        CGLevelUpCell *cell2 = [self.tableView cellForRowAtIndexPath:indexPath2];
        cell1.selectBtn.hidden = NO;
        cell2.selectBtn.hidden = YES;
    }
    else if (indexPath.section == 1 && indexPath.row == 2)
    {
        NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:1];
        CGLevelUpCell *cell1 = [self.tableView cellForRowAtIndexPath:indexPath1];
        CGLevelUpCell *cell2 = [self.tableView cellForRowAtIndexPath:indexPath];
        cell1.selectBtn.hidden = YES;
        cell2.selectBtn.hidden = NO;
    }
}

// plus button click event method
- (void)plusBtnClickWithButton:(UIButton *)sender
{
    
    CGLevelUpCell *cell2 = (CGLevelUpCell *)sender.superview.superview;
    NSString *numberText = cell2.countLab.text;
    cell2.countLab.text = @([numberText integerValue] + 1).stringValue;
}

// miuns button click event method
- (void)miunsBtnClickWithButton:(UIButton *)sender
{
    
    CGLevelUpCell *cell2 = (CGLevelUpCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell2];
    // distinguish which one is number or month
    if (indexPath.row == 1)//------number
    {
        NSString *numberText = cell2.countLab.text;
        // less minMonthCount can not miuns
        if ([numberText integerValue] > minNumberCount)
        {
            cell2.countLab.text = @([numberText integerValue] - 1).stringValue;
        }
        
    }
    else//-----month
    {
        NSString *numberText = cell2.countLab.text;
        // less minMonthCount can not miuns
        if ([numberText integerValue] > minMonthCount)
        {
            cell2.countLab.text = @([numberText integerValue] - 1).stringValue;
        }
    }
    
}

- (void)alertBtnClick:(UIButton *)button
{
    
    button.selected = !button.selected;
}

- (void)agreeBtnClick:(UIButton *)button
{
    
    [MBProgressHUD showMessage:@"暂无服务协议" toView:self.view];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
