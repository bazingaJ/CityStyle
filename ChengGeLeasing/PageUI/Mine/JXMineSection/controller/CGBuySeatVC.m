//
//  CGBuySeatVC.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGBuySeatVC.h"


static NSString *const currentTitle = @"购买席位";
static NSString *const priceText = @"单价";
static NSString *const seatSaleText = @"席位购买";
static NSString *const timingSaleText = @"购买时长";
static NSString *const tatolText = @"合计";
static NSString *const detailText = @"时长按剩余月数计算。";
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

static const NSInteger minNumberCount = 1;

@interface CGBuySeatVC ()
@property (nonatomic, strong) NSArray *originArr;
@property (nonatomic, strong) UIButton *countBtn;


/**
 购买席位的个数
 */
@property (nonatomic, strong) NSString *seatNum;

/**
 购买时长的月份数
 */
@property (nonatomic, strong) NSString *monthNum;

/**
 续费和购买席位支付界面公用model
 */
@property (nonatomic, strong) CGRenewModel *model;
@property (nonatomic, strong) NSString *order_id;
@end

@implementation CGBuySeatVC

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
    
    // tableview 标题数据准备
    self.originArr = @[@[priceText,seatSaleText,timingSaleText,tatolText,wechatDetailText],
                       @[payTypeText,wechatPayText,aliPayText,aliPayDetailText]];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    // 先将传过来的到期时间转换成日期格式
    NSDate *endDate = [format dateFromString:self.endTime];
    
    // 然后将日期个数转换成单个的月格式
    [format setDateFormat:@"yyyy"];
    NSString *nowYear = [format stringFromDate:[NSDate date]];
    NSString *endYear = [format stringFromDate:endDate];
    
    NSInteger year = ([endYear integerValue]-[nowYear integerValue]) * 12;
    
    // 然后将日期个数转换成单个的月格式
    [format setDateFormat:@"MM"];
    NSString *nowMonth = [format stringFromDate:[NSDate date]];
    NSString *endMonth = [format stringFromDate:endDate];
    // 然后两个月份格式的日期相减得出购买时长
    self.monthNum = [NSString stringWithFormat:@"%ld",(long)([endMonth integerValue]-[nowMonth integerValue] + year)];
    self.seatNum = [NSString stringWithFormat:@"%ld",(long)minNumberCount];
    // prepare origin data
    NSString *unitPrice = [NSString stringWithFormat:@"%@元/人/月",VIP_PRICE];
    self.model = [CGRenewModel new];
    self.model.unit_price = unitPrice;
    self.model.seats_number = self.seatNum;
    self.model.month = [NSString stringWithFormat:@"%@月",self.monthNum];
    self.model.total_prices = [NSString stringWithFormat:@"%ld元",(long)([VIP_PRICE integerValue] * [self.seatNum integerValue] * [self.monthNum integerValue])];
    self.model.payType = @"1";
    self.model.isRead = @"1";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissVC) name:@"paymentDismiss" object:nil];
    
}

- (void)createUI
{
    UIView *bottomView = [UIView new];
    bottomView.frame = CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT- 45, SCREEN_WIDTH, 45);
    bottomView.backgroundColor = MAIN_COLOR;
    [self.view addSubview:bottomView];
    
    NSString *btnTitleStr = [NSString stringWithFormat:@"合计：%@",self.model.total_prices];
    self.countBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.countBtn.frame = CGRectMake(0, 1, SCREEN_WIDTH * 0.5, 44);
    [self.countBtn setTitle:btnTitleStr forState:UIControlStateNormal];
    [self.countBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    self.countBtn.titleLabel.font = FONT20;
    [self.countBtn setBackgroundColor:WHITE_COLOR];
    [bottomView addSubview:self.countBtn];
    
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(SCREEN_WIDTH * 0.5, 0, SCREEN_WIDTH * 0.5, 45);
    [payBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    payBtn.titleLabel.font = FONT20;
    [payBtn setBackgroundColor:MAIN_COLOR];
    [payBtn addTarget:self action:@selector(goPayClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:payBtn];
}

- (void)dismissVC
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
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
//        return 3;
        return 2;
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
        if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3)
        {
            if (!cell1)
            {
                cell1 = [[[NSBundle mainBundle] loadNibNamed:@"CGLevelUpCell" owner:nil options:nil]objectAtIndex:0];
            }
            cell1.itemLab1.text = self.originArr[0][indexPath.row];
            cell1.detailLab1.text = @[self.model.unit_price,@"",self.model.month,self.model.total_prices][indexPath.row];
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
            cell2.countLab.text = self.model.seats_number;
            cell2.detailLab2.text = @"个";
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
            cell1.detailLab1.text = @"";
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
        alertBtn.frame =CGRectMake(15, (40 - 20) * 0.5, 20, 20);
        [alertBtn setBackgroundImage:[UIImage imageNamed:agreePhotoText] forState:UIControlStateNormal];
        [alertBtn setBackgroundImage:[UIImage imageNamed:agredPhotoText] forState:UIControlStateSelected];
        [alertBtn addTarget:self action:@selector(alertBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        alertBtn.selected = YES;
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
        self.model.payType = @"1";
    }
    else if (indexPath.section == 1 && indexPath.row == 2)
    {
        NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:1];
        CGLevelUpCell *cell1 = [self.tableView cellForRowAtIndexPath:indexPath1];
        CGLevelUpCell *cell2 = [self.tableView cellForRowAtIndexPath:indexPath];
        cell1.selectBtn.hidden = YES;
        cell2.selectBtn.hidden = NO;
        self.model.payType = @"2";
    }
}

// plus button click event method
- (void)plusBtnClickWithButton:(UIButton *)sender
{
    
    CGLevelUpCell *cell2 = (CGLevelUpCell *)sender.superview.superview;
    NSString *numberText = cell2.countLab.text;
    cell2.countLab.text = @([numberText integerValue] + 1).stringValue;
    self.model.seats_number = cell2.countLab.text;
    // 总价同时发生改变
    NSIndexPath *index = [NSIndexPath indexPathForRow:3 inSection:0];
    CGLevelUpCell *cell4 = [self.tableView cellForRowAtIndexPath:index];
    cell4.detailLab1.text = [NSString stringWithFormat:@"%ld元",(long)([VIP_PRICE integerValue] * [self.model.seats_number integerValue] * [self.model.month integerValue])];
    self.model.total_prices = cell4.detailLab1.text;
    NSString *btnTitleStr = [NSString stringWithFormat:@"合计：%@",self.model.total_prices];
    [self.countBtn setTitle:btnTitleStr forState:UIControlStateNormal];
    
}

// miuns button click event method
- (void)miunsBtnClickWithButton:(UIButton *)sender
{
    
    CGLevelUpCell *cell2 = (CGLevelUpCell *)sender.superview.superview;
    NSString *numberText = cell2.countLab.text;
    // less minMonthCount can not miuns
    if ([numberText integerValue] > minNumberCount)
    {
        cell2.countLab.text = @([numberText integerValue] - 1).stringValue;
        self.model.seats_number = cell2.countLab.text;
    }
    // same time totle_price make the change
    NSIndexPath *index = [NSIndexPath indexPathForRow:3 inSection:0];
    CGLevelUpCell *cell4 = [self.tableView cellForRowAtIndexPath:index];
    cell4.detailLab1.text = [NSString stringWithFormat:@"%ld元",(long)([VIP_PRICE integerValue] * [self.model.seats_number integerValue] * [self.model.month integerValue])];
    self.model.total_prices = cell4.detailLab1.text;
    NSString *btnTitleStr = [NSString stringWithFormat:@"合计：%@",self.model.total_prices];
    [self.countBtn setTitle:btnTitleStr forState:UIControlStateNormal];
}

- (void)alertBtnClick:(UIButton *)button
{
    
    button.selected = !button.selected;
    if (button.isSelected)
    {
        self.model.isRead = @"1";
    }
    else
    {
        self.model.isRead = @"2";
    }
}

- (void)agreeBtnClick:(UIButton *)button
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"default";
    param[@"act"] = @"getAboutInfo";
    [MBProgressHUD showSimple:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUDForView:self.view];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               NSDictionary *dict = [json objectForKey:@"data"];
                               NSString *paymentUrl = dict[@"pay_item"];
                               CGWKWebViewController *vc = [CGWKWebViewController new];
                               [vc setTitle:@"服务协议"];
                               [vc setUrl:paymentUrl];
                               [self.navigationController pushViewController:vc animated:YES];
                           }
                           else
                           {
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           [MBProgressHUD hideHUDForView:self.view];
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                       }];
}

- (void)goPayClick
{
    
    if ([self.model.isRead isEqualToString:@"2"])
    {
        [MBProgressHUD showError:@"请阅读服务协议" toView:self.view];
        return;
    }
    
    if([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"weixin://"]])
    {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"app"] = @"ucenter";
        param[@"act"] = @"createVipOrder";
        param[@"type"] = @"3";
        param[@"vip_type"] = @"2";
        param[@"member_num"] = self.model.seats_number;
        param[@"price"] = VIP_PRICE;
        param[@"vip_time"] = self.model.month;
        param[@"business_id"] = self.account_id;
        [MBProgressHUD showMsg:@"正在生成订单" toView:self.view];
        [HttpRequestEx postWithURL:SERVICE_URL
                            params:param
                           success:^(id json) {
                               NSString *code = [json objectForKey:@"code"];
                               NSString *msg  = [json objectForKey:@"msg"];
                               if ([code isEqualToString:SUCCESS])
                               {
                                   NSDictionary *dict = [json objectForKey:@"data"];
                                   self.order_id = dict[@"order_id"];
                                   if ([self.model.payType isEqualToString:@"1"])
                                   {
                                       [self paymentByWechat:dict[@"order_id"]];
                                   }
                                   else
                                   {
                                       [self paymentByAlipay:dict[@"order_id"]];
                                   }
                               }
                               else
                               {
                                   [MBProgressHUD hideHUDForView:self.view];
                                   [MBProgressHUD showError:msg toView:self.view];
                               }
                           }
                           failure:^(NSError *error) {
                               [MBProgressHUD hideHUDForView:self.view];
                               [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                           }];
    }
    else
    {
        [MBProgressHUD showMessage:@"您的手机未安装微信" toView:self.view];
    }
    
    
}

#pragma mark - 向微信发起支付
- (void)paymentByWechat:(NSString *)orderID
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = @"1";
    param[@"type_id"] = orderID;
    [HttpRequestEx postWithURL:WECHATPAY_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUDForView:self.view];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               // 设置区别字符 区别是续费还是席位购买 以便回到正确的页面
                               NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
                               [us setObject:@"xiwei" forKey:@"payType"];
                               [us synchronize];
                               
                               NSDictionary *dict = [json objectForKey:@"data"];
                               PayReq* req = [[PayReq alloc] init];
                               req.partnerId=dict[@"partnerid"];
                               req.prepayId=dict[@"prepayid"];
                               req.nonceStr = dict[@"noncestr"];
                               req.timeStamp = [dict[@"timestamp"] intValue];
                               req.package = dict[@"package"];
                               req.sign = dict[@"sign"];
                               [WXApi sendReq:req];
                           }
                           else
                           {
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           [MBProgressHUD hideHUDForView:self.view];
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                       }];
    
}

/**
 微信支付回调方法
 
 @param resp 回调实例
 */
- (void)onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]])
    {
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode)
        {
            case 0:
            {
                [MBProgressHUD showMessage:@"支付成功" toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    CGPaymentVC *paymentVC = [CGPaymentVC new];
                    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:paymentVC];
                    paymentVC.payStatus = YES;
                    paymentVC.orderID = self.order_id;
                    [self presentViewController:nav animated:YES completion:nil];
                });
            }
                break;
            case -1:
            {
                [MBProgressHUD showMessage:@"支付失败" toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    CGPaymentVC *paymentVC = [CGPaymentVC new];
                    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:paymentVC];
                    paymentVC.payStatus = NO;
                    paymentVC.orderID = self.order_id;
                    [self.navigationController pushViewController:nav animated:YES];
                });
            }
                break;
            case -2:
            {
                [MBProgressHUD showMessage:@"支付取消" toView:self.view];
            }
                break;
            default:
            {
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            }
                
                break;
        }
    }
}

#pragma mark - 向支付宝发起支付
- (void)paymentByAlipay:(NSString *)orderID
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = @"1";
    param[@"type_id"] = orderID;
    [MBProgressHUD showSimple:self.view];
    [HttpRequestEx postWithURL:ALIPAY_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUDForView:self.view];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               NSString *orderString = [json objectForKey:@"data"];
                               [self alipay:orderString];
                           }
                           else
                           {
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           [MBProgressHUD hideHUDForView:self.view];
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                       }];
}

- (void)alipay:(NSString *)orderString
{
    NSString *appScheme = @"AliPayChengGe";
    
    // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
    if ([orderString isKindOfClass:[NSString class]] && orderString.length > 0)
    {
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic)
         {
             NSLog(@"代码中reslut = %@",resultDic);
             NSString *resultStatus = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
             if ([resultStatus isEqualToString:@"9000"])
             {
                 [MBProgressHUD showMessage:@"支付成功" toView:self.view];
                 //                 [self afterPayOption];
             }
             else if ([resultStatus isEqualToString:@"4000"])
             {
                 [MBProgressHUD showMessage:@"订单支付失败" toView:self.view];
             }
             else if ([resultStatus isEqualToString:@"5000"])
             {
                 [MBProgressHUD showMessage:@"重复请求" toView:self.view];
             }
             else if ([resultStatus isEqualToString:@"6001"])
             {
                 [MBProgressHUD showMessage:@"支付取消" toView:self.view];
             }
             else if ([resultStatus isEqualToString:@"6002"])
             {
                 [MBProgressHUD showMessage:@"网络连接出错" toView:self.view];
             }
             else
             {
                 [MBProgressHUD showMessage:@"支付失败" toView:self.view];
             }
         }];
    }
    
}

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
