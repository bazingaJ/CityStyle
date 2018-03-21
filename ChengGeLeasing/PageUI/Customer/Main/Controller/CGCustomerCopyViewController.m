//
//  CGCustomerCopyViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/21.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGCustomerCopyViewController.h"
#import "CGCustomerXiangmuView.h"
#import "CGCustomerFormatView.h"

@interface CGCustomerCopyViewController () {
    NSArray *titleArr;
    
    //业态ID
    NSString *cate_id;
    //业态名称
    NSString *cate_name;
}

@end

@implementation CGCustomerCopyViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"复制客户";
    
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
    static NSString *cellIndentifier = @"CGCustomerCopyViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
    [lbMsg setText:[titleArr objectAtIndex:indexPath.row]];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [cell.contentView addSubview:lbMsg];
    
    //创建“内容”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH-140, 25)];
    if(indexPath.row==0) {
        //项目
        [lbMsg2 setText:self.proName];
    }else if(indexPath.row==1) {
        //业态
        [lbMsg2 setText:cate_name];
    }
    [lbMsg2 setTextColor:COLOR3];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT16];
    [lbMsg2 setTag:indexPath.row+100];
    [cell.contentView addSubview:lbMsg2];
    
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
    UILabel *lbMsg = [cell.contentView viewWithTag:100+indexPath.row];
    switch (indexPath.row) {
        case 0: {
            //加入项目
            
            CGCustomerXiangmuView *xiangmuView = [[CGCustomerXiangmuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270) titleStr:@"加入项目"];
            [xiangmuView getXiangmuList];
            xiangmuView.callBack = ^(NSString *pro_id, NSString *pro_name) {
                NSLog(@"项目ID：%@-项目名称：%@",pro_id,pro_name);
                [lbMsg setText:pro_name];
                
                //项目ID、名称
                self.proId = pro_id;
                self.proName = pro_name;
                
            };
            [xiangmuView show];
            
            break;
        }
        case 1: {
            //业态
            
            //项目验证
            if(IsStringEmpty(self.proId)) {
                [MBProgressHUD showError:@"请选择项目" toView:self.view];
                return;
            }
            
            CGCustomerFormatView *formatView = [[CGCustomerFormatView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270) titleStr:@"业态"];
            [formatView getFormatList:self.proId];
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
    
    //原项目ID验证
    if(IsStringEmpty(self.old_proId)) {
        [MBProgressHUD showError:@"原项目ID不能为空" toView:self.view];
        return;
    }
    
    //新项目ID验证
    if(IsStringEmpty(self.proId)) {
        [MBProgressHUD showError:@"新项目ID不能为空" toView:self.view];
        return;
    }
    
    //业态ID验证
    if(IsStringEmpty(cate_id)) {
        [MBProgressHUD showError:@"业态ID不能为空" toView:self.view];
        return;
    }
    
    //客户ID验证
    if(IsStringEmpty(self.cust_id)) {
        [MBProgressHUD showError:@"客户ID不能为空" toView:self.view];
        return;
    }
    
    NSString *titleStr = [NSString stringWithFormat:@"确定复制客户至%@项目？",self.proName];
    UIAlertController * aler = [UIAlertController alertControllerWithTitle:titleStr message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"复制");

        [MBProgressHUD showMsg:@"复制中..." toView:self.view];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:@"customer" forKey:@"app"];
        [param setValue:@"copyCust" forKey:@"act"];
        [param setValue:self.old_proId forKey:@"pro_id"];
        [param setValue:self.proId forKey:@"new_pro_id"];
        [param setValue:cate_id forKey:@"cate_id"];
        [param setValue:self.cust_id forKey:@"cust_id"];
        [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
            [MBProgressHUD hideHUD:self.view];
            NSString *msg = [json objectForKey:@"msg"];
            NSString *code = [json objectForKey:@"code"];
            if([code isEqualToString:SUCCESS]) {
                [MBProgressHUD showSuccess:@"复制成功" toView:self.view];
                
                //延迟一秒返回
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if(self.callBack) {
                        self.callBack();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }else{
                [MBProgressHUD showError:msg toView:self.view];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",[error description]);
            [MBProgressHUD hideHUD:self.view];
        }];
        
    }];
    [aler addAction:cancelAction];
    [aler addAction:okAction];
    [self presentViewController:aler animated:YES completion:nil];
    
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
