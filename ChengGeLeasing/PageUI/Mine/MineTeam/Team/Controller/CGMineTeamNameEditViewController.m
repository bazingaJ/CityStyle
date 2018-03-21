//
//  CGMineTeamNameEditViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamNameEditViewController.h"
#import "CGCropImageExViewController.h"

@interface CGMineTeamNameEditViewController ()<CGCropImageDelegate> {
    
    //二进制图片
    NSData *imgData;
}

@property (nonatomic, strong) UIButton *btnFunc;

@end

@implementation CGMineTeamNameEditViewController

- (void)viewDidLoad {
    [self setRightButtonItemTitle:@"保存"];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改团队名称";
    
}

/**
 *  修改团队名称及封面
 */
- (void)rightButtonItemClick {
    [self.view endEditing:YES];
    
    //团队名称验证
    NSString *teamName = self.xiangmuModel.name;
    if(IsStringEmpty(teamName)) {
        [MBProgressHUD showError:@"请输入团队名称" toView:self.view];
        return;
    }else if([NSString stringContainsEmoji:teamName]) {
        [MBProgressHUD showError:@"团队名称不能包含表情" toView:self.view];
        return;
    }if([teamName length]>30) {
        [MBProgressHUD showError:@"团队名称不能超过30个字符" toView:self.view];
        return;
    }
    
    //项目图片验证
    if(IsStringEmpty(self.xiangmuModel.cover_url) && !imgData) {
        [MBProgressHUD showError:@"请上传项目封面" toView:self.view];
        return;
    }
    NSMutableArray *imgArr = [NSMutableArray array];
    if(imgData) {
        [imgArr addObject:@[@"cover",imgData]];
    }
    
    [MBProgressHUD showMsg:@"数据上传中..." toView:self.view];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"editProInfo" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [param setValue:teamName forKey:@"name"];
    [HttpRequestEx postWithImageURL:SERVICE_URL params:param imgArr:imgArr success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
            
            NSDictionary *dataDic = [json objectForKey:@"data"];
            CGTeamXiangmuModel *model = [CGTeamXiangmuModel mj_objectWithKeyValues:dataDic];
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                if(self.callBack) {
                    self.callBack(model);
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==1) {
        return 35;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==1) {
        return 120;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section==1) {
        return 35;
    }
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section<=0) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    
    //创建“项目图片”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, backView.frame.size.width-20, 25)];
    [lbMsg setText:@"项目图片"];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if(section<=0) return [UIView new];
    
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
    static NSString *cellIndentifier = @"CGMineTeamNameEditViewControllerCell";
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
            //创建“团队名称输入框”
            UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 25)];
            [tbxContent setPlaceholder:@"请输入团队名称"];
            [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
            [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
            [tbxContent setTextColor:COLOR3];
            [tbxContent setTextAlignment:NSTextAlignmentLeft];
            [tbxContent setFont:FONT16];
            [tbxContent setText:self.xiangmuModel.name];
            [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
            [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [cell.contentView addSubview:tbxContent];
            
            break;
        }
        case 1: {
            //创建上传图片按钮
            
            self.btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
            [self.btnFunc.imageView setContentMode:UIViewContentModeScaleAspectFill];
            [self.btnFunc.imageView setClipsToBounds:YES];
            if(!IsStringEmpty(self.xiangmuModel.cover_url)) {
                [self.btnFunc sd_setImageWithURL:[NSURL URLWithString:self.xiangmuModel.cover_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
            }else{
                if(!imgData) {
                    [self.btnFunc setImage:[UIImage imageNamed:@"mine_icon_upload"] forState:UIControlStateNormal];
                }else{
                    UIImage *img = [UIImage imageWithData:imgData];
                    [self.btnFunc setImage:img forState:UIControlStateNormal];
                }
            }
            [self.btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
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
    self.xiangmuModel.name = textField.text;
}

/**
 *  上传图片
 */
- (void)btnFuncClick:(UIButton *)btnSender {
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
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

////获取相机返回的图片
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    [self dismissViewControllerAnimated:YES completion:nil];
//
//    //获取Image
//    UIImage *photoImg = [info objectForKey:UIImagePickerControllerEditedImage];
//    [self.btnFunc setImage:photoImg forState:UIControlStateNormal];
//    imgData = UIImageJPEGRepresentation(photoImg,0.7);
//
//}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //关闭页面
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //获取Image
    UIImage *photoImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGCropImageExViewController *clipVC = [[CGCropImageExViewController alloc] initWithImage:photoImg clipSize:CGSizeMake(300, 150)];
    clipVC.clipType = SQUARECLIP;
    clipVC.delegate = self;
    UINavigationController *naviVC = [[UINavigationController alloc]initWithRootViewController:clipVC];
    [self.navigationController presentViewController:naviVC animated:YES completion:nil];
}

- (void)clipViewController:(CGCropImageExViewController *)viewC finishClipImage:(UIImage *)editImage {
    [self.btnFunc setImage:editImage forState:UIControlStateNormal];
    imgData = UIImageJPEGRepresentation(editImage,0.7);
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
