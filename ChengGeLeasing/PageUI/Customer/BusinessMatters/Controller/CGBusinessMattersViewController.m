//
//  CGBusinessMattersViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGBusinessMattersViewController.h"
#import "CGBusinessMattersCell.h"
#import "CGBusinessMattersDetailViewController.h"
#import "CGBusinessMattersAddViewController.h"

@interface CGBusinessMattersViewController ()
{
    UIButton *btnFunc;
}
@end

@implementation CGBusinessMattersViewController

- (void)viewDidLoad {
    if (self.isSign  &&[self.isMine isEqualToString:@"1"])
    {
        if (self.isAllCust)
        {
            [self setBottomH:45];
        }
        else
        {
            [self setBottomH:90];
        }
        
    }
    else
    {
        [self setBottomH:45];
    }
    
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    
    self.title = @"经营事项";
    
    if (self.isSign && [self.isMine isEqualToString:@"1"])
    {
        if (!self.isAllCust)
        {
            //创建“添加经营事项”
            btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-90, SCREEN_WIDTH, 45)];
            [btnFunc setTitle:@"添加经营事项" forState:UIControlStateNormal];
            [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT17];
            [btnFunc setImage:[UIImage imageNamed:@"customer_business_add"] forState:UIControlStateNormal];
            [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            [btnFunc setBackgroundColor:MAIN_COLOR];
            [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btnFunc];
        }
    }
   
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //获取客户最高意向度
    [self getCustTopIntent];
    
    //刷新数据
    [self.tableView.mj_header beginRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
//    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
    
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    [btnFunc setBackgroundColor:GRAY_COLOR];
    [btnFunc setTitle:[HelperManager CreateInstance].proName forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT14];
    [btnFunc setImage:[UIImage imageNamed:@"customer_icon_contact"] forState:UIControlStateNormal];
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    return btnFunc;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGBusinessMattersCell";
    CGBusinessMattersCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGBusinessMattersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGBusinessMattersModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setBusinessMattersModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CGBusinessMattersModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    
    //跳转至详情
    CGBusinessMattersDetailViewController *detailView = [[CGBusinessMattersDetailViewController alloc] init];
    detailView.business_id = model.id;
    [self.navigationController pushViewController:detailView animated:YES];
    
}

/**
 *  添加经营事项
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"添加经营事项");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGBusinessMattersAddViewController *addView = [[CGBusinessMattersAddViewController alloc] init];
    addView.type = 2;
    addView.cust_id = self.cust_id;
    addView.cust_name = self.cust_name;
    addView.cust_cover = self.cust_cover;
    [self.navigationController pushViewController:addView animated:YES];
    
}

/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"getOperateListByCust" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.cust_id forKey:@"cust_id"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[CGBusinessMattersModel mj_objectWithKeyValues:itemDic]];
                }
                
                //当前总数
                NSString *dataNum = [dataDic objectForKey:@"count"];
                if(!IsStringEmpty(dataNum)) {
                    self.totalNum = [dataNum intValue];
                }else{
                    self.totalNum = 0;
                }
            }
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
    }];
}

//获取客户最高意向度
-(void)getCustTopIntent
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getCustTopIntent" forKey:@"act"];
    [param setValue:self.cust_id forKey:@"cust_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
    {
        NSString * code = json[@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            if ([json[@"data"][@"intent"] floatValue] >=90)
            {
                self.isSign = YES;
            }
            else
            {
                self.isSign = NO;
            }
            if (self.isSign && [self.isMine isEqualToString:@"1"])
            {
                btnFunc.hidden =NO;
                self.tableView.height = SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT -HOME_INDICATOR_HEIGHT -45;
            }
            else
            {
                btnFunc.hidden =YES;
                self.tableView.height = SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT -HOME_INDICATOR_HEIGHT ;
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

@end
