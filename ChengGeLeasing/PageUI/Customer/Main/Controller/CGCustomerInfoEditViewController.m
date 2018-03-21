//
//  CGCustomerInfoEditViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGCustomerInfoEditViewController.h"
#import "CGCustomerFormatView.h"

@interface CGCustomerInfoEditViewController () {
    NSMutableDictionary *titleDic;
    
    //物业
    NSMutableArray *imgArr;
    
    //头像二进制
    NSData *_avatarData;
    //临时按钮
    UIButton *btnTmp;
    
}

@end

@implementation CGCustomerInfoEditViewController

- (void)viewDidLoad {
    [self setRightButtonItemTitle:@"保存"];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"编辑客户";
    
    //设置数据源
    //备注：标题/描述/是否必填/单位/是否可编辑/索引
    titleDic = [NSMutableDictionary dictionary];
    
    //第一区块
    NSMutableArray *titleArr1 = [NSMutableArray array];
    [titleArr1 addObject:@[@"客户名称",@"请输入客户名称",@"1",@"",@"0",@"100"]];
    [titleArr1 addObject:@[@"所属团队",@"请选择所属团队",@"0",@"",@"1",@"101"]];
    [titleArr1 addObject:@[@"经营业态",@"请选择经营业态",@"1",@"",@"2",@"102"]];
    [titleArr1 addObject:@[@"官网",@"请输入官网",@"0",@"",@"0",@"103"]];
    [titleDic setValue:titleArr1 forKey:@"1"];
    
    //第二区块
    NSMutableArray *titleArr2 = [NSMutableArray array];
    [titleArr2 addObject:@[@"面积需求",@"请输入面积",@"0",@"m²",@"0",@"200"]];
    [titleArr2 addObject:@[@"合作年限",@"请输入合作年限",@"0",@"年",@"0",@"201"]];
    [titleDic setValue:titleArr2 forKey:@"2"];
    
    //物业条件
    imgArr = [NSMutableArray array];
    [imgArr addObject:@[@"bunk_huo_normal",@"bunk_huo_selected",@"可明火",@"1"]];
    [imgArr addObject:@[@"bunk_tianranqi_normal",@"bunk_tianranqi_selected",@"天然气管道",@"2"]];
    [imgArr addObject:@[@"bunk_meiqi_normal",@"bunk_meiqi_selected",@"煤气罐",@"3"]];
    [imgArr addObject:@[@"bunk_dianya_normal",@"bunk_dianya_selected",@"380伏",@"4"]];
    [imgArr addObject:@[@"bunk_shangshui_normal",@"bunk_shangshui_selected",@"上水",@"5"]];
    [imgArr addObject:@[@"bunk_xiashui_normal",@"bunk_xiashui_selected",@"下水",@"6"]];
    [imgArr addObject:@[@"bunk_yanguan_normal",@"bunk_yanguan_selected",@"烟管道",@"7"]];
    [imgArr addObject:@[@"bunk_guandao_normal",@"bunk_guandao_selected",@"排污管道",@"8"]];
    [imgArr addObject:@[@"bunk_park_normal",@"bunk_park_selected",@"停车位",@"9"]];
    [imgArr addObject:@[@"bunk_waibai_normal",@"bunk_waibai_selected",@"外摆区",@"10"]];
    
}

/**
 *  保存
 */
- (void)rightButtonItemClick {
    NSLog(@"保存");
    [self.view endEditing:YES];
    
    //客户ID验证
    if(IsStringEmpty(self.customerModel.cust_id)) {
        [MBProgressHUD showError:@"客户ID不能为空" toView:self.view];
        return;
    }
    
    //客户名称验证
    NSString *nameStr = self.customerModel.name;
    if(IsStringEmpty(nameStr)) {
        [MBProgressHUD showError:@"请输入客户名称" toView:self.view];
        return;
    }else if([NSString stringContainsEmoji:nameStr]) {
        [MBProgressHUD showError:@"客户名称不能包含表情" toView:self.view];
        return;
    }if([nameStr length]>30) {
        [MBProgressHUD showError:@"客户名称不能超过30个字符" toView:self.view];
        return;
    }
    
    //业态验证
    if(IsStringEmpty(self.customerModel.cate_id)) {
        [MBProgressHUD showError:@"请选择业态" toView:self.view];
        return;
    }
    
    //客户头像
    NSMutableArray *imgArr = [NSMutableArray array];
    if(_avatarData) {
        [imgArr addObject:@[@"logo",_avatarData]];
    }
    
    [MBProgressHUD showMsg:@"保存中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"editCustInfo" forKey:@"act"];
    [param setValue:self.customerModel.cust_id forKey:@"cust_id"];
    [param setValue:nameStr forKey:@"name"];
    [param setValue:self.customerModel.cate_id forKey:@"cate_id"];
    [param setValue:self.customerModel.website forKey:@"website"];
    [param setValue:self.customerModel.need_area forKey:@"need_area"];
    [param setValue:self.customerModel.years forKey:@"years"];
    [param setValue:self.customerModel.property forKey:@"property"];
    [HttpRequestEx postWithImageURL:SERVICE_URL params:param imgArr:imgArr success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"保存成功" toView:self.view];
            
            NSDictionary *dataDic = [json objectForKey:@"data"];
            CGCustomerModel *customerInfo = [CGCustomerModel mj_objectWithKeyValues:dataDic];
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if(self.callBack) {
                    self.callBack(customerInfo);
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0 || section==3) {
        return 1;
    }else{
        NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",section]];
        return [titleArr count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section>=2) {
        return 35;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0) {
        return 70;
    }else if(indexPath.section==3) {
        return 200;
    }
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section<2) return [UIView new];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    [backView setBackgroundColor:[UIColor clearColor]];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-20, 35)];
    if(section==2) {
        [lbMsg setText:@"拓展计划"];
    }else if(section==3) {
        [lbMsg setText:@"物业条件"];
    }
    [lbMsg setTextColor:COLOR9];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGCustomerInfoEditViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if(indexPath.section==0) {
        //头像
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 120, 20)];
        [lbMsg setText:@"LOGO/头像"];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [cell.contentView addSubview:lbMsg];
        
        //创建“头像”
        NSString *imgURL = self.customerModel.logo;
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 10, 50, 50)];
        [btnFunc.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [btnFunc.imageView setClipsToBounds:YES];
        [btnFunc.layer setCornerRadius:4.0];
        [btnFunc.layer setMasksToBounds:YES];
        [btnFunc.layer setBorderWidth:0.5];
        [btnFunc.layer setBorderColor:MAIN_COLOR.CGColor];
        [btnFunc sd_setImageWithURL:[NSURL URLWithString:imgURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
        [btnFunc addTarget:self action:@selector(btnFuncUploadClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnFunc];
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 69.5, SCREEN_WIDTH, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [cell.contentView addSubview:lineView];
        
        //创建“右侧尖头”
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 30, 5.5, 10)];
        [imgView setImage:[UIImage imageNamed:@"mine_arrow_right"]];
        [cell.contentView addSubview:imgView];
        
    }else if(indexPath.section==3) {
        //物业条件
        
        NSInteger itemNum = [imgArr count];
        CGFloat tWidth = (SCREEN_WIDTH-20)/5;
        for (int i=0; i<2; i++) {
            for (int k=0; k<5; k++) {
                NSInteger tIndex = 5*i+k;
                if(tIndex>itemNum-1) continue;
                
                NSArray *itemArr = [imgArr objectAtIndex:tIndex];
                
                BOOL isContain = [self.customerModel.propertyArr containsObject:itemArr[3]];
                
                //创建“背景层”
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10+tWidth*k, 100*i, tWidth-1, 99)];
                [btnFunc setTag:tIndex];
                [btnFunc setSelected:isContain];
                [btnFunc addTarget:self action:@selector(btnFuncItemClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btnFunc];
                
                UIImage *img = nil;
                if(isContain) {
                    img = [UIImage imageNamed:itemArr[1]];
                }else{
                    img = [UIImage imageNamed:itemArr[0]];
                }
                CGFloat tW = img.size.width;
                CGFloat tH = img.size.height;
                
                //创建“图标”
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-tW)/2, 20, tW, tH)];
                [imgView setImage:img];
                [btnFunc addSubview:imgView];
                
                //创建“标题”
                UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, tWidth, 20)];
                [lbMsg setText:itemArr[2]];
                if(isContain) {
                    [lbMsg setTextColor:RED_COLOR];
                }else{
                    [lbMsg setTextColor:COLOR9];
                }
                [lbMsg setTextAlignment:NSTextAlignmentCenter];
                [lbMsg setFont:FONT13];
                [btnFunc addSubview:lbMsg];
                
            }
        }
        
    }else{
        //基本信息
        
        NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",indexPath.section]];
        NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
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
        UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH-140, 25)];
        [tbxContent setPlaceholder:itemArr[1]];
        [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
        [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
        [tbxContent setTextColor:COLOR3];
        [tbxContent setTextAlignment:NSTextAlignmentLeft];
        [tbxContent setFont:FONT16];
        [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
        [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [tbxContent setTag:[itemArr[5] integerValue]];
        if([itemArr[4] integerValue]>=1) {
            [tbxContent setEnabled:NO];
        }
        if(tbxContent.tag==200) {
            //面积需求
            [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
        }else if(tbxContent.tag==201) {
            //合作年限
            [tbxContent setKeyboardType:UIKeyboardTypeNumberPad];
        }
        [cell.contentView addSubview:tbxContent];
        
        switch ([itemArr[5] integerValue]) {
            case 100: {
                //客户名称
                [tbxContent setText:self.customerModel.name];
                
                break;
            }
            case 101: {
                //所属团队
                [tbxContent setText:self.customerModel.pro_name];
                
                break;
            }
            case 102: {
                //经营业态
                [tbxContent setText:self.customerModel.cate_name];
                
                break;
            }
            case 103: {
                //官网
                [tbxContent setText:self.customerModel.website];
                
                break;
            }
            case 200: {
                //面积需求
                [tbxContent setText:self.customerModel.need_area];
                
                break;
            }
            case 201: {
                //合作年限
                [tbxContent setText:self.customerModel.years];
                
                break;
            }
                
            default:
                break;
        }
        
        if([itemArr[4] integerValue]==1) {
            
            //创建“右侧尖头”
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
            [imgView setImage:[UIImage imageNamed:@"mine_arrow_right"]];
            [cell.contentView addSubview:imgView];
            
        }else if([itemArr[4] integerValue]==2){
            //选择经营业态
            
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-35, 10, 25, 25)];
            [btnFunc setImage:[UIImage imageNamed:@"format_icon_select"] forState:UIControlStateNormal];
            [cell.contentView addSubview:btnFunc];
            
        }else{
            
            //创建“单位”
            UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 10, 20, 25)];
            [lbMsg3 setText:itemArr[3]];
            [lbMsg3 setTextColor:COLOR3];
            [lbMsg3 setTextAlignment:NSTextAlignmentRight];
            [lbMsg3 setFont:FONT14];
            [cell.contentView addSubview:lbMsg3];
            
        }
        
        //创建“分割线”
        if(indexPath.row<[titleArr count]-1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 44.5, SCREEN_WIDTH-100, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITextField *tbxContent = [cell.contentView viewWithTag:102];
    
    if(indexPath.section==1 && indexPath.row==2) {
        //选择业态
        
        CGCustomerFormatView *formatView = [[CGCustomerFormatView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270) titleStr:@"经营业态"];
        [formatView getFormatList:self.customerModel.pro_id];
        formatView.callBack = ^(NSString *cateId, NSString *cateName) {
            NSLog(@"业态ID：%@-业态名称：%@",cateId,cateName);
            [tbxContent setText:cateName];
            
            self.customerModel.cate_id = cateId;
            self.customerModel.cate_name = cateName;
            
        };
        [formatView show];
        
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)textFieldDidChange:(UITextField *)textField {
    switch (textField.tag) {
        case 100: {
            //客户名称
            self.customerModel.name = textField.text;
            
            break;
        }
        case 103: {
            //官网
            self.customerModel.website = textField.text;
            
            break;
        }
        case 200: {
            //面积需求
            self.customerModel.need_area = textField.text;
            
            break;
        }
        case 201: {
            //合作年限
            self.customerModel.years = textField.text;
            
            break;
        }
            
        default:
            break;
    }

}

/**
 *  上传头像
 */
- (void)btnFuncUploadClick:(UIButton *)btnSender {
    NSLog(@"上传头像");
    
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
    UIImage *photoImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    [btnTmp setImage:photoImg forState:UIControlStateNormal];
    
    _avatarData = UIImageJPEGRepresentation(photoImg,0.7);
    
}

/**
 *  物业选择事件
 */
- (void)btnFuncItemClick:(UIButton *)btnSender {
    NSLog(@"物业选择");
    
    btnSender.selected = !btnSender.selected;
    
    //获取当前数据源
    NSArray *propertyArr = [imgArr objectAtIndex:btnSender.tag];
    
    
    for (UIView *view in btnSender.subviews) {
        if([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imgView = (UIImageView *)view;
            if(btnSender.isSelected) {
                //选中
                [imgView setImage:[UIImage imageNamed:propertyArr[1]]];
                [self.customerModel.propertyArr addObject:propertyArr[3]];
            }else{
                //未选中
                [imgView setImage:[UIImage imageNamed:propertyArr[0]]];
                [self.customerModel.propertyArr removeObject:propertyArr[3]];
            }
        }
        if([view isKindOfClass:[UILabel class]]) {
            UILabel *lbMsg = (UILabel *)view;
            if(btnSender.isSelected) {
                [lbMsg setTextColor:RED_COLOR];
            }else{
                [lbMsg setTextColor:COLOR9];
            }
        }
    }
    
    //物业集合
    NSString *propertyStr = [self.customerModel.propertyArr componentsJoinedByString:@","];
    NSLog(@"已选中物业条件:%@",propertyStr);
    
    //赋值
    self.customerModel.property = propertyStr;
    
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
