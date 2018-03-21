//
//  CGLoginViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLoginViewController.h"
#import "CGRegisterViewController.h"
#import "CGForgetPwdViewController.h"
#import "CGBindAccViewController.h"

@interface CGLoginViewController () {
    CGFloat cellH;
    
    NSMutableArray *titleArr;
    
    UITextField *tbxMobile;
    NSString *mobileStr;
    NSString *passwordStr;
}

@end

@implementation CGLoginViewController

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    //设置数据源
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"login_icon_mobile",@"请输入手机号"]];
    [titleArr addObject:@[@"login_icon_pwd",@"请输入密码"]];
    
    cellH = SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-65*2-55-45;
    if(cellH<200) {
        cellH = 250;
    }
    
}

/**
 *  关闭窗体
 */
- (void)leftButtonItemClick {
    NSLog(@"关闭窗体");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //默认定位到手机号码输入框
    [tbxMobile becomeFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return 2;
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
        case 2:
            //注册、找回密码
            return 45;
            
            break;
        case 3: {
            //第三方登录
            return cellH;
            
            break;
        }
            
        default:
            break;
    }
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGLoginViewControllerCell";
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
            
            //创建“手机号码”输入框
            UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(40, 5, backView.frame.size.width-50, 30)];
            [tbxContent setPlaceholder:itemArr[1]];
            [tbxContent setTextAlignment:NSTextAlignmentLeft];
            [tbxContent setTextColor:COLOR3];
            [tbxContent setFont:FONT16];
            [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
            [tbxContent setValue:FONT16 forKeyPath:@"_placeholderLabel.font"];
            if(indexPath.row==0) {
                //手机号码
                tbxMobile = tbxContent;
                [tbxContent setKeyboardType:UIKeyboardTypeNumberPad];
                
                [tbxContent setText:mobileStr];
                
            }else if(indexPath.row==1) {
                //密码
                [tbxContent setSecureTextEntry:YES];
                
                [tbxContent setText:passwordStr];
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
            //创建“登录”按钮
            UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-20, 40)];
            [btnLogin setBackgroundColor:MAIN_COLOR];
            [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
            [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnLogin.titleLabel setFont:FONT17];
            [btnLogin.layer setCornerRadius:3.0];
            [btnLogin addTarget:self action:@selector(btnLoginClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnLogin];
            
            break;
        }
        case 2: {
            //注册、找回密码
            UIButton *btnRegister = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
            [btnRegister setTitle:@"新用户注册" forState:UIControlStateNormal];
            [btnRegister setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [btnRegister.titleLabel setFont:FONT14];
            [btnRegister setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btnRegister addTarget:self action:@selector(btnRegisterClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnRegister];
            
            //忘记密码
            UIButton *btnForgetPwd = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, 10, 80, 20)];
            [btnForgetPwd setTitle:@"忘记密码?" forState:UIControlStateNormal];
            [btnForgetPwd setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [btnForgetPwd.titleLabel setFont:FONT14];
            [btnForgetPwd setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            [btnForgetPwd addTarget:self action:@selector(btnForgetPwdClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnForgetPwd];
            
            break;
        }
        case 3: {
            //第三方登录
            
            //创建“背景层”
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, cellH-150, SCREEN_WIDTH, 200)];
            [cell.contentView addSubview:backView];
            
            //创建“线条”
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [backView addSubview:lineView];
            
            //创建“使用第三方登录”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake((backView.frame.size.width-140)/2, 0, 140, 20)];
            [lbMsg setText:@"第三方登录"];
            [lbMsg setTextColor:COLOR9];
            [lbMsg setTextAlignment:NSTextAlignmentCenter];
            [lbMsg setFont:FONT15];
            [lbMsg setBackgroundColor:[UIColor whiteColor]];
            [backView addSubview:lbMsg];
            
            NSMutableArray *titleArr = [NSMutableArray array];
            [titleArr addObject:@[@"login_icon_weixin",@"微信登录"]];
            [titleArr addObject:@[@"login_icon_qq",@"QQ登录"]];
            
            NSInteger titleNum = [titleArr count];
            
            CGFloat tWidth = (SCREEN_WIDTH-100*titleNum)/2;
            for (int i=0; i<titleNum; i++) {
                
                NSArray *itemArr = [titleArr objectAtIndex:i];
                
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(tWidth+100*i, 35, 99, 80)];
                [btnFunc setTitle:itemArr[1] forState:UIControlStateNormal];
                [btnFunc setTitleColor:COLOR9 forState:UIControlStateNormal];
                [btnFunc.titleLabel setFont:FONT13];
                [btnFunc setImage:[UIImage imageNamed:itemArr[0]] forState:UIControlStateNormal];
                btnFunc.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
                [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(btnFunc.imageView.frame.size.height+15 ,-btnFunc.imageView.frame.size.width, 0.0,0.0)];
                //图片距离右边框距离减少图片的宽度，其它不边
                [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(-15, 0.0,0.0, -btnFunc.titleLabel.bounds.size.width)];
                [btnFunc setTag:i];
                [btnFunc addTarget:self action:@selector(btnFuncWxLoginClick:) forControlEvents:UIControlEventTouchUpInside];
                [backView addSubview:btnFunc];
                
            }
            
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
            //密码
            if (textField.text.length > 12) {
                textField.text = [textField.text substringToIndex:12];
            }
            passwordStr = textField.text;
            
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
 *  登录按钮事件
 */
- (void)btnLoginClick:(UIButton *)btnSender {
    NSLog(@"登录按钮事件");
    [self.view endEditing:YES];
    
    if (![mobileStr isPhoneNumber]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
    if (![passwordStr isMinLength:6 andMaxLength:12]) {
        [MBProgressHUD showError:@"请输入6~12位密码" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMsg:@"登录中..." toView:self.view];
    
    //广告号IDFA
    NSString *idfaStr = [[HelperManager CreateInstance] getIDFA];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"login" forKey:@"act"];
    [param setValue:mobileStr forKey:@"mobile"];
    [param setValue:passwordStr forKey:@"password"];
    [param setValue:idfaStr forKey:@"device_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"登录成功" toView:self.view];
            NSDictionary *dataDic = [json objectForKey:@"data"];
            
            //预先清除
            [[HelperManager CreateInstance] clearAcc];
            
            //设置本地缓存
            [self setUserDefaultInfo:dataDic];
            
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGIN_SUCCESS object:nil userInfo:nil];
            
            //延迟1秒退出
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if(self.callback) {
                    self.callback(YES);
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            });
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [MBProgressHUD hideHUD:self.view];
    }];
}

/**
 *  注册按钮事件
 */
- (void)btnRegisterClick:(UIButton *)btnSender {
    NSLog(@"注册按钮事件");
    CGRegisterViewController *registerView = [[CGRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerView animated:YES];
}

/**
 *  找回密码按钮事件
 */
- (void)btnForgetPwdClick:(UIButton *)btnSender {
    NSLog(@"找回密码按钮事件");
    CGForgetPwdViewController *forgetView = [[CGForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:forgetView animated:YES];
}

/**
 *  第三方登录
 */
- (void)btnFuncWxLoginClick:(UIButton *)btnSender {
    NSLog(@"第三方登录");
    
    switch (btnSender.tag) {
        case 0: {
            //微信登录
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
                if (error) {
                    [MBProgressHUD showError:@"登陆失败" toView:self.view];
                } else {
                    UMSocialUserInfoResponse *resp = result;
                    NSMutableDictionary *param = [NSMutableDictionary dictionary];
                    [param setValue:@"2" forKey:@"type"];
                    [param setValue:resp.uid forKey:@"union_id"];
                    [self thridLoginWithDict:param];
                    
                    // 授权信息
                    NSLog(@"Wechat uid: %@", resp.uid);
                    NSLog(@"Wechat openid: %@", resp.openid);
                    NSLog(@"Wechat accessToken: %@", resp.accessToken);
                    NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
                    NSLog(@"Wechat expiration: %@", resp.expiration);
                    
                    // 用户信息
                    NSLog(@"Wechat name: %@", resp.name);
                    NSLog(@"Wechat iconurl: %@", resp.iconurl);
                    NSLog(@"Wechat gender: %@", resp.gender);
                    
                    // 第三方平台SDK源数据
                    NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
                }
            }];
            
            break;
        }
        case 1: {
            //QQ登录
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
                if (error) {
                    [MBProgressHUD showError:@"登陆失败" toView:self.view];
                } else {
                    UMSocialUserInfoResponse *resp = result;
                    
                    NSMutableDictionary *param = [NSMutableDictionary dictionary];
                    [param setValue:@"1" forKey:@"type"];
                    [param setValue:resp.uid forKey:@"union_id"];
                    [self thridLoginWithDict:param];
                }
            }];
            
            break;
        }
            
        default:
            break;
    }
    
}

/**
 *  第三方账号登录
 */
- (void)thridLoginWithDict:(NSMutableDictionary *)param {
    
    //广告标示识号IDFA
    NSString *idfaStr = [[HelperManager CreateInstance] getIDFA];
    
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"thirdAccountLogin" forKey:@"act"];
    [param setValue:idfaStr forKey:@"device_id"];
    
    [MBProgressHUD showMsg:@"登录中..." toView:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                
                //预先清除
                [[HelperManager CreateInstance] clearAcc];
                
                //设置本地缓存
                [self setUserDefaultInfo:dataDic];
                
                NSString *is_bind = [dataDic objectForKey:@"is_bind"];
                if([is_bind isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:@"登录成功" toView:self.view];
                    
                    //推送别名设置
                    [JPUSHService setTags:nil alias:idfaStr fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                        NSLog(@"%d-------------%@,-------------%@",iResCode,iTags,iAlias);
                    }];
                    
                    //发通刷新首页通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGIN_SUCCESS object:nil userInfo:nil];
                    
                    //延迟1秒
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self dismissViewControllerAnimated:YES completion:nil];
                    });
                }else{
                    //去绑定
                    CGBindAccViewController *accountView = [[CGBindAccViewController alloc] init];
                    accountView.paramDic = param;
                    [self.navigationController pushViewController:accountView animated:YES];
                }
                
            }
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
