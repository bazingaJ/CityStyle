//
//  CGContractViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGContractViewController.h"
#import "CGContractListViewController.h"
#import "CGContractTerminateViewController.h"
#import "CGContractModel.h"
#import "CGContractAddViewController.h"

@interface CGContractViewController () {
    NSMutableDictionary *titleDic;
    
    //合同对象
    CGContractModel *contractModel;
}

@end

@implementation CGContractViewController

- (void)viewDidLoad {
    if ([self.isMine isEqualToString:@"1"])
    {
        if (self.isAllCust)
        {
            [self setBottomH:45];
        }
        else
        {
           [self setBottomH:90];
        }
        
    }
    else
    {
        [self setBottomH:45];
    }
   
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"合同";
    
    //设置数据源
    titleDic = [NSMutableDictionary dictionary];
    
    //第一块
    //备注：标题/描述/是否必填/是否可编辑/索引值
    NSMutableArray *titleArr1 = [NSMutableArray array];
    [titleArr1 addObject:@[@"项目名称",@"0"]];
    [titleArr1 addObject:@[@"客户名称",@"0"]];
    [titleArr1 addObject:@[@"签约铺位",@"1"]];
    [titleArr1 addObject:@[@"签约面积",@"0"]];
    [titleDic setValue:titleArr1 forKey:@"0"];
    
    //第二块
    NSMutableArray *titleArr2 = [NSMutableArray array];
    [titleArr2 addObject:@[@"合同开始时间",@"0"]];
    [titleArr2 addObject:@[@"合同结束时间",@"0"]];
    [titleArr2 addObject:@[@"合作方式",@"0"]];
    [titleArr2 addObject:@[@"扣点",@"0"]];
    [titleArr2 addObject:@[@"物业管理费",@"0"]];
    [titleDic setValue:titleArr2 forKey:@"1"];
    
    if ([self.isMine isEqualToString:@"1"])
    {
        if (!self.isAllCust)
        {
            if (self.isSign)
            {
                //创建“终止合同”按钮
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-90, SCREEN_WIDTH, 45)];
                [btnFunc setTitle:@"终止合同" forState:UIControlStateNormal];
                [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnFunc.titleLabel setFont:FONT17];
                [btnFunc setBackgroundColor:MAIN_COLOR];
                [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:btnFunc];
            }
            else
            {
                //设置添加合同
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-90, SCREEN_WIDTH, 45)];
                [btnFunc setTitle:@"添加合同" forState:UIControlStateNormal];
                [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnFunc.titleLabel setFont:FONT17];
                [btnFunc setBackgroundColor:MAIN_COLOR];
                [btnFunc addTarget:self action:@selector(addBtnFuncClick) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:btnFunc];
            }
        }
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.isSign) return 0;
 
    if(!contractModel) return 0;
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
    if(section<=1) {
        return 10;
    }
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 2:
            //递增方式
            return contractModel.cellH;
            
            break;
        case 3:
            //备注信息
            return contractModel.cellH2;
            
            break;
        case 4: {
            //附件
            
            NSInteger imgNum = contractModel.images.count;
            NSInteger rowNum = 0;
            if(imgNum>0) {
                rowNum = imgNum/3;
                NSInteger colNum = imgNum%3;
                if(colNum>0) {
                    rowNum += 1;
                }
            }else{
                rowNum = 1;
            }
            return (pictureHW+10)*rowNum + 10;
            
            break;
        }
            
        default:
            break;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section==4) {
        return 40;
    }
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section<=1) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    [backView setBackgroundColor:[UIColor clearColor]];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-20, 35)];
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if(section!=4) return [UIView new];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [backView setBackgroundColor:[UIColor clearColor]];
    
    //创建“查看历史合同”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-130, 5, 120, 30)];
    [btnFunc setTitle:@"查看历史合同>>" forState:UIControlStateNormal];
    [btnFunc setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT12];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btnFunc addTarget:self action:@selector(btnFuncMoreClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btnFunc];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGContractViewControllerCell";
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
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 25)];
        [lbMsg setText:itemArr[0]];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [lbMsg sizeToFit];
        [lbMsg setCenterY:22.5];
        [cell.contentView addSubview:lbMsg];
        
        //创建“是否必填标志”
        if([itemArr[1] integerValue]==1) {
            UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(lbMsg.right, 10, 10, 25)];
            [lbMsg2 setText:@"*"];
            [lbMsg2 setTextColor:[UIColor redColor]];
            [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
            [lbMsg2 setFont:SYSTEM_FONT_SIZE(17.0)];
            [cell.contentView addSubview:lbMsg2];
        }
        
        //创建“内容呈现”
        UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, SCREEN_WIDTH-130, 25)];
        [lbMsg3 setTextColor:COLOR3];
        [lbMsg3 setTextAlignment:NSTextAlignmentLeft];
        [lbMsg3 setFont:FONT16];
        [cell.contentView addSubview:lbMsg3];
        
        switch (indexPath.section) {
            case 0: {
                switch (indexPath.row) {
                    case 0: {
                        //项目名称
                        [lbMsg3 setText:contractModel.pro_name];
                        
                        break;
                    }
                    case 1: {
                        //客户名称
                        [lbMsg3 setText:contractModel.cust_name];
                        
                        break;
                    }
                    case 2: {
                        //签约铺位
                        [lbMsg3 setText: contractModel.pos_name];
                        
                        break;
                    }
                    case 3: {
                        //签约面积
                        NSString *areaStr = @"0";
                        if(!IsStringEmpty(contractModel.area)) {
                            areaStr = contractModel.area;
                        }
                        [lbMsg3 setText:[NSString stringWithFormat:@"%@m²",areaStr]];
                        
                        break;
                    }
                        
                    default:
                        break;
                }
                
                break;
            }
            case 1: {
                switch (indexPath.row) {
                    case 0: {
                        //合同开始时间
                        [lbMsg3 setText:contractModel.start_time];
                        
                        break;
                    }
                    case 1: {
                        //合同结束时间
                        [lbMsg3 setText:contractModel.end_time];
                        
                        break;
                    }
                    case 2: {
                        //合作方式
                        [lbMsg3 setText:contractModel.manner_name];
                        
                        break;
                    }
                    case 3:
                    {
                        if ([contractModel.manner isEqualToString:@"1"])
                        {
                            //租金
                            NSString *rental = @"0";
                            if(!IsStringEmpty(contractModel.rental)) {
                                rental = contractModel.rental;
                            }
                            [lbMsg3 setText:[rental stringByAppendingString:contractModel.rental_unit_name]];
                        }
                        if ([contractModel.manner isEqualToString:@"2"])
                        {
                            //扣点
                            NSString *deduct = @"0";
                            if(!IsStringEmpty(contractModel.deduct)) {
                                deduct = contractModel.deduct;
                            }
                            [lbMsg3 setText:[deduct stringByAppendingString:@"%"]];
                        }
                        if ([contractModel.manner isEqualToString:@"3"])
                        {
                            //租金
                            NSString *rental = @"0";
                            if(!IsStringEmpty(contractModel.rental)) {
                                rental = contractModel.rental;
                            }
                            [lbMsg3 setText:[rental stringByAppendingString:contractModel.rental_unit_name]];
                        }
                    
                        
                        break;
                    }
                    case 4: {
                        //物业管理费
                        if ([contractModel.manner isEqualToString:@"3"])
                        {
                            //扣点
                            NSString *deduct = @"0";
                            if(!IsStringEmpty(contractModel.deduct)) {
                                deduct = contractModel.deduct;
                            }
                            [lbMsg3 setText:[deduct stringByAppendingString:@"%"]];
                        }
                        else
                        {
                             [lbMsg3 setText:[NSString stringWithFormat:@"%@%@",contractModel.expenses,contractModel.expenses_unit_name]];
                        }
                        break;
                    }
                    case 5:
                    {
                        //物业管理费
                        [lbMsg3 setText:[NSString stringWithFormat:@"%@%@",contractModel.expenses,contractModel.expenses_unit_name]];
                        
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
        
        
        //创建“分割线”
        if(indexPath.row<[titleArr count]-1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(110, 44.5, SCREEN_WIDTH-110, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
        }
        
        
    }else{
        switch (indexPath.section) {
            case 2: {
                //递增方式
                
                NSString *introStr = contractModel.rent_increase;
                UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, contractModel.cellH-20)];
                [lbMsg setTextColor:COLOR9];
                [lbMsg setTextAlignment:NSTextAlignmentLeft];
                [lbMsg setFont:FONT14];
                [lbMsg setNumberOfLines:0];
                if(!IsStringEmpty(introStr)) {
                    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:introStr];
                    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                    [style setLineSpacing:5.0f];
                    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, introStr.length)];
                    [lbMsg setAttributedText:attStr];
                }
                [cell.contentView addSubview:lbMsg];
                
                break;
            }
            case 3: {
                //备注信息
                
                NSString *introStr = contractModel.note;
                UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, contractModel.cellH2-20)];
                [lbMsg setTextColor:COLOR9];
                [lbMsg setTextAlignment:NSTextAlignmentLeft];
                [lbMsg setFont:FONT14];
                [lbMsg setNumberOfLines:0];
                if(!IsStringEmpty(introStr)) {
                    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:introStr];
                    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                    [style setLineSpacing:5.0f];
                    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, introStr.length)];
                    [lbMsg setAttributedText:attStr];
                }
                [cell.contentView addSubview:lbMsg];
                
                break;
            }
            case 4: {
                //附件
                
                for (NSInteger i=0; i<contractModel.images.count; i++) {
                    NSString *imgURL = contractModel.images[i];
                    
                    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (i%3)*(pictureHW+10), 10 +(i/3)*(pictureHW+10), pictureHW, pictureHW)];
                    [imgView setContentMode:UIViewContentModeScaleAspectFill];
                    [imgView setClipsToBounds:YES];
                    [imgView.layer setCornerRadius:4.0];
                    [imgView.layer setMasksToBounds:YES];
                    [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
                    [imgView setUserInteractionEnabled:YES];
                    [imgView addTouch:^{
                        NSLog(@"点击了图片:%zd",i);
                        
                        NSMutableArray *photoArr = [NSMutableArray array];
                        for (NSString *imgURL in contractModel.images) {
                            ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
                            photo.photoURL = [NSURL URLWithString:imgURL];
                            [photoArr addObject:photo];
                        }
                        
                        // 图片游览器
                        ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
                        // 淡入淡出效果
                        pickerBrowser.status = UIViewAnimationAnimationStatusFade;
                        // 数据源/delegate
                        pickerBrowser.photos = photoArr;
                        // 能够删除
                        pickerBrowser.delegate = self;
                        // 当前选中的值
                        pickerBrowser.currentIndex = i;
                        // 展示控制器
                        [pickerBrowser showPickerVc:self];
                        
                    }];
                    [cell.contentView addSubview:imgView];
                }
                
                break;
            }
                
            default:
                break;
        }
    }
    
    
    return cell;
}

/**
 *  查看更多历史合同
 */
- (void)btnFuncMoreClick:(UIButton *)btnSender {
    NSLog(@"查看更多历史合同");
    
    CGContractListViewController *contractList = [[CGContractListViewController alloc] init];
    contractList.cust_id = self.cust_id;
    [self.navigationController pushViewController:contractList animated:YES];
    
}

/**
 *  终止合同按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"终止合同按钮事件");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGContractTerminateViewController *terminateView = [[CGContractTerminateViewController alloc] init];
    terminateView.contract_id = contractModel.id;
    [self.navigationController pushViewController:terminateView animated:YES];
    
}

/**
 * 添加合同按钮事件
 */
- (void)addBtnFuncClick
{
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGContractAddViewController *contractAddView = [[CGContractAddViewController alloc] init];
    contractAddView.type = 1;
    contractAddView.customer_name = self.cust_name;
    contractAddView.customer_id = self.cust_id;
    [self.navigationController pushViewController:contractAddView animated:YES];
    
}

/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"getSignInfo" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.cust_id forKey:@"cust_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            contractModel = [CGContractModel mj_objectWithKeyValues:dataDic];
            if ([contractModel.manner isEqualToString:@"1"])
            {
                NSMutableArray *titleArr2 = [NSMutableArray array];
                [titleArr2 addObject:@[@"合同开始时间",@"0"]];
                [titleArr2 addObject:@[@"合同结束时间",@"0"]];
                [titleArr2 addObject:@[@"合作方式",@"0"]];
                [titleArr2 addObject:@[@"租金",@"0"]];
                [titleArr2 addObject:@[@"物业管理费",@"0"]];
                [titleDic setValue:titleArr2 forKey:@"1"];
            }
            if ([contractModel.manner isEqualToString:@"2"])
            {
                NSMutableArray *titleArr2 = [NSMutableArray array];
                [titleArr2 addObject:@[@"合同开始时间",@"0"]];
                [titleArr2 addObject:@[@"合同结束时间",@"0"]];
                [titleArr2 addObject:@[@"合作方式",@"0"]];
                [titleArr2 addObject:@[@"扣点",@"0"]];
                [titleArr2 addObject:@[@"物业管理费",@"0"]];
                [titleDic setValue:titleArr2 forKey:@"1"];
            }
            if ([contractModel.manner isEqualToString:@"3"])
            {
                NSMutableArray *titleArr2 = [NSMutableArray array];
                [titleArr2 addObject:@[@"合同开始时间",@"0"]];
                [titleArr2 addObject:@[@"合同结束时间",@"0"]];
                [titleArr2 addObject:@[@"合作方式",@"0"]];
                [titleArr2 addObject:@[@"租金",@"0"]];
                [titleArr2 addObject:@[@"扣点",@"0"]];
                [titleArr2 addObject:@[@"物业管理费",@"0"]];
                [titleDic setValue:titleArr2 forKey:@"1"];
            }
             if ([contractModel.manner isEqualToString:@"4"])
            {
                NSMutableArray *titleArr2 = [NSMutableArray array];
                [titleArr2 addObject:@[@"合同开始时间",@"0"]];
                [titleArr2 addObject:@[@"合同结束时间",@"0"]];
                [titleArr2 addObject:@[@"合作方式",@"0"]];
                [titleArr2 addObject:@[@"物业管理费",@"0"]];
                [titleDic setValue:titleArr2 forKey:@"1"];
            }
            
            NSString *area = dataDic[@"area"];
            if (!IsStringEmpty(area))
            {
                self.isSign = YES;
            }
            else
            {
                self.isSign = NO;
            }
            
            if ([self.isMine isEqualToString:@"1"])
            {
                if (!self.isAllCust)
                {
                    if (self.isSign)
                    {
                        //创建“终止合同”按钮
                        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-90, SCREEN_WIDTH, 45)];
                        [btnFunc setTitle:@"终止合同" forState:UIControlStateNormal];
                        [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [btnFunc.titleLabel setFont:FONT17];
                        [btnFunc setBackgroundColor:MAIN_COLOR];
                        [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
                        [self.view addSubview:btnFunc];
                    }
                    else
                    {
                        //设置添加合同
                        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-90, SCREEN_WIDTH, 45)];
                        [btnFunc setTitle:@"添加合同" forState:UIControlStateNormal];
                        [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [btnFunc.titleLabel setFont:FONT17];
                        [btnFunc setBackgroundColor:MAIN_COLOR];
                        [btnFunc addTarget:self action:@selector(addBtnFuncClick) forControlEvents:UIControlEventTouchUpInside];
                        [self.view addSubview:btnFunc];
                    }
                }
               
            }
        }
        
        //设置空白页面
        [self.tableView emptyViewShowWithDataType:EmptyViewTypeContract
                                          isEmpty:!self.isSign
                              emptyViewClickBlock:^(NSInteger tIndex) {
                                  [self btnFuncMoreClick:nil];
                              }];
        
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
    }];
    
}
@end
