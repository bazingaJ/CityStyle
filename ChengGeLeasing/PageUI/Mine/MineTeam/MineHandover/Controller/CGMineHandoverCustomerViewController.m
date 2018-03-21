//
//  CGMineHandoverCustomerViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineHandoverCustomerViewController.h"
#import "CGMineHandoverCustomerCell.h"
#import "CGMineReceiverViewController.h"

@interface CGMineHandoverCustomerViewController ()

@end

@implementation CGMineHandoverCustomerViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setRightButtonItemTitle:@"全选"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择交接客户";
    
    //创建“确定”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    [btnFunc setTitle:@"下一步" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

/**
 *  全选按钮事件
 */
- (void)rightButtonItemClick {
    NSLog(@"全选按钮事件");
    
    for (int i=0; i<self.dataArr.count; i++) {
        CGCustomerModel *model = [self.dataArr objectAtIndex:i];
        model.is_selected = YES;
    }
    [self.tableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGMineHandoverCustomerCell";
    CGMineHandoverCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGMineHandoverCustomerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGCustomerModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setCustomerModel:model];
    
    return cell;
}

/**
 *  下一步按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"下一步按钮事件");
    
    //客户验证
    NSMutableArray *memberArr = [NSMutableArray array];
    for (int i=0; i<self.dataArr.count; i++) {
        CGCustomerModel *model = [self.dataArr objectAtIndex:i];
        if(!model.is_selected) continue;
        [memberArr addObject:model.id];
    }
    if(!memberArr.count) {
        [MBProgressHUD showError:@"请选择交接的客户" toView:self.view];
        return;
    }
    NSString *customerStr = [memberArr componentsJoinedByString:@","];
    
    CGMineReceiverViewController *customerView = [[CGMineReceiverViewController alloc] init];
    customerView.pro_id = self.pro_id;
    customerView.member_id = self.member_id;
    customerView.customerStr = customerStr;
    [self.navigationController pushViewController:customerView animated:YES];
    
}

/**
 *  获取数据源
 */
- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getCustListByUser" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [param setValue:self.member_id forKey:@"member"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSArray *dataList = [json objectForKey:@"data"];
            self.dataArr = [CGCustomerModel mj_objectArrayWithKeyValuesArray:dataList];
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
