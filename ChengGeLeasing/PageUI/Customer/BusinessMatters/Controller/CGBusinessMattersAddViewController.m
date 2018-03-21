//
//  CGBusinessMattersAddViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGBusinessMattersAddViewController.h"
#import "CGBusinessMattersModel.h"
#import "CGSelectAddCustomerViewController.h"
#import "CGUnitSelectionViewController.h"
#import "CGLinkmanSelectionViewController.h"
#import "CGOperatingStateSelectionViewController.h"
@interface CGBusinessMattersAddViewController () {
    NSMutableArray *titleArr;
}
@property (nonatomic, strong) CGBusinessMattersModel *model;
@property (nonatomic, assign) BOOL isCustomerIDQuery;//根据客户id查询
@end

@implementation CGBusinessMattersAddViewController

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
    [self setHiddenHeaderRefresh:YES];
    [self setRightButtonItemTitle:@"保存"];
    [super viewDidLoad];
    
    self.title = @"添加经营事项";
    
    //设置数据源
    //备注：标题/描述/索引值
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"铺位号",@"请选择铺位",@"0"]];
    [titleArr addObject:@[@"联系人姓名",@"请选择联系人",@"1"]];
    [titleArr addObject:@[@"经营状态",@"请选择经营状态",@"2"]];
    
    //type为3时 铺位id和客户id都没有
    if (self.type !=3)
    {
        //获取默认数据
        [self getRelatedOperate];
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
    
    [self saveAddBusinessMatters];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==1) {
        return [titleArr count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==2 || section==3) {
        return 35;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            //当前经营租户
            return 70;
            
            break;
        case 1:
            //基本信息
            return 45;
            
            break;
        case 2:
            //详情
            return 160;
            
            break;
        case 3: {
            
            //上传图片
            NSInteger imgNum = [self.imagePickerArray count];
            NSInteger rowNum = imgNum/3;
            NSInteger ysNum = imgNum%3;
            if(ysNum>=0 && [self.imagePickerArray count]<MaxImageCount) {
                rowNum += 1;
            }
            return (pictureHW+10)*rowNum + 10;
            
            break;
        }
            
        default:
            break;
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
        [lbMsg setText:@"事项记录"];
    }else if(section==3) {
        [lbMsg setText:@"附件图片"];
    }
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [backView addSubview:lbMsg];
    
    return backView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGBusinessMattersAddViewControllerCell";
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
            //当前经营事项
            
            //创建“标题”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, SCREEN_WIDTH-70, 20)];
            [lbMsg setText:@"当前经营租户"];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT16];
            [cell.contentView addSubview:lbMsg];
            
            //创建“首字母”
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 10, 50, 50)];
            [imageView.layer setCornerRadius:4];
            [imageView.layer setMasksToBounds:YES];
            [imageView setBackgroundColor:MAIN_COLOR];
            if (!IsStringEmpty(self.model.cust_logo))
            {
                [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.cust_logo]];
                imageView.layer.borderColor = LINE_COLOR.CGColor;
                imageView.layer.borderWidth = .5;
            }
            else
            {
                imageView.image = [UIImage avatarWithName:self.model.first_letter];
            }

            [cell.contentView addSubview:imageView];
            
            if (self.type != 2)
            {
                //创建“右侧尖头”
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 30, 5.5, 10)];
                [imgView setImage:[UIImage imageNamed:@"mine_arrow_right"]];
                [cell.contentView addSubview:imgView];
            }
      
            
            //创建“分割线”
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(110, 69.5, SCREEN_WIDTH-110, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
            
            break;
        }
        case 1: {
            //基本信息
            
            NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
            
            //创建“标题”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 90, 25)];
            [lbMsg setText:itemArr[0]];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT16];
            [cell.contentView addSubview:lbMsg];
            
            //创建“内容”
            UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, SCREEN_WIDTH-150, 25)];
            [tbxContent setPlaceholder:itemArr[1]];
            [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
            [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
            [tbxContent setTextColor:COLOR3];
            [tbxContent setTextAlignment:NSTextAlignmentLeft];
            [tbxContent setFont:FONT16];
            [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
            [tbxContent setTag:[itemArr[2] integerValue]];
            [tbxContent setEnabled:NO];
            [cell.contentView addSubview:tbxContent];
            
            //创建“右侧尖头”
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
            [imgView setImage:[UIImage imageNamed:@"mine_arrow_right"]];
            [cell.contentView addSubview:imgView];
            
            //创建“分割线”
            if(indexPath.row<[titleArr count]-1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(110, 44.5, SCREEN_WIDTH-110, 0.5)];
                [lineView setBackgroundColor:LINE_COLOR];
                [cell.contentView addSubview:lineView];
            }
            
            switch (indexPath.row)
            {
                case 0:
                {
                    //铺位
                    tbxContent.text = self.model.pos_name;
                }
                    break;
                case 1:
                {
                    //联系人姓名
                    tbxContent.text = self.model.linkman_name;
                }
                    break;
                case 2:
                {
                    //经营状态
                    tbxContent.text = self.model.status_name;
                }
                    break;
                    
                default:
                    break;
            }
            
            break;
        }
        case 2: {
            //详情
            self.textView = [[CGLimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
            self.textView.limitNum = 200;
            self.textView.placeHolder = @"详情...";
            [cell.contentView addSubview:self.textView];
            
            break;
        }
        case 3: {
            //附件上传
            
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    
    switch (indexPath.section)
    {
        case 0:
        {
            if (self.type == 2) return;

            //选择客户
            CGSelectAddCustomerViewController *selectAddCustomerView = [[CGSelectAddCustomerViewController alloc]init];
            selectAddCustomerView.type = 3;
            WS(weakSelf);
            selectAddCustomerView.callBack = ^(CGSelectAddCustomerModel *model)
            {
                weakSelf.model.cust_id = model.cust_id;//客户id
                weakSelf.model.cust_name = model.name;//客户名称;
                weakSelf.model.first_letter = model.first_letter;//客户首字
                weakSelf.model.linkman_name = model.linkman_name;//联系人名字
                weakSelf.model.linkman_id = model.linkman_id;//联系人id
                weakSelf.cust_id = model.cust_id;
                self.isCustomerIDQuery =YES;
                //根据客户id回调默认数据
                [weakSelf getRelatedOperate];
            };
            [self.navigationController pushViewController:selectAddCustomerView animated:YES];
        }
            break;
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    if (self.type ==1)
                    {
                        [MBProgressHUD showError:@"铺位不允许修改" toView:self.view];
                        return;
                    }
                    //铺位号
                    CGUnitSelectionViewController *unitSelectionView =[[CGUnitSelectionViewController alloc]init];
                    [self.navigationController pushViewController:unitSelectionView animated:YES];
                }
                    break;
                case 1:
                {
                    //联系人姓名
                    if (IsStringEmpty(self.model.cust_id))
                    {
                        [MBProgressHUD showError:@"请选择客户" toView:self.view];
                        return;
                    }
                    CGLinkmanSelectionViewController *linkmanSelectionView =[[CGLinkmanSelectionViewController alloc]init];
                    linkmanSelectionView.cust_id = self.model.cust_id;
                    WS(weakSelf);
                    linkmanSelectionView.callBack = ^(CGLinkmanModel *model) {
                        weakSelf.model.linkman_id = model.id;
                        weakSelf.model.linkman_name = model.name;
                        [weakSelf.tableView reloadData];
                    };
                    [self.navigationController pushViewController:linkmanSelectionView animated:YES];
                    
                }
                    break;
                case 2:
                {
                    //经营状态
                    CGOperatingStateSelectionViewController *operatingStateSelectionView =[[CGOperatingStateSelectionViewController alloc]init];
                    WS(weakSelf);
                    operatingStateSelectionView.callBack = ^(NSDictionary *dataDic)
                    {
                        weakSelf.model.status = dataDic[@"state_id"];
                        weakSelf.model.status_name = dataDic[@"state"];
                        [weakSelf.tableView reloadData];
                    };
                    [self.navigationController pushViewController:operatingStateSelectionView animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
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
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:3];
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
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:3];
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
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:3];
    [self.tableView beginUpdates];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

//新增经营事项时，查询默认信息
- (void)getRelatedOperate
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getRelatedOperate" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    if (self.type ==1)
    {
        if (!self.isCustomerIDQuery)
        {
            //从铺位界面第一进来根据铺位id查询
            [param setValue:self.pos_id forKey:@"pos_id"];
        }
        else
        {
            //从铺位界面进来点击选择客户 取得客户id 通过客户id查询
            [param setValue:self.cust_id forKey:@"cust_id"];
        }
    }
    else
    {
        //从客户界面或者加号界面
        [param setValue:self.cust_id forKey:@"cust_id"];
    }
    [MBProgressHUD showMsg:@"加载中..." toView:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
    {
        [MBProgressHUD hideHUD:self.view];
        NSString *code = json[@"code"];
        NSDictionary *dataDic = json[@"data"];
        if ([code isEqualToString:SUCCESS])
        {
            self.model = [CGBusinessMattersModel mj_objectWithKeyValues:dataDic];
        }
        
        if (!IsStringEmpty(self.model.cust_name))
        {
            self.model.first_letter = [self.model.cust_name substringToIndex:1];//截取掉下标7之后的字符串
            self.model.cust_id = self.model.cust_id;
        }
        if (self.type ==2)
        {
            if (!IsStringEmpty(self.cust_name))
            {
                self.model.first_letter = [self.cust_name substringToIndex:1];//截取掉下标7之后的字符串
                self.model.cust_id = self.cust_id;
                self.model.cust_logo = self.cust_cover;
            }
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error)
    {
        
    }];
}

//添加经营事项
-(void)saveAddBusinessMatters
{
    if (IsStringEmpty(self.model.cust_id))
    {
        [MBProgressHUD showError:@"请选择客户" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.pos_id))
    {
        [MBProgressHUD showError:@"请选择铺位号" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.linkman_id))
    {
        [MBProgressHUD showError:@"请选择联系人" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.linkman_id))
    {
        [MBProgressHUD showError:@"请选择经营状态" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.textView.textView.text))
    {
        [MBProgressHUD showError:@"请输入事项记录" toView:self.view];
        return;
    }
    
    NSMutableDictionary *param =[NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"setOperate" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.model.pos_id forKey:@"pos_id"];
    [param setValue:self.model.cust_id forKey:@"cust_id"];
    [param setValue:self.model.linkman_id forKey:@"linkman_id"];
    [param setValue:self.model.status forKey:@"status"];
    [param setValue:self.textView.textView.text forKey:@"intro"];
    [HttpRequestEx postWithImgPath:SERVICE_URL params:param imgArr:self.dataArr success:^(id json)
     {
         [MBProgressHUD hideHUD:self.view];
         
         NSString *code = json[@"code"];
         NSString *msg = json[@"msg"];
         if ([code isEqualToString:SUCCESS])
         {
             [MBProgressHUD showSuccess:@"添加成功" toView:self.view];
             dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
             
             dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];
             });
         }
         else
         {
             [MBProgressHUD showError:msg toView:self.view];
         }
     } failure:^(NSError *error)
     {
         [MBProgressHUD hideHUD:self.view];
     }];

}

@end
