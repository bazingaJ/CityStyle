//
//  CGMineUpdatePwdViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineUpdatePwdViewController.h"
#import "UIButton+CountDown.h"

@interface CGMineUpdatePwdViewController () {
    NSMutableArray *titleArr;
    
    UITextField *tbxCode;
    NSString *mobileStr;
    NSString *codeStr;
    NSString *passwordStr;
    NSString *passwordReStr;
}

@end

@implementation CGMineUpdatePwdViewController

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改密码";
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    //当前用户手机号
    mobileStr = [HelperManager CreateInstance].mobile;
    
    //设置数据源
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"login_icon_vcode",@"请输入验证码",@"1"]];
    [titleArr addObject:@[@"login_icon_pwd",@"请输入6～12位密码",@"0"]];
    [titleArr addObject:@[@"login_icon_pwd",@"请再次输入密码",@"0"]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //默认定位到手机号码输入框
    [tbxCode becomeFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==1) {
        return [titleArr count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            //手机号
            return 45;
            
            break;
        case 1:
            //账号、密码
            return 65;
            
            break;
        case 2:
            //登录按钮
            return 55;
            
            break;
            
        default:
            break;
    }
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGMineUpdatePwdViewControllerCell";
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
            //手机号
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 25)];
            [lbMsg setText:[NSString stringWithFormat:@"已绑定手机号：%@",mobileStr]];
            [lbMsg setTextColor:COLOR6];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT16];
            [cell.contentView addSubview:lbMsg];
            
            break;
        }
        case 1: {
            
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
            if(indexPath.row==0) {
                [tbxContent setText:codeStr];
                [tbxContent setKeyboardType:UIKeyboardTypeNumberPad];
                tbxCode = tbxContent;
                
                //创建“获取验证码”按钮
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-130, 10, 120, 40)];
                [btnFunc setTitle:@"获取验证码" forState:UIControlStateNormal];
                [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnFunc.titleLabel setFont:FONT16];
                [btnFunc setBackgroundColor:MAIN_COLOR];
                [btnFunc.layer setCornerRadius:3.0];
                [btnFunc addTarget:self action:@selector(btnFuncSendClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btnFunc];
                
            }else if(indexPath.row==1) {
                //密码
                [tbxContent setSecureTextEntry:YES];
                [tbxContent setText:passwordStr];
            }else if(indexPath.row==2) {
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
        case 2: {
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
            //验证码
            if (textField.text.length > 6) {
                textField.text = [textField.text substringToIndex:6];
            }
            codeStr = textField.text;
            
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
        case 102: {
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
        [MBProgressHUD showError:@"当前登录手机号码不正确" toView:self.view];
        return;
    }
    //验证码验证
    if (![codeStr isNumeric] || codeStr.length != 6) {
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
    
    //广告号IDFA
    NSString *idfaStr = [[HelperManager CreateInstance] getIDFA];
    
    [MBProgressHUD showMsg:@"修改中..." toView:self.view];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"resetPwdByUser" forKey:@"act"];
    [param setValue:codeStr forKey:@"vcode"];
    [param setValue:passwordStr forKey:@"password"];
    [param setValue:idfaStr forKey:@"device_id"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"修改密码成功" toView:self.view];
            
            //停顿0.5秒后返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
