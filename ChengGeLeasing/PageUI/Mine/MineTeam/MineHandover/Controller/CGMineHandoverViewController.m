//
//  CGMineHandoverViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineHandoverViewController.h"
#import "CGMineHandoverCustomerViewController.h"

@interface CGMineHandoverViewController () {
    CGTeamMemberModel *currentMemModel;
}

@end

@implementation CGMineHandoverViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"交接人";
    
    //创建“确定”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    [btnFunc setTitle:@"下一步" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGMineHandoverCell";
    CGMineHandoverCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGMineHandoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGTeamMemberModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setDelegate:self];
    [cell setTeamMemberModel:model];
    
    return cell;
}

/**
 *  选择交接人委托代理
 */
- (void)CGMineHandoverCellClick:(CGTeamMemberModel *)model {
    NSLog(@"选择交接人委托代理");
    
    for (int i=0; i<self.dataArr.count; i++) {
        CGTeamMemberModel *model = [self.dataArr objectAtIndex:i];
        model.is_selected = NO;
    }
    model.is_selected = YES;
    
    //当前对象
    currentMemModel = model;
    
    [self.tableView reloadData];
    
}

/**
 *  下一步按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"下一步");
    
    //交接人验证
    if(IsStringEmpty(currentMemModel.id)) {
        [MBProgressHUD showError:@"请选择交接人" toView:self.view];
        return;
    }
    
    CGMineHandoverCustomerViewController *customerView = [[CGMineHandoverCustomerViewController alloc] init];
    customerView.pro_id = self.pro_id;
    customerView.member_id = currentMemModel.id;
    [self.navigationController pushViewController:customerView animated:YES];
    
}

/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getUserListNoLimit" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSArray *dataList = [json objectForKey:@"data"];
            self.dataArr = [CGTeamMemberModel mj_objectArrayWithKeyValuesArray:dataList];
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
