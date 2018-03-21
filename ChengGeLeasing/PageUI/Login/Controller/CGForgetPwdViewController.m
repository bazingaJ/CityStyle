//
//  CGForgetPwdViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGForgetPwdViewController.h"
#import "UIButton+CountDown.h"

@interface CGForgetPwdViewController () {
    NSMutableArray *titleArr;
    
    UITextField *tbxMobile;
    NSString *mobileStr;
    NSString *codeStr;
    NSString *passwordStr;
    NSString *passwordReStr;
}

@end

@implementation CGForgetPwdViewController

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"找回密码";
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    //设置数据源
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"login_icon_mobile",@"请输入手机号",@"0"]];
    [titleArr addObject:@[@"login_icon_vcode",@"请输入验证码",@"1"]];
    [titleArr addObject:@[@"login_icon_pwd",@"请输入6～12位密码",@"0"]];
    [titleArr addObject:@[@"login_icon_pwd",@"请再次输入密码",@"0"]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //默认定位到手机号码输入框
    [tbxMobile becomeFirstResponder];
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
            //账号、密码
            return 65;
            
            break;
        case 1:
            //登录按钮
            return 55;
            
            break;
            
        default:
            break;
    }
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGForgetPwdViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            if(indexPath.row==0 || indexPath.row==1) {
                [tbxContent setKeyboardType:UIKeyboardTypeNumberPad];
                if(indexPath.row==0) {
                    //手机号码
                    tbxMobile = tbxContent;
                    
                    [tbxContent setText:mobileStr];
                    
                }else if(indexPath.row==1) {
                    //创建“发送验证码”按钮
                    //backView.width = SCREEN_WIDTH-150;
                    
                    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-130, 10, 120, 40)];
                    [btnFunc setTitle:@"获取验证码" forState:UIControlStateNormal];
                    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [btnFunc.titleLabel setFont:FONT16];
                    [btnFunc setBackgroundColor:MAIN_COLOR];
                    [btnFunc.layer setCornerRadius:3.0];
                    [btnFunc addTarget:self action:@selector(btnFuncSendClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:btnFunc];
                    
                    [tbxContent setText:codeStr];
                    
                }
                
            }else if(indexPath.row==2) {
                //密码
                [tbxContent setSecureTextEntry:YES];
                [tbxContent setText:passwordStr];
                
            }else if(indexPath.row==3) {
                //确认密码
                [tbxContent setSecureTextEntry:YES];
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
            //创建“提交”按钮
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-20, 40)];
            [btnFunc setBackgroundColor:MAIN_COLOR];
            [btnFunc setTitle:@"提交" forState:UIControlStateNormal];
            [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT17];
            [btnFunc.layer setCornerRadius:3.0];
            [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnFunc];
            
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
            //手机号码
            if (textField.text.length > 11) {
                textField.text = [textField.text substringToIndex:11];
            }
            mobileStr = textField.text;
            
            break;
        }
        case 101: {
            //验证码
            if (textField.text.length > 6) {
                textField.text = [textField.text substringToIndex:6];
            }
            codeStr = textField.text;
            
            break;
        }
        case 102: {
            //密码
            if (textField.text.length > 12) {
                textField.text = [textField.text substringToIndex:12];
            }
            passwordStr = textField.text;
            
            break;
        }
        case 103: {
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
 *  发送验证码事件
 */
- (void)btnFuncSendClick:(UIButton *)btnSender {
    NSLog(@"发送验证码");
    [self.view endEditing:YES];
    if (![mobileStr isPhoneNumber])
    {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
    [btnSender startWithTime:59 title:@"重新获取" countDownTitle:@"s" mainColor:MAIN_COLOR countColor:UIColorFromRGBWith16HEX(0xE5E5E5)];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"sendSMS" forKey:@"act"];
    [param setValue:mobileStr forKey:@"mobile"];
    [param setValue:@"2" forKey:@"type"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
            
            NSDictionary *dataDic = [json objectForKey:@"data"];
            NSString *code = [dataDic objectForKey:@"code"];
            NSLog(@"验证码：%@",code);
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
}

/**
 *  提交按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"提交按钮事件");
    [self.view endEditing:YES];
    
    //手机号验证
    if (![mobileStr isPhoneNumber]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
    //验证码验证
    if (![codeStr isNumeric] || codeStr.length != 6) {
        [MBProgressHUD showError:@"请输入6位数字验证码" toView:self.view];
        return;
    }
    //密码验证
    if (![passwordStr isMinLength:6 andMaxLength:12]) {
        [MBProgressHUD showError:@"请输入6~12位新密码" toView:self.view];
        return;
    }else if (![passwordStr isEqualToString:passwordReStr]) {
        [MBProgressHUD showError:@"两次密码输入不一致" toView:self.view];
        return;
    }
    
    //广告号IDFA
    NSString *idfaStr = [[HelperManager CreateInstance] getIDFA];
    
    [MBProgressHUD showMsg:@"重置中..." toView:self.view];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"resetPwd" forKey:@"act"];
    [param setValue:mobileStr forKey:@"mobile"];
    [param setValue:passwordStr forKey:@"password"];
    [param setValue:codeStr forKey:@"vcode"];
    [param setValue:idfaStr forKey:@"device_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"重置密码成功" toView:self.view];
            
            //清除缓存信息
            [[HelperManager CreateInstance] clearAcc];
            
            //停顿0.5秒后返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //跳转到APP首页
                [APP_DELEGATE enterMainVC];
                
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
