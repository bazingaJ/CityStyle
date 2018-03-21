//
//  CGContractListDetailViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGContractListDetailViewController.h"
#import "CGContractModel.h"

@interface CGContractListDetailViewController () {
    NSMutableDictionary *titleDic;
    
    //合同对象
    CGContractModel *contractModel;
}

@end

@implementation CGContractListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"历史合同";
    
    //设置数据源
    titleDic = [NSMutableDictionary dictionary];
    
    //第一区块
    NSMutableArray *titleArr1 = [NSMutableArray array];
    [titleArr1 addObject:@[@"项目名称",@"0",]];
    [titleArr1 addObject:@[@"客户名称",@"0",]];
    [titleArr1 addObject:@[@"签约铺位",@"1",]];
    [titleArr1 addObject:@[@"签约面积",@"0",]];
    [titleDic setValue:titleArr1 forKey:@"0"];
    
    //第二区块
    NSMutableArray *titleArr2 = [NSMutableArray array];
    [titleArr2 addObject:@[@"合同开始时间",@"0",]];
    [titleArr2 addObject:@[@"合同结束时间",@"0",]];
    [titleArr2 addObject:@[@"合作方式",@"0",]];
    [titleArr2 addObject:@[@"扣点",@"0",]];
    [titleArr2 addObject:@[@"物业管理费",@"0",]];
    [titleDic setValue:titleArr2 forKey:@"1"];
    
    //第三区块
    NSMutableArray *titleArr3 = [NSMutableArray array];
    [titleArr3 addObject:@[@"终止类型",@"0",]];
    [titleDic setValue:titleArr3 forKey:@"5"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(!contractModel) return 0;
    if([contractModel.status isEqualToString:@"3"]) {
        return 8;
    }
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section<=1) {
        NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",section]];
        return [titleArr count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section<=1 || section==5) {
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
            }else {
                rowNum = 1;
            }
            return (pictureHW+10)*rowNum + 10;
            
            break;
        }
        case 6:
            //终止详情
            return contractModel.cellH3;
            
            break;
        case 7: {
            //附件2
            
            NSInteger imgNum = contractModel.destroy_images.count;
            NSInteger rowNum = 0;
            if(imgNum>0) {
                rowNum = imgNum/3;
                NSInteger colNum = imgNum%3;
                if(colNum>0) {
                    rowNum += 1;
                }
            }else {
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section<=1 || section==5) return [UIView new];
    
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
    }else if(section==6) {
        [lbMsg setText:@"终止详情"];
    }else if(section==7) {
        [lbMsg setText:@"附件"];
    }
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGContractListDetailViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if(indexPath.section<=1 || indexPath.section==5) {
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
        if([itemArr[1] integerValue]==1) {
            UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(lbMsg.right, 10, 10, 25)];
            [lbMsg2 setText:@"*"];
            [lbMsg2 setTextColor:[UIColor redColor]];
            [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
            [lbMsg2 setFont:SYSTEM_FONT_SIZE(17.0)];
            [cell.contentView addSubview:lbMsg2];
        }
        
        //创建“内容”
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, SCREEN_WIDTH-160, 25)];
        [lbMsg2 setTextColor:COLOR3];
        [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
        [lbMsg2 setFont:FONT16];
        [cell.contentView addSubview:lbMsg2];
        
        switch (indexPath.section) {
            case 0: {
                switch (indexPath.row) {
                    case 0: {
                        //项目名称
                        [lbMsg2 setText:contractModel.pro_name];
                        
                        break;
                    }
                    case 1: {
                        //客户名称
                        [lbMsg2 setText:contractModel.cust_name];
                        
                        break;
                    }
                    case 2: {
                        //签约铺位
                        [lbMsg2 setText:contractModel.pos_name];
                        
                        break;
                    }
                    case 3: {
                        //签约面积
                        NSString *areaStr = @"0";
                        if(!IsStringEmpty(contractModel.area)) {
                            areaStr = contractModel.area;
                        }
                        [lbMsg2 setText:[NSString stringWithFormat:@"%@m²",areaStr]];
                        
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
                        [lbMsg2 setText:contractModel.start_time];
                        
                        break;
                    }
                    case 1: {
                        //合同结束时间
                        [lbMsg2 setText:contractModel.end_time];
                        
                        break;
                    }
                    case 2: {
                        //合作方式
                        [lbMsg2 setText:contractModel.manner_name];
                        
                        break;
                    }
                    case 3: {
                        //扣点
                        NSString *deductStr = @"0";
                        if(!IsStringEmpty(contractModel.deduct)) {
                            deductStr = contractModel.deduct;
                        }
                        [lbMsg2 setText:[deductStr stringByAppendingString:@"%"]];
                        
                        break;
                    }
                    case 4: {
                        //物业管理费
                        [lbMsg2 setText:[NSString stringWithFormat:@"%@%@",contractModel.expenses,contractModel.expenses_unit_name]];
                        
                        break;
                    }
                        
                    default:
                        break;
                }
                
                break;
            }
            case 5: {
                //终止类型
                [lbMsg2 setText:contractModel.status_name];
                
                break;
            }
                
            default:
                break;
        }
        
        //创建“分割线”
        if(indexPath.row<[titleArr count]-1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(120, 44.5, SCREEN_WIDTH-120, 0.5)];
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
                    [cell.contentView addSubview:imgView];
                    
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
            case 6: {
                //终止详情
                
                NSString *introStr = contractModel.destroy_note;
                UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, contractModel.cellH3-20)];
                [lbMsg setTextColor:COLOR9];
                [lbMsg setTextAlignment:NSTextAlignmentLeft];
                [lbMsg setFont:FONT13];
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
            case 7: {
                //附件2
                
                for (NSInteger i=0; i<contractModel.destroy_images.count; i++) {
                    NSString *imgURL = contractModel.destroy_images[i];
                    
                    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (i%3)*(pictureHW+10), 10 +(i/3)*(pictureHW+10), pictureHW, pictureHW)];
                    [imgView setContentMode:UIViewContentModeScaleAspectFill];
                    [imgView setClipsToBounds:YES];
                    [imgView.layer setCornerRadius:4.0];
                    [imgView.layer setMasksToBounds:YES];
                    [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
                    [cell.contentView addSubview:imgView];
                    
                    [imgView setUserInteractionEnabled:YES];
                    [imgView addTouch:^{
                        NSLog(@"点击了图片:%zd",i);
                        
                        NSMutableArray *photoArr = [NSMutableArray array];
                        for (NSString *imgURL in contractModel.destroy_images) {
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
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"getHistorySignInfo" forKey:@"act"];
    [param setValue:self.contract_id forKey:@"id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            contractModel = [CGContractModel mj_objectWithKeyValues:dataDic];
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
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
