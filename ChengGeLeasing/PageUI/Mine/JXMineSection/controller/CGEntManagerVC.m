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
// account id
@property (nonatomic, strong) NSString *accountid;
// endDate
@property (nonatomic, strong) NSString *endDateStr;
@end

@implementation CGEntManagerVC

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    self.title = currentTitle;
    // set origin data
    [self prepareForDataWithDataArr:@[@"",@"",@"",@""]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getBussiessInfoData];
}

- (void)prepareForDataWithDataArr:(NSArray *)dataArr
{
    
    [self.dataArr removeAllObjects];
    [self.dataArr addObject:@[accountIDText,dataArr[0]]];
    [self.dataArr addObject:@[accountNameText,dataArr[1]]];
    [self.dataArr addObject:@[expireTimeText,dataArr[2]]];
    [self.dataArr addObject:@[memberInfoText,dataArr[3]]];
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
        vc.account_id = self.accountid;
        vc.endDate = self.endDateStr;
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
        
        [self requestEnterpriseNameChanged:content completeBlock:^(BOOL isSuccess, NSDictionary *dict) {
            if (isSuccess)
            {
                //上传
                [self.dataArr replaceObjectAtIndex:1 withObject:@[accountNameText,content]];
                [self.tableView reloadData];
            }
        }];
        
    };
    self.popup = [KLCPopup popupWithContentView:popupView
                                       showType:KLCPopupShowTypeGrowIn
                                    dismissType:KLCPopupDismissTypeGrowOut
                                       maskType:KLCPopupMaskTypeDimmed
                       dismissOnBackgroundTouch:NO
                          dismissOnContentTouch:NO];
    [self.popup show];
}

#pragma mark - Get Enterprise Info Data
- (void)getBussiessInfoData
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"ucenter";
    param[@"act"] = @"getBusinessAccountInfo";
    [MBProgressHUD showSimple:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               NSDictionary *dict = [json objectForKey:@"data"];
                               self.accountid = dict[@"account_id"];
                               self.endDateStr = dict[@"end_date"];
                               NSString *numInfo = [NSString stringWithFormat:@"%@/%@",dict[@"group_num"],dict[@"account_num"]];
                               NSArray *dataArr = @[dict[@"account_id"],dict[@"account_name"],dict[@"end_date"],numInfo];
                               [self prepareForDataWithDataArr:dataArr];
                               [self.tableView reloadData];
                           }
                           else
                           {
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                       }];
}

#pragma mark - Change Enterprise Name
- (void)requestEnterpriseNameChanged:(NSString *)accountName completeBlock:(void(^)(BOOL isSuccess,NSDictionary *dict))block
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"ucenter";
    param[@"act"] = @"editAccountInfo";
    param[@"account_id"] = self.accountid;
    param[@"account_name"] = accountName;
    [MBProgressHUD showSimple:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               NSDictionary *dict = [json objectForKey:@"data"];
                               block(YES,dict);
                           }
                           else
                           {
                               block(NO,nil);
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                       }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
