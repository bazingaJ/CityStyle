//
//  CGBindAccSettingPwdViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGBindAccSettingPwdViewController.h"

@interface CGBindAccSettingPwdViewController () {
    NSMutableArray *titleArr;
    
    UITextField *tbxPassword;
    NSString *passwordStr;
    NSString *passwordReStr;
}

@end

@implementation CGBindAccSettingPwdViewController

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置密码";
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    //设置数据源
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"login_icon_pwd",@"请输入6～12位密码",@"0"]];
    [titleArr addObject:@[@"login_icon_pwd",@"请再次输入密码",@"0"]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //默认定位到手机号码输入框
    [tbxPassword becomeFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return [titleArr count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            //密码
            return 65;
            
            break;
        case 1:
            //登录按钮
            return 55;
            
            break;
            
            break;
            
        default:
            break;
    }
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGBindAccSettingPwdViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    switch (indexPath.section) {
        case 0: {
            NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
            
            //创建“背景层”
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH-20, 40)];
            [cell.contentView addSubview:backView];
            
            UIImage *img = [UIImage imageNamed:itemArr[0]];
            CGFloat tW = img.size.width;
            CGFloat tH = img.size.height;
            
            //创建“图标”
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (40-tH)/2, tW, tH)];
            [imgView setImage:img];
            [backView addSubview:imgView];
            
            //创建"输入框"
            UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(40, 5, backView.frame.size.width-50, 30)];
            [tbxContent setPlaceholder:itemArr[1]];
            [tbxContent setTextAlignment:NSTextAlignmentLeft];
            [tbxContent setTextColor:COLOR3];
            [tbxContent setFont:FONT16];
            [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
            [tbxContent setValue:FONT16 forKeyPath:@"_placeholderLabel.font"];
            [tbxContent setTag:100+indexPath.row];
            [tbxContent setSecureTextEntry:YES];
            if(indexPath.row==0) {
                //密码
                [tbxContent setText:passwordStr];
            }else if(indexPath.row==1) {
                //确认密码
                [tbxContent setText:passwordReStr];
            }
            [tbxContent setDelegate:self];
            [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
            [tbxContent setTag:indexPath.row+100];
            [backView addSubview:tbxContent];
            
            //创建“下划线”
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, backView.frame.size.width, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [backView addSubview:lineView];
            
            break;
        }
        case 1: {
            //创建“注册”按钮
            UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-20, 40)];
            [btnLogin setBackgroundColor:MAIN_COLOR];
            [btnLogin setTitle:@"提交" forState:UIControlStateNormal];
            [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnLogin.titleLabel setFont:FONT17];
            [btnLogin.layer setCornerRadius:3.0];
            [btnLogin addTarget:self action:@selector(btnRegisterClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnLogin];
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)textFieldDidChange:(UITextField *)textField {
    switch (textField.tag) {
        case 100: {
            //密码
            if (textField.text.length > 12) {
                textField.text = [textField.text substringToIndex:12];
            }
            passwordStr = textField.text;
            
            break;
        }
        case 101: {
            //确认密码
            if (textField.text.length > 12) {
                textField.text = [textField.text substringToIndex:12];
            }
            passwordReStr = textField.text;
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark---scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

/**
 *  注册按钮事件
 */
- (void)btnRegisterClick:(UIButton *)btnSender {
    NSLog(@"注册按钮事件");
    [self.view endEditing:YES];
    
    //手机号码验证
    if (![self.mobileStr isPhoneNumber]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
    //验证码验证
    if (![self.codeStr isNumeric] || self.codeStr.length != 6) {
        [MBProgressHUD showError:@"请输入6位数字验证码" toView:self.view];
        return;
    }
    //密码验证
    if (![passwordStr isMinLength:6 andMaxLength:12]) {
        [MBProgressHUD showError:@"请输入6~12位密码" toView:self.view];
        return;
    }else if (![passwordStr isEqualToString:passwordReStr]) {
        [MBProgressHUD showError:@"两次密码输入不一致" toView:self.view];
        return;
    }
    //类型验证
    if(IsStringEmpty(self.typeStr)) {
        [MBProgressHUD showError:@"登录类型丢失" toView:self.view];
        return;
    }
    //第三方标识错误
    if(IsStringEmpty(self.union_id)) {
        [MBProgressHUD showError:@"第三方唯一标识丢失" toView:self.view];
        return;
    }

    //广告号IDFA
    NSString *idfaStr = [[HelperManager CreateInstance] getIDFA];

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"thirdAccountBind" forKey:@"act"];
    [param setValue:self.mobileStr forKey:@"mobile"];
    [param setValue:self.codeStr forKey:@"vcode"];
    [param setValue:self.typeStr forKey:@"type"];
    [param setValue:self.union_id forKey:@"union_id"];
    [param setValue:idfaStr forKey:@"device_id"];
    
    [MBProgressHUD showMsg:@"绑定中..." toView:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"绑定成功" toView:self.view];
            
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                //预先清除
                [[HelperManager CreateInstance] clearAcc];
                
                //设置本地缓存
                [self setUserDefaultInfo:dataDic];
                
                //推送别名设置
                [JPUSHService setTags:nil alias:idfaStr fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    NSLog(@"%d-------------%@,-------------%@",iResCode,iTags,iAlias);
                }];
                
                //发通刷新首页通知
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGIN_SUCCESS object:nil userInfo:nil];
                
                //延迟0.5秒
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }
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
