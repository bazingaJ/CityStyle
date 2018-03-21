//
//  CGLeaseMattersViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLeaseMattersViewController.h"
#import "CGLeaseMattersAddViewController.h"
#import "CGLeaseMattersDetailViewController.h"
#import "CGLeaseMattersCell.h"

@interface CGLeaseMattersViewController ()
{
    //是否可以添加招租事项 yes不可以  no可以
    BOOL isAddLease;
}

@end

@implementation CGLeaseMattersViewController

- (void)viewDidLoad
{
    if ([self.isMine isEqualToString:@"1"])
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

    self.title = @"招租事项";
    
    if ([self.isMine isEqualToString:@"1"])
    {
        if (!self.isAllCust)
        {
            //创建“添加招租事项”
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-90, SCREEN_WIDTH, 45)];
            [btnFunc setTitle:@"添加招租事项" forState:UIControlStateNormal];
            [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT17];
            [btnFunc setImage:[UIImage imageNamed:@"customer_lease_add"] forState:UIControlStateNormal];
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
    static NSString *cellIndentifier = @"CGLeaseMattersCell";
    CGLeaseMattersCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGLeaseMattersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGLeaseMattersModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setLeaseMattersModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CGLeaseMattersModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    
    //跳转至招租事项详情
    CGLeaseMattersDetailViewController *detailView = [[CGLeaseMattersDetailViewController alloc] init];
    detailView.lease_id = model.id;
    [self.navigationController pushViewController:detailView animated:YES];
}

/**
 *  添加招租事项
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"添加招租事项");
    
    if (isAddLease)
    {
        [MBProgressHUD showError:@"意向度已到100%，无需再添加招租事项" toView:self.view];
        return;
    }
    
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGLeaseMattersAddViewController *addView = [[CGLeaseMattersAddViewController alloc] init];
    addView.type = 2;
    if (self.type ==4)
    {
        addView.isChuBeiCust =YES;
    }
    addView.cust_id = self.cust_id;
    addView.cust_name = self.cust_name;
    [self.navigationController pushViewController:addView animated:YES];
    
}

/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"getIntentListByCust" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.cust_id forKey:@"cust_id"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0)
            {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr)
                {
                    [self.dataArr addObject:[CGLeaseMattersModel mj_objectWithKeyValues:itemDic]];
                    CGLeaseMattersModel *model = self.dataArr[0];
                    if ([model.intent isEqualToString:@"100"])
                    {
                        isAddLease = YES;
                    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
