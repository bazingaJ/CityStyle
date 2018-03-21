//
//  CGLinkmanAddViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLinkmanAddViewController.h"
#import "LTPickerView.h"
#import "AddressPickView.h"

@interface CGLinkmanAddViewController () {
    NSMutableArray *titleArr;
}

@end

@implementation CGLinkmanAddViewController

- (void)viewDidLoad {
    [self setRightButtonItemTitle:@"保存"];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置数据源
    //备注：标题/描述/是否必填/是否可编辑
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"联系人",@"姓名(必填)",@"1",@"0"]];
    [titleArr addObject:@[@"电话",@"手机/固定电话",@"1",@"0"]];
    [titleArr addObject:@[@"性别",@"请选择性别",@"0",@"1"]];
    [titleArr addObject:@[@"职位",@"请输入职位",@"0",@"0"]];
    [titleArr addObject:@[@"邮箱",@"请输入邮箱",@"0",@"0"]];
    [titleArr addObject:@[@"地址",@"请选择地址",@"1",@"1"]];
    [titleArr addObject:@[@"详细",@"街道、门牌号",@"0",@"0"]];
    
    //添加时需要初始化对象
    if(!_linkModel) {
        _linkModel = [CGLinkmanModel new];
    }
    
}

/**
 *  保存按钮事件
 */
- (void)rightButtonItemClick {
    NSLog(@"保存按钮事件");
    [self.view endEditing:YES];
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    //客户ID验证
    if(IsStringEmpty(self.cust_id)) {
        [MBProgressHUD showError:@"客户ID不能为空" toView:self.view];
        return;
    }
    
    //联系人姓名验证
    NSString *nameStr = self.linkModel.name;
    if(IsStringEmpty(nameStr)) {
        [MBProgressHUD showError:@"请输入姓名" toView:self.view];
        return;
    }else if([NSString stringContainsEmoji:nameStr]) {
        [MBProgressHUD showError:@"姓名不能包含表情" toView:self.view];
        return;
    }if([nameStr length]>10) {
        [MBProgressHUD showError:@"姓名不能超过10个字符" toView:self.view];
        return;
    }
    
    //电话验证
    NSString *mobileStr = self.linkModel.mobile;
    if(IsStringEmpty(mobileStr)) {
        [MBProgressHUD showError:@"请输入电话" toView:self.view];
        return;
    }
//    if (![mobileStr isPhoneNumber]) {
//        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
//        return;
//    }
    
    [MBProgressHUD showMsg:@"保存中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"editLinkman" forKey:@"act"];
    [param setValue:self.cust_id forKey:@"cust_id"];
    [param setValue:self.linkModel.id forKey:@"id"];
    [param setValue:nameStr forKey:@"name"];
    [param setValue:mobileStr forKey:@"mobile"];
    [param setValue:self.linkModel.gender forKey:@"gender"];
    [param setValue:self.linkModel.job forKey:@"job"];
    [param setValue:self.linkModel.email forKey:@"email"];
    [param setValue:self.linkModel.province_id forKey:@"province_id"];
    [param setValue:self.linkModel.city_id forKey:@"city_id"];
    [param setValue:self.linkModel.area_id forKey:@"area_id"];
    [param setValue:self.linkModel.address forKey:@"address"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"保存成功" toView:self.view];
            
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
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(!IsStringEmpty(self.linkModel.id)) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==1) {
        return 1;
    }
    return [titleArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==1) {
        return 95;
    }
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGLinkmanAddViewControllerCell";
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
            //基本信息
            
            NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
            
            //创建“标题”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 25)];
            [lbMsg setText:itemArr[0]];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT16];
            [lbMsg sizeToFit];
            [lbMsg setCenterY:22.5];
            [cell.contentView addSubview:lbMsg];
            
            //创建“是否必填标志”
            if([itemArr[2] integerValue]==1) {
                UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(lbMsg.right, 10, 10, 25)];
                [lbMsg2 setText:@"*"];
                [lbMsg2 setTextColor:[UIColor redColor]];
                [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
                [lbMsg2 setFont:SYSTEM_FONT_SIZE(17.0)];
                [cell.contentView addSubview:lbMsg2];
            }
            
            //创建“内容”
            UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-130, 25)];
            [tbxContent setPlaceholder:itemArr[1]];
            [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
            [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
            [tbxContent setTextColor:COLOR3];
            [tbxContent setTextAlignment:NSTextAlignmentLeft];
            [tbxContent setFont:FONT15];
            [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
            [tbxContent setTag:indexPath.row+100];
            if([itemArr[3] integerValue]==1) {
                [tbxContent setEnabled:NO];
            }
            if(indexPath.row==1) {
                [tbxContent setKeyboardType:UIKeyboardTypePhonePad];
            }
            [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [cell.contentView addSubview:tbxContent];
            
            switch (indexPath.row) {
                case 0: {
                    //联系人姓名
                    [tbxContent setText:self.linkModel.name];
                    
                    break;
                }
                case 1: {
                    //电话
                    [tbxContent setText:self.linkModel.mobile];
                    
                    break;
                }
                case 2: {
                    //性别
                    [tbxContent setText:self.linkModel.gender_name];
                    
                    break;
                }
                case 3: {
                    //职位
                    [tbxContent setText:self.linkModel.job];
                    
                    break;
                }
                case 4: {
                    //邮箱
                    [tbxContent setText:self.linkModel.email];
                    
                    break;
                }
                case 5: {
                    //省市区
                    [tbxContent setText:self.linkModel.area_name];
                    
                    break;
                }
                case 6: {
                    //详细地址
                    [tbxContent setText:self.linkModel.address];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            //创建“右侧尖头”
            if ([itemArr[3] integerValue]==1) {
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
                [imgView setImage:[UIImage imageNamed:@"mine_arrow_right"]];
                [cell.contentView addSubview:imgView];
            }
            
            //创建“分割线”
            if(indexPath.row<[titleArr count]-1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(90, 44.5, SCREEN_WIDTH-90, 0.5)];
                [lineView setBackgroundColor:LINE_COLOR];
                [cell.contentView addSubview:lineView];
            }
            
            break;
        }
        case 1: {
            //编辑时有删除按钮
            cell.backgroundColor = [UIColor clearColor];
            
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, SCREEN_WIDTH-20, 45)];
            [btnFunc setTitle:@"删除此联系人" forState:UIControlStateNormal];
            [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT17];
            [btnFunc setBackgroundColor:MAIN_COLOR];
            [btnFunc.layer setCornerRadius:4.0];
            [btnFunc addTarget:self action:@selector(btnFuncDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnFunc];
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITextField *tbxContent = [cell.contentView viewWithTag:100+indexPath.row];
    
    switch (indexPath.row) {
        case 2: {
            //性别
            [self.view endEditing:YES];
            
            LTPickerView* pickerView = [LTPickerView new];
            pickerView.dataSource = @[@"男",@"女"];
            pickerView.defaultStr = @"男";
            [pickerView show];
            pickerView.block = ^(LTPickerView* obj,NSString* strSex,int num){
                NSLog(@"选择了第%d行的%@",num,strSex);
                [tbxContent setText:strSex];
                
                self.linkModel.gender = [NSString stringWithFormat:@"%zd",num+1];
                self.linkModel.gender_name = strSex;
            };
            
            break;
        }
        case 5: {
            //地址选择
            [self.view endEditing:YES];
            AddressPickView *addressPickView = [AddressPickView CreateInstance];
            [self.view addSubview:addressPickView];
            addressPickView.block = ^(NSString *cityIds,NSString *nameStr){
                NSLog(@"%@ %@",cityIds,nameStr);
                //省市区名称
                [tbxContent setText:nameStr];
                
                //值存储
                NSArray *itemArr = [cityIds componentsSeparatedByString:@","];
                self.linkModel.province_id = itemArr[0];
                self.linkModel.city_id = itemArr[1];
                self.linkModel.area_id = itemArr[2];
                self.linkModel.area_name = nameStr;
                
            };
            
            break;
        }
            
        default:
            break;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)textFieldDidChange:(UITextField *)textField {
    switch (textField.tag) {
        case 100: {
            //联系人
            self.linkModel.name = textField.text;
            
            break;
        }
        case 101: {
            //电话(可以是固定电话)
//            if (textField.text.length > 11) {
//                textField.text = [textField.text substringToIndex:11];
//            }
            self.linkModel.mobile = textField.text;
            
            break;
        }
        case 103: {
            //职位
            self.linkModel.job = textField.text;
            
            break;
        }
        case 104: {
            //邮箱
            self.linkModel.email = textField.text;
            
            break;
        }
        case 106: {
            //详细地址
            self.linkModel.address = textField.text;
            
            break;
        }
            
        default:
            break;
    }
}

/**
 *  删除联系人
 */
- (void)btnFuncDeleteClick:(UIButton *)btnSender {
    NSLog(@"删除联系人");
    [self.view endEditing:YES];
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"警告" message:@"您确定要删除吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"删除");
        
        [MBProgressHUD showMsg:@"删除中..." toView:self.view];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:@"customer" forKey:@"app"];
        [param setValue:@"dropLinkman" forKey:@"act"];
        [param setValue:self.linkModel.id forKey:@"id"];
        [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
            [MBProgressHUD hideHUD:self.view];
            NSString *msg = [json objectForKey:@"msg"];
            NSString *code = [json objectForKey:@"code"];
            if([code isEqualToString:SUCCESS]) {
                [MBProgressHUD showSuccess:@"删除成功" toView:self.view];
                
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
