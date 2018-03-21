//
//  CGLeaseMattersAddViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLeaseMattersAddViewController.h"
#import "CGSelectAddCustomerViewController.h"
#import "CGLeaseMattersModel.h"
#import "CGLinkmanSelectionViewController.h"
#import "CGIntentionSelectionViewController.h"
#import "CGUnitSelectionViewController.h"
#import "WSDatePickerView.h"
@interface CGLeaseMattersAddViewController ()
{
    NSMutableArray *titleArr;
}
@property (nonatomic, assign) BOOL isSign;
@property (nonatomic, strong) NSString *backCust_name;
@property (nonatomic, strong) NSString *backCust_id;
@property (nonatomic, strong) NSString *backlinkman_name;
@property (nonatomic, strong) NSString *backlinkman_id;
@property (nonatomic, strong) NSArray  *backlinkman_List;
@property (nonatomic, strong) NSDictionary *copywritingDic;
@property (nonatomic, strong) CGLeaseMattersModel *model;
@property (nonatomic, assign) BOOL isCustomerIDQuery;//根据客户id查询

@end

@implementation CGLeaseMattersAddViewController


/**
 * 懒加载
 */
- (NSDictionary *) copywritingDic {
    if (!_copywritingDic){
        
       _copywritingDic = @{@"0":@"因****原因，也无其他合适铺位调换，故终止合作。",
                                  @"15":@"经朋友介绍了解本案，已上门拜访，拿到xx总联系方式，明确其经营品业态为xx牌为xx.了解本案并有一定的意向，已邀约**时间现场考察",
                                  @"25":@"xx总已现场考察本案，对于本案认可，希望进一步了解本案详细规划，明确其品牌所在楼层其他品牌落位情况，及我方基本商务条件，约定**时间明确是否入驻，计划***时间回访",
                                  @"40":@"经确认，xx总明确入驻本案，并确认意向铺位为xx号，面积xx平及其公司可接受的基本租金xx元/平/天，希望可以无我方进一步确认商务条件，已约**时间项目现场洽谈。已拿到其开店工程条件表。",
                                  @"60":@"经过于xx总确认，铺位xx号，面积xx平，租金确认xx元/平/天，租期x年，递增～每年递增x%，工程条件需求xxxx。希望我方提供合同文本，待其公司确认即可推进签约，预计签约时间本月xxxx",
                                  @"100":@"公司财务已确认收到xxx公司履约保证金xxx元，合同我方已完成盖章交给xxx总签收"
                                  };
    }
    return _copywritingDic;
}

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
    // Do any additional setup after loading the view.
    
    self.title = @"添加招租事项";
    
    //设置数据源
    //备注：标题/描述/是否必填/是否可编辑/是否可点击/索引值
    titleArr = [NSMutableArray array];
    if (self.type ==2)
    {
        [titleArr addObject:@[@"客户名称",@"请输入客户名称",@"0",@"1",@"0",@"0"]];
    }
    else
    {
        [titleArr addObject:@[@"客户名称",@"请输入客户名称",@"0",@"1",@"1",@"0"]];
    }
    
    [titleArr addObject:@[@"联系人",@"请选择",@"1",@"1",@"1",@"1"]];
    [titleArr addObject:@[@"合作意向",@"请选择",@"1",@"1",@"1",@"2"]];
    if (!self.isChuBeiCust)
    {
         [titleArr addObject:@[@"意向铺位",@"请选择",@"0",@"1",@"1",@"3"]];
    }
    [titleArr addObject:@[@"时间",@"请选择",@"0",@"1",@"1",@"4"]];
    
    if (self.type !=3)
    {
        //查询默认信息
        [self getRelatedIntent];
        
        //查询最高意向度
        [self getCustTopIntent];
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
    
    [self saveAddZhaoZuShiXian];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return [titleArr count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==1) {
        return 10;
    }else if(section==2) {
        return 35;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            //基本信息
            return 45;
            
            break;
        case 1:
            //详情
            return 160;
            
            break;
        case 2: {
            
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
    if(section!=2) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    [backView setBackgroundColor:[UIColor clearColor]];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-20, 35)];
    [lbMsg setText:@"附件"];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [backView addSubview:lbMsg];
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGLeaseMattersAddViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    switch (indexPath.section)
    {
        case 0: {
            //基本信息
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
            [tbxContent setTag:[itemArr[5] integerValue]];
            if([itemArr[3] integerValue]==1) {
                [tbxContent setEnabled:NO];
            }
            [cell.contentView addSubview:tbxContent];
            
            if ([itemArr[4] isEqualToString:@"1"])
            {
                //创建“右侧尖头”
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
                [imgView setImage:[UIImage imageNamed:@"mine_arrow_right"]];
                [cell.contentView addSubview:imgView];
            }
            
            //创建“分割线”
            if(indexPath.row<[titleArr count]-1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 44.5, SCREEN_WIDTH-100, 0.5)];
                [lineView setBackgroundColor:LINE_COLOR];
                [cell.contentView addSubview:lineView];
            }
             NSInteger index = [titleArr[indexPath.row][5] integerValue];
            switch (index)
            {
                case 0:
                {
                    //客户名称
                    tbxContent.text = self.model.cust_name;
                }
                    break;
                case 1:
                {
                    //联系人
                    tbxContent.text = self.model.linkman_name;
                }
                    break;
                case 2:
                {
                    //合作意向
                    if (self.model)
                    {
                        if (IsStringEmpty(self.model.intent))
                        {
                            self.model.intent = @"0";
                        }
                         tbxContent.text =[NSString stringWithFormat:@"%@%%%@",self.model.intent,self.model.intent_name];
                    }
                   
                }
                    break;
                case 3:
                {
                    //意向铺位
                    if (IsStringEmpty(self.model.pos_name))
                    {
                        tbxContent.text = @"无";
                    }
                    else
                    {
                        tbxContent.text = self.model.pos_name;
                    }
                    
                }
                    break;
                case 4:
                {
                    NSString *date;
                    //时间
                    if (IsStringEmpty(self.model.time))
                    {
                        date = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm"];
                        self.model.time = date;
                    }
                    else
                    {
                        date = self.model.time;
                    }
                    tbxContent.text = date;
                }
                    break;
                    
                default:
                    break;
            }
            
            break;
        }
        case 1: {
            //详情
            self.textView = [[CGLimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
            self.textView.limitNum = 200;
            self.textView.textView.text = self.model.intro;
            if (IsStringEmpty(self.textView.textView.text))
            {
                 self.textView.placeHolder = self.copywritingDic[self.model.intent];
            }
            [cell.contentView addSubview:self.textView];
            
            break;
        }
        case 2: {
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
    
    self.model.intro = self.textView.textView.text;
    
    switch (indexPath.section) {
        case 0: {
            
            NSInteger index = [titleArr[indexPath.row][5] integerValue];
            
            switch (index)
            {
                case 0: {
                    //基本信息
                    NSArray *itemArr = [titleArr objectAtIndex:0];
                    if ([itemArr[4] isEqualToString:@"0"]) return;
                    //客户名称
                    CGSelectAddCustomerViewController * selectAddCustomerView = [[CGSelectAddCustomerViewController alloc]init];
                    selectAddCustomerView.type =1;
                    WS(weakSelf);
                    selectAddCustomerView.callBack = ^(CGSelectAddCustomerModel *model)
                    {
                        weakSelf.backCust_id        = model.cust_id;//客户id
                        weakSelf.backCust_name      = model.name;//客户名称;
                        weakSelf.backlinkman_name   = model.linkman_name;//联系人名字
                        weakSelf.backlinkman_id     = model.linkman_id;//联系人id
                        weakSelf.cust_id = model.cust_id;
                      
                        self.isCustomerIDQuery =YES;
                        //新增招租事项时，查询默认信息
                        [self getRelatedIntent];
                        
                        //查询最高意向度
                        [self getCustTopIntent];
                    };
                    [self.navigationController pushViewController:selectAddCustomerView animated:YES];
                    break;
                }
                case 1: {
                    //联系人
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
                    
                    break;
                }
                case 2:
                {
                    //合作意向
                    CGIntentionSelectionViewController *intentionSelectionView = [[CGIntentionSelectionViewController alloc]init];
                    intentionSelectionView.is_can_hundred = self.model.is_can_hundred;
                    intentionSelectionView.type = 1;
                    WS(weakSelf);
                    intentionSelectionView.callBack = ^(NSDictionary *dataDic)
                    {
                        weakSelf.model.intent = dataDic[@"num"];
                        weakSelf.model.intent_name = dataDic[@"title"];
                        if(IsStringEmpty(self.model.intro)) {
                            self.model.intro = @"";
                        }
                        //小于40自动清空
                        if ([weakSelf.model.intent intValue] <40)
                        {
                            weakSelf.model.pos_id = @"";
                            weakSelf.model.pos_name = @"";
                        }
                        //刷新
                        [weakSelf.tableView reloadData];
                        
                    };
                    [self.navigationController pushViewController:intentionSelectionView animated:YES];
                    
                    break;
                }
                case 3:
                {
                    if (!self.model.position.count)
                    {
                        [MBProgressHUD showError:@"没有可选的铺位" toView:self.view];
                        return;
                    }
                    //意向铺位
                    CGUnitSelectionViewController *unitSelectionView =[[CGUnitSelectionViewController alloc]init];
                    unitSelectionView.dataArr = [self.model.position mutableCopy];
                    WS(weakSelf);
                    unitSelectionView.callBack = ^(NSString *pos_id, NSString *pos_name,NSString *pos_area)
                    {
                        weakSelf.model.pos_id = pos_id;
                        weakSelf.model.pos_name = pos_name;
                        [weakSelf.tableView reloadData];
                    };
                    [self.navigationController pushViewController:unitSelectionView animated:YES];
                    
                    break;
                }
                case 4:
                {
                    //时间
                    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
                        
                        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
                        self.model.time =date;
                        [self.tableView reloadData];
                    }];
                    datepicker.dateLabelColor = MAIN_COLOR;//年-月-日-时-分 颜色
                    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
                    datepicker.doneButtonColor = MAIN_COLOR;//确定按钮的颜色
                    [datepicker show];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            break;
        }
            
        default:
            break;
    }
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

//新增招租事项时，查询默认信息
-(void)getRelatedIntent
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getRelatedIntent" forKey:@"act"];
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
        if ([code isEqualToString:SUCCESS])
        {
            NSDictionary *dataDic = json[@"data"];
            self.model = [CGLeaseMattersModel mj_objectWithKeyValues:dataDic];
            
            //如果客户id为空 就把从客户界面选择的客户信息赋值给model
            if (IsStringEmpty(self.model.cust_id))
            {
                self.model.cust_id   = self.backCust_id;
                self.model.cust_name = self.backCust_name;
                self.model.linkman_id = self.backlinkman_id;
                self.model.linkman_name = self.backlinkman_name;
            }
            if (IsStringEmpty(self.model.cust_id) &&self.type==2)
            {
                self.model.cust_id   = self.cust_id;
                self.model.cust_name = self.cust_name;
            }
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error)
    {
         [MBProgressHUD hideHUD:self.view];
    }];
}

//保存招租事项
-(void)saveAddZhaoZuShiXian
{
    if (self.isSign)
    {
        [MBProgressHUD showError:@"意向度已到100%，无需再添加招租事项" toView:self.view];
        return;
    }
    
    if (IsStringEmpty(self.model.cust_id))
    {
        [MBProgressHUD showError:@"请选择客户" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.linkman_id))
    {
        [MBProgressHUD showError:@"请选择联系人" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.intent))
    {
        [MBProgressHUD showError:@"请选择联意向度" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.pos_id))
    {
        if ([self.model.intent floatValue]>=40)
        {
            if (!self.isChuBeiCust)
            {
                [MBProgressHUD showError:@"请选择铺位" toView:self.view];
                return;
            }
        }
    }
    if (IsStringEmpty(self.model.time))
    {
        [MBProgressHUD showError:@"请选择时间" toView:self.view];
        return;
    }
    
    if (IsStringEmpty(self.textView.textView.text))
    {
        [MBProgressHUD showError:@"请输入详情" toView:self.view];
        return;
    }
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setValue:@"home" forKey:@"app"];
    [parm setValue:@"setIntent" forKey:@"act"];
    [parm setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [parm setValue:self.model.pos_id forKey:@"pos_id"];
    [parm setValue:self.model.cust_id forKey:@ "cust_id"];
    [parm setValue:self.model.linkman_id forKey:@"linkman_id"];
    [parm setValue:self.model.intent forKey:@"intent"];
    [parm setValue:self.model.time forKey:@"time"];
    [parm setValue:self.textView.textView.text forKey:@"intro"];
    [MBProgressHUD showMsg:@"添加中..." toView:self.view];
    [HttpRequestEx postWithImgPath:SERVICE_URL params:parm imgArr:self.dataArr success:^(id json)
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

//获取客户最高意向度
-(void)getCustTopIntent
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getCustTopIntent" forKey:@"act"];
    [param setValue:self.cust_id forKey:@"cust_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
     {
         NSString * code = json[@"code"];
         if ([code isEqualToString:SUCCESS])
         {
             if ([json[@"data"][@"intent"] floatValue] ==100)
             {
                 self.isSign = YES;
             }
             else
             {
                 self.isSign = NO;
             }
         }
         
     } failure:^(NSError *error) {
         
     }];
}

@end
