//
//  CGCustomerInfoExViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGCustomerInfoExViewController.h"
#import "CGCustomerModel.h"
#import "CGCustomerInfoEditExViewController.h"

@interface CGCustomerInfoExViewController () {
    //标题
    NSMutableArray *titleArr;
    //数据源
    NSMutableDictionary *titleDic;
    //客户对象
    CGCustomerModel *customerModel;
}

@end

@implementation CGCustomerInfoExViewController

- (void)viewDidLoad {
    if([self.isMine isEqualToString:@"1"]) {
        [self setRightButtonItemTitle:@"编辑"];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

/**
 *  编辑按钮事件
 */
- (void)rightButtonItemClick {
    NSLog(@"编辑");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGCustomerInfoEditExViewController *editView = [[CGCustomerInfoEditExViewController alloc] init];
    editView.customerModel = customerModel;
    editView.callBack = ^(CGCustomerModel *customerInfo) {
        NSLog(@"编辑名片回调成功");
        
        //customerModel = customerInfo;
        
        [self.tableView.mj_header beginRefreshing];
        
    };
    [self.navigationController pushViewController:editView animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(!customerModel) return 0;
    return [titleDic count]+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return 1;
    }
    NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",section]];
    return [titleArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section<=1) {
        return 0.0001;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0) {
        return 70;
    }else {
        NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",indexPath.section]];
        NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
        NSString *titleStr = itemArr[0];
        if(IsStringEmpty(titleStr)) {
            return 50;
        }
        return 45;
    }
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section<=1) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    
    NSArray *itemArr = [titleArr objectAtIndex:section-2];
    
    //创建“名称”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-20, 30)];
    [lbMsg setText:itemArr[0]];
    if([itemArr[1] integerValue]==1) {
        //居中
        [lbMsg setTextColor:[UIColor blackColor]];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
    }else{
        //靠做
        [lbMsg setTextColor:COLOR6];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
    }
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    return backView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGCustomerInfoExViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if(indexPath.section==0) {
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 120, 20)];
        [lbMsg setText:@"LOGO/头像"];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [cell.contentView addSubview:lbMsg];
        
        //创建“头像”
        NSString *imgURL = customerModel.logo;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 10, 50, 50)];
        [imgView setContentMode:UIViewContentModeScaleAspectFill];
        [imgView setClipsToBounds:YES];
        [imgView.layer setCornerRadius:4.0];
        [imgView.layer setMasksToBounds:YES];
        [imgView.layer setBorderWidth:0.5];
        [imgView.layer setBorderColor:MAIN_COLOR.CGColor];
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
        [cell.contentView addSubview:imgView];
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 69.5, SCREEN_WIDTH, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [cell.contentView addSubview:lineView];
        
    }else{
        
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
        
        //创建“内容”
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH-120, 25)];
        [lbMsg2 setTextColor:COLOR3];
        [lbMsg2 setTextAlignment:NSTextAlignmentRight];
        [lbMsg2 setFont:FONT15];
        [cell.contentView addSubview:lbMsg2];
        
        switch ([itemArr[1] integerValue]) {
            case 100: {
                //客户名称
                [lbMsg2 setText:customerModel.name];
                
                break;
            }
            case 101: {
                //所属团队
                [lbMsg2 setText:customerModel.pro_name];
                
                break;
            }
            case 102: {
                //经营动态
                [lbMsg2 setText:customerModel.cate_name];
                
                break;
            }
            case 103: {
                //官网
                [lbMsg2 setText:customerModel.website];
                
                break;
            }
            case 200: {
                //城市要求
                [lbMsg2 setText:customerModel.city];
                
                break;
            }
            case 202: {
                //商圈内容
                [lbMsg2 setNumberOfLines:0];
                [lbMsg2 setFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 40)];
                NSString *contentStr = customerModel.business;
                if(!IsStringEmpty(contentStr)) {
                    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
                    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                    [style setAlignment:NSTextAlignmentLeft];
                    [style setLineSpacing:3.0f];
                    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
                    [lbMsg2 setAttributedText:attStr];
                }
                
                break;
            }
            case 204: {
                //楼层内容
                [lbMsg2 setFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 40)];
                [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
                [lbMsg2 setText:customerModel.floor];
                
                break;
            }
            case 205: {
                //面宽(不小于)
                NSString *with = @"0";
                if(!IsStringEmpty(customerModel.width)) {
                    with = customerModel.width;
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"%@m",with]];
                
                break;
            }
            case 206: {
                //进深(不大于)
                NSString *depth = @"0";
                if(!IsStringEmpty(customerModel.depth)) {
                    depth = customerModel.depth;
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"%@m",depth]];
                
                break;
            }
            case 207: {
                //面积需求
                NSString *areaStr = @"0";
                if(!IsStringEmpty(customerModel.area)) {
                    if(!IsStringEmpty(customerModel.min_area) && !IsStringEmpty(customerModel.max_area)) {
                        areaStr = [NSString stringWithFormat:@"%@-%@",customerModel.min_area,customerModel.max_area];
                    }else if(!IsStringEmpty(customerModel.min_area)) {
                        //最小值
                        areaStr = customerModel.min_area;
                    }else if(!IsStringEmpty(customerModel.max_area)) {
                        //最大值
                        areaStr = customerModel.max_area;
                    }
                }
                NSString *subfix = @"";
                if(![areaStr containsString:@"-"]) {
                    subfix = @"左右";
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"%@m²%@",areaStr,subfix]];
                
                break;
            }
            case 209: {
                //相邻喜好业态内容
                [lbMsg2 setNumberOfLines:0];
                [lbMsg2 setFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 40)];
                NSString *contentStr = customerModel.like_cate_name;
                if(!IsStringEmpty(contentStr)) {
                    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
                    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                    [style setAlignment:NSTextAlignmentLeft];
                    [style setLineSpacing:3.0f];
                    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
                    [lbMsg2 setAttributedText:attStr];
                }
                
                break;
            }
            case 300: {
                //层高
                NSString *height = @"0";
                if(!IsStringEmpty(customerModel.height)) {
                    height = customerModel.height;
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"%@m",height]];
                
                break;
            }
            case 400: {
                //厨房(承重)
                NSString *supportStr = @"0";
                if(!IsStringEmpty(customerModel.support_kitchen)) {
                    supportStr = customerModel.support_kitchen;
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"%@ KG/m²",supportStr]];
                
                break;
            }
            case 401: {
                //其他区(承重)
                NSString *supportStr = @"0";
                if(!IsStringEmpty(customerModel.support_other)) {
                    supportStr = customerModel.support_other;
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"%@ KG/m²",supportStr]];
                
                break;
            }
            case 403: {
                //备注内容(承重)
                [lbMsg2 setNumberOfLines:0];
                [lbMsg2 setFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 40)];
                NSString *contentStr = customerModel.support_note;
                if(!IsStringEmpty(contentStr)) {
                    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
                    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                    [style setAlignment:NSTextAlignmentLeft];
                    [style setLineSpacing:3.0f];
                    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
                    [lbMsg2 setAttributedText:attStr];
                }
                
                break;
            }
            case 50001: {
                //备注内容
                [lbMsg2 setNumberOfLines:0];
                [lbMsg2 setFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 40)];
                NSString *contentStr = customerModel.electric_note;
                if(!IsStringEmpty(contentStr)) {
                    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
                    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                    [style setAlignment:NSTextAlignmentLeft];
                    [style setLineSpacing:3.0f];
                    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
                    [lbMsg2 setAttributedText:attStr];
                }
                
                break;
            }
            case 600: {
                //供水管径
                NSString *diameterStr = @"0";
                if(!IsStringEmpty(customerModel.water_diameter)) {
                    diameterStr = customerModel.water_diameter;
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"DN%@mm",diameterStr]];
                
                break;
            }
            case 601: {
                //供水压力
                NSString *pressureStr = @"0";
                if(!IsStringEmpty(customerModel.water_pressure)) {
                    pressureStr = customerModel.water_pressure;
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"%@MPa",pressureStr]];
                
                break;
            }
            case 603: {
                //供水备注内容
                [lbMsg2 setNumberOfLines:0];
                [lbMsg2 setFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 40)];
                NSString *contentStr = customerModel.water_note;
                if(!IsStringEmpty(contentStr)) {
                    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
                    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                    [style setAlignment:NSTextAlignmentLeft];
                    [style setLineSpacing:3.0f];
                    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
                    [lbMsg2 setAttributedText:attStr];
                }
                
                break;
            }
            case 700: {
                //厨房(排水)
                NSString *diameterStr = @"0";
                if(!IsStringEmpty(customerModel.drain_diameter)) {
                    diameterStr = customerModel.drain_diameter;
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"DN%@mm",diameterStr]];
                
                break;
            }
            case 701: {
                //卫生间(排水)
                NSString *pressureStr = @"0";
                if(!IsStringEmpty(customerModel.drain_pressure)) {
                    pressureStr = customerModel.drain_pressure;
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"DN%@mm",pressureStr]];
                
                break;
            }
            case 702: {
                //隔油层(排水)
                NSString *poolStr = @"0";
                if(!IsStringEmpty(customerModel.drain_pool)) {
                    poolStr = customerModel.drain_pool;
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"%@ m³",poolStr]];
                
                break;
            }
            case 900: {
                //面积段
                NSString *areaStr = @"0";
                if(!IsStringEmpty(customerModel.warming_min_area) && !IsStringEmpty(customerModel.warming_max_area)) {
                    areaStr = [NSString stringWithFormat:@"%@-%@",customerModel.warming_min_area,customerModel.warming_max_area];
                }else if(!IsStringEmpty(customerModel.warming_min_area)) {
                    //最小值
                    areaStr = customerModel.warming_min_area;
                }else if(!IsStringEmpty(customerModel.warming_max_area)) {
                    //最大值
                    areaStr = customerModel.warming_max_area;
                }
                NSString *subfix = @"";
                if(![areaStr containsString:@"-"]) {
                    subfix = @"左右";
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"%@ m²%@",areaStr,subfix]];
                
                break;
            }
            case 901: {
                //预留面积
                NSString *hasArea = @"0";
                if(!IsStringEmpty(customerModel.warming_has_area)) {
                    hasArea = customerModel.warming_has_area;
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"%@ m²",hasArea]];
                
                break;
            }
            case 1000: {
                //消防
                [lbMsg2 setText:customerModel.fire];
                
                break;
            }
            case 1001: {
                //环评
                [lbMsg2 setText:customerModel.environment];
                
                break;
            }
            case 1003: {
                //备注内容
                [lbMsg2 setNumberOfLines:0];
                [lbMsg2 setFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 40)];
                NSString *contentStr = customerModel.fire_note;
                if(!IsStringEmpty(contentStr)) {
                    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
                    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                    [style setAlignment:NSTextAlignmentLeft];
                    [style setLineSpacing:3.0f];
                    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
                    [lbMsg2 setAttributedText:attStr];
                }
                
                break;
            }
            case 1004: {
                //排烟通道(1需要 2不需要)
                NSString *pipingStr = @"";
                if([customerModel.piping isEqualToString:@"1"]) {
                    pipingStr = @"需要";
                }else if([customerModel.piping isEqualToString:@"2"]) {
                    pipingStr = @"不需要";
                }
                [lbMsg2 setText:pipingStr];
                
                break;
            }
            case 1005: {
                //最小住距
                NSString *rangeStr = @"0";
                if(!IsStringEmpty(customerModel.range)) {
                    rangeStr = customerModel.range;
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"%@ m",rangeStr]];
                
                break;
            }
            case 1006: {
                //独立电梯(1需要 2不需要)
                NSString *elevator = @"";
                if([customerModel.elevator isEqualToString:@"1"]) {
                    elevator = @"需要";
                }else if([customerModel.elevator isEqualToString:@"2"]) {
                    elevator = @"不需要";
                }
                [lbMsg2 setText:elevator];
                
                break;
            }
                
            default:
                break;
        }
        
        //供电
        if([itemArr[1] integerValue]/100==5) {
            [lbMsg2 setText:itemArr[2]];
        }
        //燃气
        if([itemArr[1] integerValue]/100==8) {
            [lbMsg2 setText:itemArr[2]];
        }
        
        //创建“分割线”
        if(indexPath.row<[titleArr count]-1) {
            
            NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",indexPath.section]];
            NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
            NSString *titleStr = itemArr[0];
            CGFloat lineViewH = 45;
            if(IsStringEmpty(titleStr)) {
                lineViewH = 50;
            }
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lineViewH-0.5, SCREEN_WIDTH, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
        }
        
    }
    
    return cell;
}

/**
 *  获取信息
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"getCustInfo" forKey:@"act"];
    [param setValue:self.cust_id forKey:@"cust_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            customerModel = [CGCustomerModel mj_objectWithKeyValues:dataDic];
            
            //设置标题
            [self setTitleArr];
            
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
    }];
    
}

/**
 *  设置数据源
 */
- (void)setTitleArr {
    
    //设置标题
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"选址要求",@"1",@"2"]];
    [titleArr addObject:@[@"工程要求",@"1",@"3"]];
    [titleArr addObject:@[@"承重",@"0",@"4"]];
    [titleArr addObject:@[@"供电",@"0",@"5"]];
    [titleArr addObject:@[@"供水",@"0",@"6"]];
    [titleArr addObject:@[@"排水",@"0",@"7"]];
    NSInteger gasNum = customerModel.gas.count;
//    if(gasNum>0) {
//        [titleArr addObject:@[@"燃气",@"0",@"8"]];
//    }
    [titleArr addObject:@[@"燃气",@"0",@"8"]];
    [titleArr addObject:@[@"暖通",@"0",@"9"]];
    [titleArr addObject:@[@"消防、环评",@"0",@"10"]];
    
    //设置数据源
    titleDic = [NSMutableDictionary dictionary];
    
    //第一区块(基本信息)
    NSMutableArray *titleArr1 = [NSMutableArray array];
    [titleArr1 addObject:@[@"客户名称",@"100"]];
    [titleArr1 addObject:@[@"所属团队",@"101"]];
    [titleArr1 addObject:@[@"经营业态",@"102"]];
    [titleArr1 addObject:@[@"官网",@"103"]];
    [titleDic setValue:titleArr1 forKey:@"1"];
    
    //第二区块(选址要求)
    NSMutableArray *titleArr2 = [NSMutableArray array];
    [titleArr2 addObject:@[@"城市要求",@"200"]];
    [titleArr2 addObject:@[@"商圈要求",@"201"]];
    [titleArr2 addObject:@[@"",@"202"]];
    [titleArr2 addObject:@[@"楼层",@"203"]];
    [titleArr2 addObject:@[@"",@"204"]];
    [titleArr2 addObject:@[@"面宽(不小于)",@"205"]];
    [titleArr2 addObject:@[@"进深(不大于)",@"206"]];
    [titleArr2 addObject:@[@"面积要求",@"207"]];
    [titleArr2 addObject:@[@"相邻喜好业态",@"208"]];
    [titleArr2 addObject:@[@"",@"209"]];
    [titleDic setValue:titleArr2 forKey:@"2"];
    
    //第三区块(工程要求)
    NSMutableArray *titleArr3 = [NSMutableArray array];
    [titleArr3 addObject:@[@"层高",@"300"]];
    [titleDic setValue:titleArr3 forKey:@"3"];
    
    //第四区块(承重)
    NSMutableArray *titleArr4 = [NSMutableArray array];
    [titleArr4 addObject:@[@"厨房",@"400"]];
    [titleArr4 addObject:@[@"其他区",@"401"]];
    [titleArr4 addObject:@[@"备注",@"402"]];
    [titleArr4 addObject:@[@"",@"403"]];
    [titleDic setValue:titleArr4 forKey:@"4"];
    
    //第五区块(供电)
    NSMutableArray *titleArr5 = [NSMutableArray array];
    NSInteger elecNum = customerModel.electric.count;
    for (int i=0; i<elecNum; i++) {
        NSDictionary *itemDic = [customerModel.electric objectAtIndex:i];
        //面积段
        NSString *areaStr = [itemDic objectForKey:@"area"];
        if(IsStringEmpty(areaStr)) {
            areaStr = @"0";
        }
        //电压
        NSString *voltageStr = [itemDic objectForKey:@"voltage"];
        if(IsStringEmpty(voltageStr)) {
            voltageStr = @"0";
        }
        NSInteger tag = 500+[titleArr5 count];
        NSString *subfix = @"";
        if(![areaStr containsString:@"-"]) {
            subfix = @"左右";
        }
        [titleArr5 addObject:@[[NSString stringWithFormat:@"%@m²%@面积段",areaStr,subfix],@(tag),[NSString stringWithFormat:@"%@KW",voltageStr]]];
    }
    [titleArr5 addObject:@[@"备注",@"50000"]];
    [titleArr5 addObject:@[@"",@"50001"]];
    [titleDic setValue:titleArr5 forKey:@"5"];
    
    //第六区块(供水)
    NSMutableArray *titleArr6 = [NSMutableArray array];
    [titleArr6 addObject:@[@"管径",@"600"]];
    [titleArr6 addObject:@[@"压力",@"601"]];
    [titleArr6 addObject:@[@"备注",@"602"]];
    [titleArr6 addObject:@[@"",@"603"]];
    [titleDic setValue:titleArr6 forKey:@"6"];
    
    //第七区块(排水)
    NSMutableArray *titleArr7 = [NSMutableArray array];
    [titleArr7 addObject:@[@"厨房",@"700"]];
    [titleArr7 addObject:@[@"卫生间",@"701"]];
    [titleArr7 addObject:@[@"隔油池",@"702"]];
    [titleDic setValue:titleArr7 forKey:@"7"];
    
    //第八区块(燃气)
    NSMutableArray *titleArr8 = [NSMutableArray array];
    if(gasNum>0) {
        for (int i=0; i<gasNum; i++) {
            NSInteger tag = 800+[titleArr8 count];
            
            NSDictionary *itemDic = [customerModel.gas objectAtIndex:i];
            //面积段
            NSString *areaStr = [itemDic objectForKey:@"area"];
            if(IsStringEmpty(areaStr)) {
                areaStr = @"0";
            }
            NSString *subfix = @"";
            if(![areaStr containsString:@"-"]) {
                subfix = @"左右";
            }
            [titleArr8 addObject:@[@"面积段",@(tag),[NSString stringWithFormat:@"%@ m²%@",areaStr,subfix]]];
            //管径
            NSString *diameterStr = [itemDic objectForKey:@"diameter"];
            if(IsStringEmpty(diameterStr)) {
                diameterStr = @"0";
            }
            [titleArr8 addObject:@[@"管径",@(tag+1),[NSString stringWithFormat:@"%@ m³/小时",diameterStr]]];
            //流量
            NSString *flowStr = [itemDic objectForKey:@"flow"];
            if(IsStringEmpty(flowStr)) {
                flowStr = @"0";
            }
            [titleArr8 addObject:@[@"流量",@(tag+2),[NSString stringWithFormat:@"%@ m³/小时",flowStr]]];
        }
    }
    [titleDic setValue:titleArr8 forKey:@"8"];
    
    //第九区块(暖通)
    NSMutableArray *titleArr9 = [NSMutableArray array];
    [titleArr9 addObject:@[@"面积段",@"900"]];
    [titleArr9 addObject:@[@"预留面积",@"901"]];
    [titleDic setValue:titleArr9 forKey:@"9"];
    
    //第十区块(消防、环评)
    NSMutableArray *titleArr10 = [NSMutableArray array];
    [titleArr10 addObject:@[@"消防",@"1000"]];
    [titleArr10 addObject:@[@"环评",@"1001"]];
    [titleArr10 addObject:@[@"备注",@"1002"]];
    [titleArr10 addObject:@[@"",@"1003"]];
    [titleArr10 addObject:@[@"排烟通道",@"1004"]];
    [titleArr10 addObject:@[@"最小柱距",@"1005"]];
    [titleArr10 addObject:@[@"独立电梯",@"1006"]];
    [titleDic setValue:titleArr10 forKey:@"10"];
    
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
