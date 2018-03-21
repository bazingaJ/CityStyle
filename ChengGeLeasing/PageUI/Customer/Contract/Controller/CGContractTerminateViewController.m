//
//  CGContractTerminateViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGContractTerminateViewController.h"
#import "CGContractTypeSheetView.h"

@interface CGContractTerminateViewController () {
    //终止类型
    NSString *destroyType;
    //终止类型名称
    NSString *destroyTypeName;
}

@end

@implementation CGContractTerminateViewController

/**
 *  imagePicker队列
 */
-(NSMutableArray *)imagePickerArray {
    if (!_imagePickerArray) {
        _imagePickerArray = [[NSMutableArray alloc]init];
    }
    return _imagePickerArray;
}

/**
 *  源文件数组
 */
- (NSMutableArray *)assetsArr {
    if(!_assetsArr) {
        _assetsArr = [NSMutableArray array];
    }
    return _assetsArr;
}

/**
 *  图片数组集合
 */
- (NSMutableArray *)photosArr {
    if(!_photosArr) {
        _photosArr = [NSMutableArray array];
    }
    return _photosArr;
}

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"终止详情";
    
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
            //类型
            return 45;
            
            break;
        case 1:
            //终止详情
            return 160;
            
            break;
        case 2: {
            //附件
            
            NSInteger imgNum = [self.imagePickerArray count];
            NSInteger rowNum = imgNum/3;
            NSInteger ysNum = imgNum%3;
            if(ysNum>=0 && [self.imagePickerArray count]<MaxImageCount) {
                rowNum += 1;
            }
            return (pictureHW+10)*rowNum + 10;
            
            break;
        }
            
            break;
            
        default:
            break;
    }
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section==0) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    [backView setBackgroundColor:[UIColor clearColor]];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-20, 35)];
    if(section==1) {
        [lbMsg setText:@"终止详情"];
    }else if(section==2) {
        [lbMsg setText:@"附件"];
    }
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGContractTerminateViewControllerCell";
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
            //终止类型
            
            //创建“标题”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
            [lbMsg setText:@"终止类型"];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT16];
            [cell.contentView addSubview:lbMsg];
            
            //创建“终止类型”
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-110, 25)];
            if(IsStringEmpty(destroyType)) {
                [btnFunc setTitle:@"请选择终止类型" forState:UIControlStateNormal];
                [btnFunc setTitleColor:COLOR9 forState:UIControlStateNormal];
            }else{
                [btnFunc setTitle:destroyTypeName forState:UIControlStateNormal];
                [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
            }
            [btnFunc.titleLabel setFont:FONT16];
            [btnFunc setImage:[UIImage imageNamed:@"mine_arrow_right"] forState:UIControlStateNormal];
            [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
            [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, btnFunc.frame.size.width-btnFunc.imageView.frame.size.width, 0, 0)];
            [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            [btnFunc addTarget:self action:@selector(btnFuncTypeSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnFunc];
            
            break;
        }
        case 1: {
            //终止详情
            
            self.textView = [[CGLimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
            self.textView.limitNum = 1000;
            self.textView.placeHolder = @"详情...";
            [cell.contentView addSubview:self.textView];
            
            break;
        }
        case 2: {
            //附件
            
            //清空二进制流存储器
            [self.dataArr removeAllObjects];
            
            //上传图片按钮
            NSInteger imageCount = [self.imagePickerArray count];
            for (NSInteger i = 0; i < imageCount; i++) {
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (i%3)*(pictureHW+10), 10 +(i/3)*(pictureHW+10), pictureHW, pictureHW)];
                [imgView setContentMode:UIViewContentModeScaleAspectFill];
                [imgView setClipsToBounds:YES];
                [imgView.layer setCornerRadius:4.0];
                [imgView.layer setMasksToBounds:YES];
                imgView.tag = 2000 + i;
                imgView.userInteractionEnabled = YES;
                imgView.image = self.imagePickerArray[i];
                UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
                [imgView addGestureRecognizer:tapGes];
                [cell.contentView addSubview:imgView];
                
                //UIImage转NSData
                NSData *imgData = UIImageJPEGRepresentation(imgView.image, 0.7);
                //NSData *imgData = UIImagePNGRepresentation(imgView.image);
                [self.dataArr addObject:imgData];
                
                //添加“删除”按钮
                UIButton *btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(pictureHW-15, 0, 15, 15)];
                [btnDelete setImage:[UIImage imageNamed:@"public_delete_photo"] forState:UIControlStateNormal];
                [btnDelete addTarget:self action:@selector(btnDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
                [imgView addSubview:btnDelete];
            }
            if (imageCount < MaxImageCount) {
                self.btnAdd = [[UIButton alloc]initWithFrame:CGRectMake(10+(imageCount%3)*(pictureHW+10), 10 +(imageCount/3)*(pictureHW+10), pictureHW, pictureHW)];
                [self.btnAdd setUserInteractionEnabled:YES];
                [self.btnAdd setBackgroundImage:[UIImage imageNamed:@"public_add_photo"] forState:UIControlStateNormal];
                [self.btnAdd addTarget:self action:@selector(btnAddClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:self.btnAdd];
            }
            
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

-(void)tapImageView:(UITapGestureRecognizer *)tap
{
    // 图片游览器
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 淡入淡出效果
    // pickerBrowser.status = UIViewAnimationAnimationStatusFade;
    // 数据源/delegate
    pickerBrowser.photos = self.photosArr;
    // 能够删除
    pickerBrowser.delegate = self;
    // 当前选中的值
    pickerBrowser.currentIndex = tap.view.tag-2000;
    // 展示控制器
    [pickerBrowser showPickerVc:self];
}

/**
 *  添加按钮功能
 */
- (void)btnAddClick:(UIButton *)btnSender {
    NSLog(@"添加图片");
    UIAlertController *alertController = [[UIAlertController alloc] init];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"拍照");
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"无法打开相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"从手机相册选择");
        ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
        // MaxCount, Default = 9
        pickerVc.maxCount = MaxImageCount;
        // Jump AssetsVc
        pickerVc.status = PickerViewShowStatusCameraRoll;
        // Filter: PickerPhotoStatusAllVideoAndPhotos, PickerPhotoStatusVideos, PickerPhotoStatusPhotos.
        pickerVc.photoStatus = PickerPhotoStatusPhotos;
        // Recoder Select Assets
        pickerVc.selectPickers = self.assetsArr;
        // Desc Show Photos, And Suppor Camera
        pickerVc.topShowPhotoPicker = YES;
        pickerVc.isShowCamera = NO;
        // CallBack
        pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
            self.assetsArr = status.mutableCopy;
            [self.imagePickerArray removeAllObjects];
            [self.photosArr removeAllObjects];
            for(int i=0;i<self.assetsArr.count;i++) {
                // 如果是本地ZLPhotoAssets就从本地取，否则从网络取
                NSURL *photoURL;
                if ([[self.assetsArr objectAtIndex:i] isKindOfClass:[ZLPhotoAssets class]]) {
                    photoURL = (NSURL *)[self.assetsArr[i] assetURL];
                    [self.imagePickerArray addObject:[self.assetsArr[i] originImage]];
                }else if ([[self.assetsArr objectAtIndex:i] isKindOfClass:[ZLCamera class]]){
                    photoURL = (NSURL *)[NSURL URLWithString:[self.assetsArr[i] imagePath]];
                    [self.imagePickerArray addObject:[self.assetsArr[i] originImage]];
                }else if ([[self.assetsArr objectAtIndex:i] isKindOfClass:[NSString class]]){
                    photoURL = (NSURL *)[self.assetsArr[i] assetURL];
                    UIImage *tmpImage = [[UIImage alloc] initWithData:[[NSData alloc] initWithContentsOfURL:photoURL]];
                    [self.imagePickerArray addObject:tmpImage];
                }
                
                //设置图片浏览数据源
                if(photoURL) {
                    ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
                    photo.photoURL = photoURL;
                    [self.photosArr addObject:photo];
                }
            }
            
            //刷新
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:2];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView endUpdates];
        };
        [pickerVc showPickerVc:self];
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
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    ZLPhotoAssets *asset = [ZLPhotoAssets assetWithImage:image];
    [self.assetsArr addObject:asset];
    [self.imagePickerArray addObject:image];
    
    //刷新
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:2];
    [self.tableView beginUpdates];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}


/**
 *  删除按钮功能
 */
- (void)btnDeleteClick:(UIButton *)btnSender {
    NSLog(@"删除图片");
    if ([(UIButton *)btnSender.superview isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)(UIButton *)btnSender.superview;
        [self.imagePickerArray removeObjectAtIndex:(imageView.tag - 2000)];
        [self.assetsArr removeObjectAtIndex:imageView.tag - 2000];
        [imageView removeFromSuperview];
    }
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:2];
    [self.tableView beginUpdates];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

/**
 *  选择终止类型
 */
- (void)btnFuncTypeSelectClick:(UIButton *)btnSender {
    NSLog(@"选择终止类型");
    
    CGContractTypeSheetView *sheetView = [[CGContractTypeSheetView alloc] init];
    sheetView.callBack = ^(NSString *type_id, NSString *type_name) {
        NSLog(@"类型ID:%@-类型名称:%@",type_id,type_name);
        
        //终止类型
        destroyType = type_id;
        destroyTypeName = type_name;
        
        [btnSender setTitle:type_name forState:UIControlStateNormal];
        [btnSender setTitleColor:COLOR3 forState:UIControlStateNormal];
        
    };
    [sheetView show];
    
}

/**
 *  确定按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"确定");
    [self.view endEditing:YES];
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    //终止类型验证
    if(IsStringEmpty(destroyType)) {
        [MBProgressHUD showError:@"请选择终止类型" toView:self.view];
        return;
    }
    
    //终止详情验证
    NSString *contentStr = self.textView.textView.text;
    if(IsStringEmpty(contentStr)) {
        [MBProgressHUD showError:@"请输入终止详情" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMsg:@"数据上传中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"destroyContract" forKey:@"act"];
    [param setValue:self.contract_id forKey:@"id"];
    [param setValue:destroyType forKey:@"destroy_type"];//终止类型 1协商 2单方终止
    [param setValue:contentStr forKey:@"destroy_note"];
    [param setValue:@"images" forKey:@"imgKey"];
    [HttpRequestEx postWithImgPath:SERVICE_URL params:param imgArr:self.dataArr success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"合同终止成功" toView:self.view];
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
