//
//  CGFindAddToCustomerViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/15.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGFindAddToCustomerViewController.h"
#import "CGCustomerXiangmuView.h"
#import "CGCustomerFormatView.h"

@interface CGFindAddToCustomerViewController () {
    NSArray *titleArr;
    
    //项目ID
    NSString *proId;
    //项目名层
    NSString *proName;
    //业态ID
    NSString *cate_id;
    //业态名称
    NSString *cate_name;
}

@end

@implementation CGFindAddToCustomerViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"加为客户";
    
    //设置数据源
    titleArr = @[@"加入项目",@"业态"];
    
    //创建“确定”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    [btnFunc setTitle:@"确定" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [titleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGFindAddToCustomerViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 90, 25)];
    [lbMsg setText:[titleArr objectAtIndex:indexPath.row]];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [cell.contentView addSubview:lbMsg];
    
    //创建“内容”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-130, 25)];
    [lbMsg2 setTextColor:COLOR3];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT16];
    [lbMsg2 setTag:indexPath.row+100];
    [cell.contentView addSubview:lbMsg2];
    
    if (indexPath.row ==0)
    {
        if (!IsStringEmpty(self.chuBeiKeHuID) && IsStringEmpty(proName))
        {
            proId = self.chuBeiKeHuID;
            proName = @"储备客户";
            [lbMsg2 setText:proName];
        }
        else
        {
            if (IsStringEmpty(proName))
            {
                proId = [HelperManager CreateInstance].proId;
                proName = [HelperManager CreateInstance].proName;
                [lbMsg2 setText:[HelperManager CreateInstance].proName];
            }
            else
            {
                [lbMsg2 setText:proName];
            }
        }
    }
    
    //创建“右侧尖头”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
    [imgView setImage:[UIImage imageNamed:@"mine_arrow_right"]];
    [cell.contentView addSubview:imgView];
    
    //创建“分割线”
    if(indexPath.row<[titleArr count]-1) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 44.5, SCREEN_WIDTH-100, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [cell.contentView addSubview:lineView];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *lbMsg = [cell.contentView viewWithTag:indexPath.row+100];
    
    switch (indexPath.row) {
        case 0: {
            //选择项目
            CGCustomerXiangmuView *xiangmuView = [[CGCustomerXiangmuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270) titleStr:@"加入项目"];
            [xiangmuView getXiangmuList];
            xiangmuView.callBack = ^(NSString *pro_id, NSString *pro_name) {
                NSLog(@"项目ID：%@-项目名称：%@",pro_id,pro_name);
                [lbMsg setText:pro_name];
                proId = pro_id;
                proName = pro_name;
                
            };
            [xiangmuView show];
            
            break;
        }
        case 1: {
            //选择业态
            
            //项目验证
            if(IsStringEmpty(proId)) {
                [MBProgressHUD showError:@"请选择项目" toView:self.view];
                return;
            }
            
            CGCustomerFormatView *formatView = [[CGCustomerFormatView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270) titleStr:@"业态"];
            [formatView getFormatList:proId];
            formatView.callBack = ^(NSString *cateId, NSString *cateName) {
                NSLog(@"业态ID：%@-业态名称：%@",cateId,cateName);
                [lbMsg setText:cateName];
                
                cate_id = cateId;
                cate_name = cateName;
                
            };
            [formatView show];
            
            break;
        }
            
        default:
            break;
    }
}

/**
 *  确定按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"确定");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;

    //资源ID验证
    if(IsStringEmpty(self.old_id)) {
        [MBProgressHUD showError:@"资源ID不能为空" toView:self.view];
        return;
    }
    
    //项目验证
    if(IsStringEmpty(proId)) {
        [MBProgressHUD showError:@"请选择项目" toView:self.view];
        return;
    }
    
    //业态验证
    if(IsStringEmpty(cate_id)) {
        [MBProgressHUD showError:@"业态验证" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMsg:@"数据上传中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"setNewCustByDepot" forKey:@"act"];
    [param setValue:self.old_id forKey:@"old_id"];
    [param setValue:proId forKey:@"pro_id"];
    [param setValue:cate_id forKey:@"cate_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"加为客户成功" toView:self.view];
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [MBProgressHUD hideHUD:self.view];
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
