//
//  CGMineInfoViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineInfoViewController.h"
#import "LTPickerView.h"

@interface CGMineInfoViewController () {
    NSMutableArray *titleArr;
    
    //头像
    NSData *_avatarData;
    UIButton *btnTmp;
    
}

@end

@implementation CGMineInfoViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人资料";
    
    if(!self.userInfo) {
        self.userInfo = [CGUserModel new];
    }
    
    //设置数据源
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"账号",@"",@"0",@"0",@"1"]];
    [titleArr addObject:@[@"姓名",@"请输入您的姓名",@"1",@"1",@"0"]];
    [titleArr addObject:@[@"性别",@"请选择性别",@"1",@"1",@"1"]];
    [titleArr addObject:@[@"头像",@"",@"0",@"1",@"1"]];
    [titleArr addObject:@[@"邮箱",@"",@"0",@"1",@"0"]];//请输入您的邮箱//芦苇同学说不需要
    
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
    static NSString *cellIndentifier = @"CGMineInfoViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
    [lbMsg setText:itemArr[0]];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:SYSTEM_FONT_SIZE(16.0)];
    [lbMsg sizeToFit];
    [lbMsg setCenterY:22.5];
    [cell.contentView addSubview:lbMsg];
    
    //必填项标识
    if([itemArr[2] integerValue]==1) {
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(lbMsg.right, 10, 10, 25)];
        [lbMsg2 setText:@"*"];
        [lbMsg2 setTextColor:[UIColor redColor]];
        [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
        [lbMsg2 setFont:SYSTEM_FONT_SIZE(17.0)];
        [cell.contentView addSubview:lbMsg2];
    }
    
    //创建“内容”
    if(indexPath.row!=3) {
        UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, SCREEN_WIDTH-110, 25)];
        [tbxContent setPlaceholder:itemArr[1]];
        [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
        [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
        [tbxContent setTextColor:COLOR3];
        [tbxContent setTextAlignment:NSTextAlignmentRight];
        [tbxContent setFont:FONT16];
        [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
        [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [tbxContent setTag:100+indexPath.row];
        if([itemArr[4] integerValue]==1) {
            [tbxContent setEnabled:NO];
        }
        [cell.contentView addSubview:tbxContent];
        
        switch (indexPath.row) {
            case 0: {
                //账号
                [tbxContent setText:self.userInfo.mobile];
                
                break;
            }
            case 1: {
                //姓名
                [tbxContent setText:self.userInfo.nickname];
                
                break;
            }
            case 2: {
                //性别
                [tbxContent setText:self.userInfo.gender_name];
                
                break;
            }
            case 3: {
                //头像
                
                break;
            }
            case 4: {
                //邮箱
                [tbxContent setText:self.userInfo.email];
                
                break;
            }
                
            default:
                break;
        }
    }else{
        
        //创建“头像”
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-65, 5, 35, 35)];
        [btnFunc.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [btnFunc.imageView setClipsToBounds:YES];
        [btnFunc.layer setCornerRadius:17.5];
        [btnFunc.layer setMasksToBounds:YES];
        [btnFunc.layer setBorderWidth:2.0];
        [btnFunc.layer setBorderColor:MAIN_COLOR.CGColor];
        [btnFunc sd_setImageWithURL:[NSURL URLWithString:self.userInfo.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
        [btnFunc addTarget:self action:@selector(btnFuncUploadClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnFunc];
        
    }
    
    //创建“右侧尖头”
    if([itemArr[3] integerValue]==1) {
        UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
        [imgView2 setImage:[UIImage imageNamed:@"mine_arrow_right"]];
        [cell.contentView addSubview:imgView2];
    }
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [cell.contentView addSubview:lineView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITextField *tbxContent = [cell.contentView viewWithTag:100+indexPath.row];
    
    switch (indexPath.row) {
        case 2: {
            //选择性别
            [self.view endEditing:YES];
            
            LTPickerView* pickerView = [LTPickerView new];
            pickerView.dataSource = @[@"男",@"女",@"保密"];
            pickerView.defaultStr = @"男";
            [pickerView show];
            pickerView.block = ^(LTPickerView* obj,NSString* strSex,int num){
                NSLog(@"选择了第%d行的%@",num,strSex);
                [tbxContent setText:strSex];
                self.userInfo.gender = [NSString stringWithFormat:@"%zd",num+1];
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
            //账号
            
            break;
        }
        case 101: {
            //姓名
            self.userInfo.nickname = textField.text;
            
            break;
        }
        case 102: {
            //性别
            
            break;
        }
        case 103: {
            //头像
            
            break;
        }
        case 104: {
            //邮箱
            self.userInfo.email = textField.text;
            
            break;
        }
        
        default:
            break;
    }
}

/**
 *  上传照片
 */
- (void)btnFuncUploadClick:(UIButton *)btnSender {
    NSLog(@"上传照片");
    
    btnTmp = btnSender;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    UIAlertController *alertController = [[UIAlertController alloc] init];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"拍照");
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"无法打开相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"从手机相册选择");
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

//UIImagePickerControlDelegate委托事件
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获取相机返回的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //获取Image
    UIImage *photoImg = [info objectForKey:UIImagePickerControllerEditedImage];
    [btnTmp setImage:photoImg forState:UIControlStateNormal];
    
    _avatarData = UIImageJPEGRepresentation(photoImg,0.7);
    
}

/**
 *  确定按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"确定");
    [self.view endEditing:YES];

    //姓名验证
    NSString *nickName = self.userInfo.nickname;
    if(IsStringEmpty(nickName)) {
        [MBProgressHUD showError:@"请输入您的姓名" toView:self.view];
        return;
    }else if([NSString stringContainsEmoji:nickName]) {
        [MBProgressHUD showError:@"姓名不能包含表情" toView:self.view];
        return;
    }if([nickName length]>10) {
        [MBProgressHUD showError:@"姓名不能超过10个字符" toView:self.view];
        return;
    }
    
    //性别验证
    if(IsStringEmpty(self.userInfo.gender)) {
        [MBProgressHUD showError:@"请选择性别" toView:self.view];
        return;
    }

    NSMutableArray *imageArr = [NSMutableArray array];
    //头像
    if(_avatarData) {
        [imageArr addObject:@[@"avatar",_avatarData]];
    }

    [MBProgressHUD showMsg:@"数据上传中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"editBase" forKey:@"act"];
    [param setValue:nickName forKey:@"nickname"];
    [param setValue:self.userInfo.gender forKey:@"gender"];
    [param setValue:self.userInfo.email forKey:@"email"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [HttpRequestEx postWithImageURL:SERVICE_URL params:param imgArr:imageArr success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
            NSDictionary *dataDic = [json objectForKey:@"data"];
            self.userInfo = [CGUserModel mj_objectWithKeyValues:dataDic];

            //预先清除
            [[HelperManager CreateInstance] clearAcc];

            //设置本地缓存
            [self setUserDefaultInfo:dataDic];

            //清空参数值
            _avatarData = nil;

            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if(self.callBack) {
                    self.callBack(self.userInfo);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
