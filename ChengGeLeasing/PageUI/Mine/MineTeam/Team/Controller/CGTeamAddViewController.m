//
//  CGTeamAddViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGTeamAddViewController.h"
#import "CGTeamMemberModel.h"
#import "CGTeamMemberContactAddViewController.h"
#import "CGTeamMemberMobileAddViewController.h"
#import "CGTeamXiangmuModel.h"

@interface CGTeamAddViewController () {
    
    //项目名称
    NSString *xiangmuName;
    
    //二进制图片
    NSData *imgData;
    
    //单元格高度
    CGFloat cellH;
    
    //数据行数
    NSInteger rowNum;
    //总数
    NSInteger itemNum;
}

@property (nonatomic, strong) UIButton *btnFunc;
@property (nonatomic, strong) NSMutableArray *selectedArr;

@end

@implementation CGTeamAddViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"新建项目";
    
    //设置自己
    CGTeamMemberModel *model = [CGTeamMemberModel new];
    model.name = [HelperManager CreateInstance].nickname;
    model.avatar = [HelperManager CreateInstance].avatar;
    model.isCharge = @"1";
    model.ID = [HelperManager CreateInstance].user_id;
    [self.dataArr addObject:model];
    
    //设置模拟成员
    CGTeamMemberModel *model1 = [CGTeamMemberModel new];
    model1.name = @"";
    model1.avatar = @"mine_member_add";
    [self.dataArr addObject:model1];
    
    //设置默认值
    rowNum = 1;
    itemNum = [self.dataArr count];
    
    //创建“确定”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    [btnFunc setTitle:@"确定" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0) {
        return 0.0001;
    }
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 45;
            
            break;
        case 1: {
            
            itemNum = [self.dataArr count];
            rowNum = itemNum/5;
            NSInteger colNum = itemNum%5;
            if(colNum>0) {
                rowNum += 1;
            }
            cellH = rowNum*100;
            return cellH;
            
            break;
        }
        case 2:
            return 120;
            
            break;
            
        default:
            break;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 10;
            
            break;
        case 2:
            return 35;
            
            break;
            
        default:
            break;
    }
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section<=0) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    
    //创建“项目图片”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, backView.frame.size.width-20, 25)];
    if(section==1) {
        [lbMsg setText:@"团队成员"];
    }else if(section==2) {
        [lbMsg setText:@"项目图片"];
    }
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if(section!=2) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    
    //创建“项目图片”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, backView.frame.size.width-20, 25)];
    [lbMsg setText:@"注：尺寸建议750x380pt,图片不要超过300k,JPG或PNG格式"];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT12];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGTeamAddViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    switch (indexPath.section) {
        case 0: {
            //创建“项目名称”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 25)];
            [lbMsg setText:@"项目名称"];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT16];
            [cell.contentView addSubview:lbMsg];
            
            //创建“项目名称输入框”
            UITextField *tbxXiangmuName = [[UITextField alloc] initWithFrame:CGRectMake(90, 10, SCREEN_WIDTH-100, 25)];
            [tbxXiangmuName setPlaceholder:@"请填写项目名称"];
            [tbxXiangmuName setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
            [tbxXiangmuName setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
            [tbxXiangmuName setTextColor:COLOR3];
            [tbxXiangmuName setTextAlignment:NSTextAlignmentLeft];
            [tbxXiangmuName setFont:FONT16];
            [tbxXiangmuName setText:xiangmuName];
            [tbxXiangmuName setClearButtonMode:UITextFieldViewModeWhileEditing];
            [tbxXiangmuName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [cell.contentView addSubview: tbxXiangmuName];
            
            break;
        }
        case 1: {
            //团队成员
            CGFloat tWidth = (SCREEN_WIDTH-20)/5;
            for (int i=0; i<self.dataArr.count; i++)
            {
                 CGTeamMemberModel *model = [self.dataArr objectAtIndex:i];
                //创建“背景层”
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10+tWidth*(i%5), 10+i/5*100, tWidth-1, 99)];
                [btnFunc setTag:i];
                [btnFunc addTarget:self action:@selector(btnFuncTeamMemClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btnFunc];
                
                if (self.dataArr.count-1 ==i)
                {
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-50)/2, 10, 50, 50)];
                    [imgView.layer setCornerRadius:4.0];
                    [imgView.layer setMasksToBounds:YES];
                    [imgView setImage:[UIImage imageNamed:model.avatar]];
                    [btnFunc addSubview:imgView];
                    btnFunc.tag = 100000;
                }
                else
                {
                    //创建“头像”
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-50)/2, 10, 50, 50)];
                    [imgView setContentMode:UIViewContentModeScaleAspectFill];
                    [imgView setClipsToBounds:YES];
                    [imgView.layer setCornerRadius:4.0];
                    [imgView.layer setMasksToBounds:YES];
                    [imgView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"contact_icon_avatar"]];
                    [btnFunc addSubview:imgView];
                    
                    //创建“删除”按钮
                    UIButton *btnDel = [[UIButton alloc] initWithFrame:CGRectMake(imgView.centerX+18, imgView.centerY-32, 15, 15)];
                    [btnDel setImage:[UIImage imageNamed:@"mine_member_quchu"] forState:UIControlStateNormal];
                    [btnDel setTag:btnFunc.tag];
                    [btnDel addTouch:^{
                        NSLog(@"删除成员");
                        [self.view endEditing:YES];
                        
                        [self.dataArr removeObject:model];
                        
                        //刷新界面
                        [self.tableView beginUpdates];
                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                    }];
                    [btnFunc addSubview:btnDel];
                    
                    //是自己隐藏删除按钮
                    if ([model.isCharge isEqualToString:@"1"])
                    {
                        btnDel.hidden =YES;
                    }
                }
                //创建“名称”
                UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, tWidth, 20)];
                [lbMsg setText:model.name];
                [lbMsg setTextColor:COLOR3];
                [lbMsg setTextAlignment:NSTextAlignmentCenter];
                [lbMsg setFont:FONT15];
                [btnFunc addSubview:lbMsg];
                
            }
            

            
            break;
        }
        case 2: {
            //项目图片
            
            self.btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
            if(!imgData) {
                [self.btnFunc setImage:[UIImage imageNamed:@"mine_icon_upload"] forState:UIControlStateNormal];
            }else{
                UIImage *img = [UIImage imageWithData:imgData];
                [self.btnFunc setImage:img forState:UIControlStateNormal];
            }
            [self.btnFunc addTarget:self action:@selector(btnFuncUploadClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:self.btnFunc];
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)textFieldDidChange:(UITextField *)textField {
    xiangmuName = textField.text;
}

/**
 *  团队成员点击事件
 */
- (void)btnFuncTeamMemClick:(UIButton *)btnSender {
    NSLog(@"团队成员：%zd",btnSender.tag);
    [self.view endEditing:YES];
    
    if(btnSender.tag==100000) {
        
        //添加成员
        
        UIAlertController *alertController = [[UIAlertController alloc] init];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"从手机通讯录添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"从手机通讯录添加");
            
            //通讯录添加成员
            CGTeamMemberContactAddViewController *bookView = [[CGTeamMemberContactAddViewController alloc] init];
            bookView.isAdd = YES;
            bookView.selecteArr = self.dataArr;
            bookView.callBack = ^(NSMutableArray *memberArr) {
                NSLog(@"回调成功");
                for (CGTeamMemberModel *model in memberArr)
                {
                    
                    NSLog(@"%@---%@",model.name,model.avatar);
                    if ([model.avatar isEqualToString:@"mine_member_add"])
                    {
                        [memberArr removeObject:model];
                        
                        CGTeamMemberModel *model1 = [CGTeamMemberModel new];
                        model1.name = @"";
                        model1.avatar = @"mine_member_add";
                        [memberArr addObject:model1];
                        break;
                    }
                }
                //返回的团队成员
                self.dataArr = memberArr;
//                //返回的团队成员
//                self.dataArr = memberArr;
//
//                //设置自己
//                CGTeamMemberModel *model1 = [CGTeamMemberModel new];
//                model1.name = [HelperManager CreateInstance].nickname;
//                model1.avatar = [HelperManager CreateInstance].avatar;
//                model1.isCharge = @"1";
//                model1.id = [HelperManager CreateInstance].user_id;
//                [self.dataArr insertObject:model1 atIndex:0];
//
//                //设置模拟成员
//                CGTeamMemberModel *model = [CGTeamMemberModel new];
//                model.name = @"";
//                model.avatar = @"mine_member_add";
//                [self.dataArr addObject:model];
                
                //刷新单元格
                [self.tableView beginUpdates];
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView endUpdates];
                
            };
            [self.navigationController pushViewController:bookView animated:YES];
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"输入手机号添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"输入手机号添加");
            
            //手机号码添加
            CGTeamMemberMobileAddViewController *mobileView = [[CGTeamMemberMobileAddViewController alloc] init];
            mobileView.isAdd =YES;
            mobileView.selecteArr = self.dataArr;
            mobileView.callBack = ^(NSMutableArray *memberArr) {
                NSLog(@"回调成功");
                
                for (CGTeamMemberModel *model in memberArr)
                {
                    NSLog(@"%@---%@",model.name,model.avatar);
                    if ([model.avatar isEqualToString:@"mine_member_add"])
                    {
                        [memberArr removeObject:model];
                        
                        CGTeamMemberModel *model1 = [CGTeamMemberModel new];
                        model1.name = @"";
                        model1.avatar = @"mine_member_add";
                        [memberArr addObject:model1];
                        break;
                    }
                }
                //返回的团队成员
                self.dataArr = memberArr;
                
                //设置自己
//                CGTeamMemberModel *model1 = [CGTeamMemberModel new];
//                model1.name = [HelperManager CreateInstance].nickname;
//                model1.avatar = [HelperManager CreateInstance].avatar;
//                model1.isCharge = @"1";
//                model1.id = [HelperManager CreateInstance].user_id;
//                [self.dataArr insertObject:model1 atIndex:0];
//
//                //设置模拟成员
//                CGTeamMemberModel *model = [CGTeamMemberModel new];
//                model.name = @"";
//                model.avatar = @"mine_member_add";
//                [self.dataArr addObject:model];
                
                //刷新单元格
                [self.tableView beginUpdates];
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView endUpdates];
            };
            [self.navigationController pushViewController:mobileView animated:YES];
            
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
}


/**
 *  上传图片
 */
- (void)btnFuncUploadClick:(UIButton *)btnSender {
    NSLog(@"上传图片");
    [self.view endEditing:YES];
    
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

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获取相机返回的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //获取Image
    UIImage *photoImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.btnFunc setImage:photoImg forState:UIControlStateNormal];
    
    imgData = UIImagePNGRepresentation(photoImg);
    
}

/**
 *  确定按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"确定");
    [self.view endEditing:YES];
    
    //项目名称验证
    if(IsStringEmpty(xiangmuName)) {
        [MBProgressHUD showError:@"请填写项目名称" toView:self.view];
        return;
    }
    
    //项目成员验证
    if(self.dataArr.count<=1) {
        [MBProgressHUD showError:@"请选择团队成员" toView:self.view];
        return;
    }
    NSMutableArray *userIds = [NSMutableArray array];
    for (int i=0; i<[self.dataArr count]-1; i++) {
        CGTeamMemberModel *model = [self.dataArr objectAtIndex:i];
        if(!model || model.ID.length<=0) continue;
        
        [userIds addObject:model.ID];
        
    }
    if(userIds.count<=0) {
        [MBProgressHUD showError:@"请选择团队成员" toView:self.view];
        return;
    }
    NSString *memberIds = [userIds componentsJoinedByString:@","];
    
    //项目封面图验证
    if(!imgData) {
        [MBProgressHUD showError:@"请上传项目图片" toView:self.view];
        return;
    }
    
    NSMutableArray *imageArr = [NSMutableArray array];
    [imageArr addObject:@[@"cover",imgData]];
    
    [MBProgressHUD showMsg:@"数据上传中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"setNewProject" forKey:@"act"];
    [param setValue:xiangmuName forKey:@"name"];
    [param setValue:memberIds forKey:@"member"];
    [HttpRequestEx postWithImageURL:SERVICE_URL params:param imgArr:imageArr success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"新建成功" toView:self.view];
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                if(self.callBack) {
                    self.callBack();
                }
            });
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [MBProgressHUD hideHUD:self.view];
    }];
    
}

@end
