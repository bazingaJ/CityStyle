//
//  CGContractAddViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGContractAddViewController.h"
#import "CGSelectAddCustomerViewController.h"
#import "CGContractModel.h"
#import "CGMannerSheetView.h"
#import "CGQuotationSheetView.h"
#import "CGUnitSelectionViewController.h"
#import "WSDatePickerView.h"
@interface CGContractAddViewController () {
    NSMutableDictionary *titleDic;
}

@property (nonatomic, strong) CGContractModel *model;

@property (nonatomic, strong) NSString *backCust_name;
@property (nonatomic, strong) NSString *backCust_id;
@end

@implementation CGContractAddViewController

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
    [self setRightButtonItemTitle:@"保存"];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"新签合同";
    
    //设置数据源
    //备注：标题/描述/是否必填/单位/有无箭头/能否点击/索引
    titleDic = [NSMutableDictionary dictionary];

    //第一区
    NSMutableArray *titleArr1 = [NSMutableArray array];
    if (self.type ==1)
    {
        [titleArr1 addObject:@[@"客户名称",@"请选择客户",@"0",@"",@"0",@"1",@"100"]];
    }
    else
    {
        [titleArr1 addObject:@[@"客户名称",@"请选择客户",@"0",@"",@"1",@"1",@"100"]];
    }
    
    [titleArr1 addObject:@[@"签约铺位",@"请选择签约铺位",@"1",@"",@"1",@"1",@"101"]];
    [titleArr1 addObject:@[@"签约面积",@"请输入签约面积",@"0",@"m²",@"1",@"1",@"102"]];
    [titleDic setValue:titleArr1 forKey:@"0"];
    
    //第二区
    NSMutableArray *titleArr2 = [NSMutableArray array];
    [titleArr2 addObject:@[@"合同开始时间",@"请选择",@"0",@"",@"1",@"1",@"200"]];
    [titleArr2 addObject:@[@"合同结束时间",@"请选择",@"0",@"",@"1",@"1",@"201"]];
    [titleArr2 addObject:@[@"合作方式",@"请选择",@"0",@"",@"1",@"1",@"202"]];
    [titleArr2 addObject:@[@"纯扣点",@"请输入扣点",@"0",@"%",@"0",@"0",@"203"]];
    [titleArr2 addObject:@[@"物业管理费",@"请输入物业管理费",@"0",@"元/平方米/月",@"2",@"0",@"2000"]];
    [titleDic setValue:titleArr2 forKey:@"1"];
    
    //客户界面过来查询信息
    if (self.type ==1)
    {
        [self getRelatedSign];
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
    
    [self setSign];
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section<=1) {
        NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",section]];
        return [titleArr count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0) {
        return 0.0001;
    }else if(section==1) {
        return 10;
    }
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 2:
            //递增方式
            return 160;
            
            break;
        case 3:
            //备注信息
            return 160;
            
            break;
        case 4: {
            //附件
            
            NSInteger imgNum = [self.imagePickerArray count];
            NSInteger rowNum = imgNum/3;
            NSInteger ysNum = imgNum%3;
            if(ysNum>=0 && [self.imagePickerArray count]<99) {
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
    if(section<=1) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    [backView setBackgroundColor:[UIColor clearColor]];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 35)];
    if(section==2) {
        [lbMsg setText:@"递增方式"];
    }else if(section==3) {
        [lbMsg setText:@"备注信息"];
    }else if(section==4) {
        [lbMsg setText:@"附件"];
    }
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    return backView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGContractAddViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if(indexPath.section<=1) {
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
        UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(130, 10, SCREEN_WIDTH-160, 25)];
        [tbxContent setPlaceholder:itemArr[1]];
        [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
        [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
        [tbxContent setTextColor:COLOR3];
        [tbxContent setTextAlignment:NSTextAlignmentLeft];
        [tbxContent setFont:FONT15];
        [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
        [tbxContent setTag:[itemArr[6] integerValue]];
        if([itemArr[5] integerValue]==1) {
            [tbxContent setEnabled:NO];
        }
        [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:tbxContent];
        
        if([itemArr[4] integerValue]==1)
        {
            //创建“右侧尖头”
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
            [imgView setImage:[UIImage imageNamed:@"mine_arrow_right"]];
            [cell.contentView addSubview:imgView];
            
        }else if([itemArr[4] integerValue]==2){
            //创建“单位选择”
            
            //创建“终止类型”
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120, 10, 110, 25)];
            NSString *title;
            
            if ([itemArr[6] isEqualToString:@"2000"])
            {
              
                if (IsStringEmpty(self.model.expenses_unit_name))
                {
                    title = @"元/平方米/月";
                    self.model.expenses_unit =@"4";
                }
                else
                {
                    title =self.model.expenses_unit_name;
                }
            }
            else
            {
                if (IsStringEmpty(self.model.rental_unit_name))
                {
                    title = @"元/平方米/天";
                    self.model.rental_unit =@"3";
                }
                else
                {
                    title =self.model.rental_unit_name;
                }
            }
         
            [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT12];
            [btnFunc setTitle:title forState:UIControlStateNormal];
            [btnFunc setImage:[UIImage imageNamed:@"down_icon_select"] forState:UIControlStateNormal];
            [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
            [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, btnFunc.frame.size.width-btnFunc.imageView.frame.size.width, 0, 0)];
            [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            [btnFunc addTouch:^{
                NSLog(@"单位选择");
                [self.view endEditing:YES];
                
                CGQuotationSheetView *sheetView = [[CGQuotationSheetView alloc] init];
                sheetView.callBack = ^(NSString *unit_id, NSString *unit_name) {
                    NSLog(@"单位ID:%@-单位名称:%@",unit_id,unit_name);
                    
                    if ([itemArr[6] isEqualToString:@"2000"])
                    {
                        self.model.expenses_unit_name =unit_name;
                        self.model.expenses_unit =unit_id;
                    }
                    else
                    {
                        self.model.rental_unit =unit_id;
                        self.model.rental_unit_name =unit_name;
                    }
                    
                    [btnFunc setTitle:unit_name forState:UIControlStateNormal];
                };
                [sheetView show];
                
            }];
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
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(120, 44.5, SCREEN_WIDTH-120, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
        }
        
        if (indexPath.section ==0)
        {
            if (indexPath.row ==0)
            {
                //客户名字
                tbxContent.text = self.model.cust_name;
            }
            if (indexPath.row ==1)
            {
                //签约铺位
                tbxContent.text = self.model.pos_name;
            }
            if (indexPath.row ==2)
            {
                //签约面积
                tbxContent.text = self.model.area;
            }
        }
        else if (indexPath.section ==1)
        {
            NSMutableArray *titleArr =[titleDic objectForKey:@"1"];
            NSArray *itemArr = titleArr[indexPath.row];
            NSInteger index = [itemArr[6] integerValue];
            switch (index)
            {
                case 200:
                {
                    //合同开始时间
                    tbxContent.text = self.model.start_time;
                }
                    break;
                case 201:
                {
                    //合同结束时间
                    tbxContent.text = self.model.end_time;
                }
                    break;
                case 202:
                {
                    //合作方式
                    tbxContent.text = self.model.manner_name;
                }
                    break;
                case 203:
                {
                    //纯扣点
                    tbxContent.text = self.model.deduct;
//                    if ([self.model.manner isEqualToString:@"1"])
//                    {
//                        tbxContent.text= self.model.rental;
//                    }
//                    else if ([self.model.manner isEqualToString:@"2"])
//                    {
//                       tbxContent.text = self.model.deduct;
//                    }
//                    else if ([self.model.manner isEqualToString:@"3"])
//                    {
//                       tbxContent.text = self.model.rental;
//                    }
                }
                    break;
                case 204: {
                    //纯租金
                    tbxContent.text= self.model.rental;
                    
                    break;
                }
                case 2000:
                {
                    //物业管理费
                    tbxContent.text = self.model.expenses;
                    [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                }
                    break;
//                case 208:
//                {
//                    //物业管理费
//                    //扣点+租金的扣点
//                    tbxContent.text = self.model.deduct;
//                    [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
//                }
                    break;
         
                default:
                    break;
            }
        }
      
    }else{
        switch (indexPath.section) {
            case 2: {
                //递增方式
                
                self.textView = [[CGLimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
                self.textView.limitNum = 200;
                if (IsStringEmpty(self.model.diZengXinXi))
                {
                     self.textView.placeHolder = @"详情...";
                }
               else
               {
                   self.textView.textView.text =self.model.diZengXinXi;
               }
                [cell.contentView addSubview:self.textView];
                
                break;
            }
            case 3: {
                //备注信息
                
                self.textView2 = [[CGLimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
                self.textView2.limitNum = 200;
                if (IsStringEmpty(self.model.note))
                {
                    self.textView2.placeHolder = @"详情...";
                }
                else
                {
                    self.textView2.textView.text =self.model.note;
                }
                [cell.contentView addSubview:self.textView2];
                
                break;
            }
            case 4: {
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
                if (imageCount < 99) {
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
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    self.model.diZengXinXi = self.textView.textView.text;
    self.model.note = self.textView2.textView.text;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITextField *tbxContent = [cell.contentView viewWithTag:202];
    
    if (indexPath.section ==0)
    {
        if (indexPath.row ==0)
        {
            //跳转客户
            if (self.type ==1) return; 
            //选择客户
            CGSelectAddCustomerViewController *selectAddCustomerView = [[CGSelectAddCustomerViewController alloc]init];
            selectAddCustomerView.type =2;
            WS(weakSelf);
            selectAddCustomerView.callBack = ^(CGSelectAddCustomerModel *model)
            {
                weakSelf.backCust_id        = model.cust_id;//客户id
                weakSelf.backCust_name      = model.name;//客户名称;
                weakSelf.customer_id        = model.cust_id;
                //根据客户id回调默认数据
                [weakSelf getRelatedSign];
            };
            [self.navigationController pushViewController:selectAddCustomerView animated:YES];
        }
        
        if (IsStringEmpty(self.model.cust_id))
        {
            [MBProgressHUD showError:@"请先选择客户" toView:self.view];
            return;
        }
        if (indexPath.row ==1)
        {
            //签约铺位
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
                weakSelf.model.pos_ids = pos_id;
                weakSelf.model.pos_name = pos_name;
                
                NSArray *tempAreaArr = [pos_area componentsSeparatedByString:@","];
                
                float z = 0;
                for (int i=0; i<[tempAreaArr count]; i++)
                {
                    float a = [[tempAreaArr objectAtIndex:i]floatValue];
                    z += a;
                }
                self.model.area = [NSString stringWithFormat:@"%.2f",z];
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:unitSelectionView animated:YES];
        }

    }

    switch (indexPath.section) {
        case 1: {
            if (IsStringEmpty(self.model.cust_id))
            {
                [MBProgressHUD showError:@"请先选择客户" toView:self.view];
                return;
            }
            switch (indexPath.row)
            {
                case 0:
                {
                   
                    //时间
                    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
                        
                        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                        self.model.start_time =date;
                        self.model.end_time = @"";
                        [self.tableView reloadData];
                    }];
                    datepicker.dateLabelColor = MAIN_COLOR;//年-月-日-时-分 颜色
                    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
                    datepicker.doneButtonColor = MAIN_COLOR;//确定按钮的颜色
                    [datepicker show];
                 
                    break;
                }
                case 1:
                {
                    //时间
                    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
                        // 开始时间
                        NSString *beginStr = [self.model.start_time stringByReplacingOccurrencesOfString:@"-" withString:@""];
                        NSInteger beginNum = [beginStr integerValue];

                        // 结束时间 校验
                        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                        NSString *dateStr = [date stringByReplacingOccurrencesOfString:@"-" withString:@""];
                        NSInteger dateNum = [dateStr integerValue];

                        if (beginNum >= dateNum)
                        {
                            [MBProgressHUD showError:@"结束时间不能小于或等于开始时间" toView:self.view];
                            return ;
                        }
                        
                        self.model.end_time =date;
                        [self.tableView reloadData];
                    }];
                    datepicker.dateLabelColor = MAIN_COLOR;//年-月-日-时-分 颜色
                    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
                    datepicker.doneButtonColor = MAIN_COLOR;//确定按钮的颜色
                    [datepicker show];
                    break;
                }
                case 2: {
                    //合作方式
                    
                    CGMannerSheetView *sheetView = [[CGMannerSheetView alloc] init];
                    WS(weakSelf);
                    sheetView.callBack = ^(NSString *manner_id, NSString *manner_name)
                    {
                        NSLog(@"合作方式ID：%@=名称：%@",manner_id,manner_name);
                        //合作方式:1纯租金 2纯扣点 3保底租金+扣点取其高 4自营
                        weakSelf.model.manner = manner_id;
                        weakSelf.model.manner_name = manner_name;
                        NSMutableArray *titleArr = [titleDic objectForKey:@"1"];
                        
                        //重组数组
                        NSMutableArray *argsArr = [NSMutableArray array];
                        for (int i=0; i<3; i++) {
                            [argsArr addObject:[titleArr objectAtIndex:i]];
                        }
                        
                        switch ([manner_id integerValue]) {
                            case 1: {
                                //纯租金
                                [argsArr addObject:@[@"纯租金",@"请输入租金",@"0",@"元/年",@"2",@"0",@"204"]];
                                
                                break;
                            }
                            case 2: {
                                //纯扣点
                                [argsArr addObject:@[@"纯扣点",@"请输入扣点",@"0",@"%",@"0",@"0",@"203"]];
                                
                                break;
                            }
                            case 3: {
                                //保底租金+扣点取其高
                                [argsArr addObject:@[@"纯租金",@"请输入租金",@"0",@"元/年",@"2",@"0",@"204"]];
                                [argsArr addObject:@[@"纯扣点",@"请输入扣点",@"0",@"%",@"0",@"0",@"203"]];
                                
                                break;
                            }
                            case 4: {
                                //自营
                                
                                break;
                            }
                                
                            default:
                                break;
                        }
                        
                        //增加物业管理费
                        [argsArr addObject:[titleArr objectAtIndex:[titleArr count]-1]];
                        
                        //最后重新给第二区块赋值
                        [titleDic setValue:argsArr forKey:@"1"];
                        
//                        if ([manner_id isEqualToString:@"1"])
//                        {
//                            if (titleArr.count ==4)
//                            {
//                                [titleArr insertObject:@[@"纯租金",@"请输入租金",@"0",@"元/年",@"2",@"0",@"203"]atIndex:3];
//                            }
//                            else if (titleArr.count ==5)
//                            {
//                                [titleArr removeObjectAtIndex:3];
//                                [titleArr insertObject:@[@"纯租金",@"请输入租金",@"0",@"元/年",@"2",@"0",@"203"]atIndex:3];
//                            }
//                            else if (titleArr.count ==6)
//                            {
//                                [titleArr removeObjectAtIndex:3];
//                                [titleArr removeObjectAtIndex:3];
//                                [titleArr insertObject:@[@"纯租金",@"请输入租金",@"0",@"元/年",@"2",@"0",@"203"]atIndex:3];
//                            }
//                            [titleDic setValue:titleArr forKey:@"1"];
//                        }
//                        else if ([manner_id isEqualToString:@"2"])
//                        {
//
//
//                            if (titleArr.count ==4)
//                            {
//                                [titleArr insertObject:@[@"纯扣点",@"请输入扣点",@"0",@"%",@"0",@"0",@"203"]atIndex:3];
//                            }
//                            else if (titleArr.count ==5)
//                            {
//                                [titleArr removeObjectAtIndex:3];
//                                [titleArr insertObject:@[@"纯扣点",@"请输入扣点",@"0",@"%",@"0",@"0",@"203"]atIndex:3];
//                            }
//                            else if (titleArr.count ==6)
//                            {
//                                [titleArr removeObjectAtIndex:3];
//                                [titleArr removeObjectAtIndex:3];
//                                [titleArr insertObject:@[@"纯扣点",@"请输入扣点",@"0",@"%",@"0",@"0",@"203"]atIndex:3];
//                            }
//                            [titleDic setValue:titleArr forKey:@"1"];
//                        }
//                        else if ([manner_id isEqualToString:@"3"])
//                        {
//
//                            if (titleArr.count ==4)
//                            {
//                                [titleArr insertObject:@[@"纯租金",@"请输入租金",@"0",@"元/年",@"2",@"0",@"203"]atIndex:3];
//                                [titleArr insertObject:@[@"纯扣点",@"请输入扣点",@"0",@"%",@"0",@"0",@"203"]atIndex:4];
//                            }
//                            else if (titleArr.count ==5)
//                            {
//                                [titleArr removeObjectAtIndex:3];
//                                [titleArr insertObject:@[@"纯租金",@"请输入租金",@"0",@"元/年",@"2",@"0",@"203"]atIndex:3];
//                                [titleArr insertObject:@[@"纯扣点",@"请输入扣点",@"0",@"%",@"0",@"0",@"203"]atIndex:4];
//                            }
//                            else if (titleArr.count ==5)
//                            {
//                                [titleArr removeObjectAtIndex:3];
//                                [titleArr removeObjectAtIndex:3];
//                                [titleArr insertObject:@[@"纯租金",@"请输入租金",@"0",@"元/年",@"2",@"0",@"203"]atIndex:3];
//                                [titleArr insertObject:@[@"纯扣点",@"请输入扣点",@"0",@"%",@"0",@"0",@"203"]atIndex:4];
//                            }
//
//                            [titleDic setValue:titleArr forKey:@"1"];
//                        }
//                        else if ([manner_id isEqualToString:@"4"])
//                        {
//                            if (titleArr.count ==5)
//                            {
//                                 [titleArr removeObjectAtIndex:3];
//                            }
//                            else if (titleArr.count ==6)
//                            {
//                                [titleArr removeObjectAtIndex:3];
//                                [titleArr removeObjectAtIndex:3];
//                            }
//                        }
                        
                        [self.tableView reloadData];
                    };
                    [sheetView show];
                    
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
    
    //递增方式
    self.model.diZengXinXi = self.textView.textView.text;
    //备注信息
    self.model.note = self.textView.textView.text;
    
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    switch (textField.tag) {
        case 203: {
            //扣点
            self.model.deduct = textField.text;
//            if ([self.model.manner isEqualToString:@"1"])
//            {
//                self.model.rental = textField.text;
//            }
//            else if ([self.model.manner isEqualToString:@"2"])
//            {
//                self.model.deduct = textField.text;
//            }
//            else if ([self.model.manner isEqualToString:@"3"])
//            {
//                self.model.rental = textField.text;
//            }
    
            break;
        }
        case 204: {
            //纯租金
            self.model.rental = textField.text;
            
            break;
        }
        case 2000: {
            //物业管理费
            self.model.expenses = textField.text;
            break;
        }
//        case 208: {
//            //扣点+租金的扣点
//            self.model.deduct = textField.text;
//            break;
//        }
            
        default:
            break;
    }
    
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
    [self.view endEditing:YES];
    
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
        pickerVc.maxCount = 99;
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
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:4];
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
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:4];
    [self.tableView beginUpdates];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}


/**
 *  删除按钮功能
 */
- (void)btnDeleteClick:(UIButton *)btnSender {
    NSLog(@"删除图片");
    [self.view endEditing:YES];
    
    if ([(UIButton *)btnSender.superview isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)(UIButton *)btnSender.superview;
        [self.imagePickerArray removeObjectAtIndex:(imageView.tag - 2000)];
        [self.assetsArr removeObjectAtIndex:imageView.tag - 2000];
        [imageView removeFromSuperview];
    }
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:4];
    [self.tableView beginUpdates];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

//新增合同时，查询默认信息
- (void)getRelatedSign
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getRelatedSign" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.customer_id forKey:@"cust_id"];
    [MBProgressHUD showMsg:@"加载中..." toView:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
    {
        [MBProgressHUD hideHUD:self.view];
        NSString *code = json[@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            self.model = [CGContractModel mj_objectWithKeyValues:json[@"data"]];
            
            //如果客户id为空 就把从客户界面选择的客户信息赋值给model
            if (IsStringEmpty(self.model.cust_id))
            {
                self.model.cust_id   = self.backCust_id;
                self.model.cust_name = self.backCust_name;
            }
            if (self.type ==1)
            {
                if (!IsStringEmpty(self.customer_id))
                {
                    self.model.cust_id =self.customer_id;
                    self.model.cust_name = self.customer_name;
                }
            }
           
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD:self.view];
    }];
}

-(void)setSign
{
    if (IsStringEmpty(self.model.cust_id))
    {
        [MBProgressHUD showError:@"请选择客户" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.pos_ids))
    {
        [MBProgressHUD showError:@"请选择铺位" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.start_time))
    {
        [MBProgressHUD showError:@"请选择合同开始时间" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.end_time))
    {
        [MBProgressHUD showError:@"请选择合同结束时间" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.manner))
    {
        [MBProgressHUD showError:@"请选择合作方式" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.textView.textView.text))
    {
        [MBProgressHUD showError:@"请输入递增方式" toView:self.view];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"setSign" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.model.cust_id forKey:@"cust_id"];
    [param setValue:self.model.pos_ids forKey:@"pos_id"];
    [param setValue:self.model.area forKey:@"area"];
    [param setValue:self.model.start_time forKey:@"start_time"];
    [param setValue:self.model.end_time forKey:@"end_time"];
    [param setValue:self.model.manner forKey:@"manner"];
    [param setValue:self.model.rental forKey:@"rental"];
    [param setValue:self.model.rental_unit forKey:@"rental_unit"];
    [param setValue:self.model.deduct forKey:@"deduct"];
    [param setValue:self.model.expenses forKey:@"expenses"];
    [param setValue:self.model.expenses_unit forKey:@"expenses_unit"];
    [param setValue:self.textView.textView.text forKey:@"rent_increase"];
    [param setValue:self.textView2.textView.text forKey:@"note"];
    [MBProgressHUD showMsg:@"保存中..." toView:self.view];
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
