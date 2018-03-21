//
//  CGFindBrandDetailViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/15.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGFindBrandDetailViewController.h"
#import "CGFindModel.h"
#import "CGFindCompeteModel.h"
#import "CGFindPriceModel.h"

@interface CGFindBrandDetailViewController () {
    NSArray *titleArr;
    
    CGFindModel *findModel;
}

@end

@implementation CGFindBrandDetailViewController

/**
 *  价格数组
 */
- (NSMutableArray *)priceArr {
    if(!_priceArr) {
        _priceArr = [NSMutableArray array];
    }
    return _priceArr;
}

/**
 *  硬件数组
 */
- (NSMutableArray *)hardwareArr {
    if(!_hardwareArr) {
        _hardwareArr = [NSMutableArray array];
    }
    return _hardwareArr;
}

/**
 *  竞争对手数组
 */
- (NSMutableArray *)competeArr {
    if(!_competeArr) {
        _competeArr = [NSMutableArray array];
    }
    return _competeArr;
}

/**
 *  品牌数组
 */
- (NSMutableArray *)brandArr {
    if(!_brandArr) {
        _brandArr = [NSMutableArray array];
    }
    return _brandArr;
}

- (void)viewDidLoad {
    [self setBottomH:115];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置数据源
    titleArr = @[@"品牌资料",@"主要价格带",@"主要竞争对手",@"开店硬性条件参考标准",@"该公司旗下其他品牌"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(!findModel) return 0;
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            //基本信息
            return 1;
            
            break;
        case 1:
            //品牌资料
            return 3;
            
            break;
        case 2:
            //主要价格带
            return self.priceArr.count;
            
            break;
        case 3:
            //主要竞争对手
            return 1;
            
            break;
        case 4:
            //开店硬性条件参考标准
            return 1;
            
            break;
        case 5:
            //该公司旗下其他品牌
            return 1;
            
            break;
            
        default:
            break;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0) {
        return 10;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            //基本信息
            return findModel.cellH;
            
            break;
        case 1:
            //品牌资料
            return 45;
            
            break;
        case 2:
            //主要价格带
            return 45;
            
            break;
        case 3: {
            //主要竞争对手
            NSInteger itemNum = [self.competeArr count];
            NSInteger rowNum = itemNum/3;
            NSInteger colNum = itemNum%3;
            if(colNum>0) {
                rowNum += 1;
            }
            return rowNum*90;
            
            break;
        }
        case 4: {
            //开店硬性条件参考标准
            if(self.hardwareArr.count) {
                NSArray *titleArr = self.hardwareArr[0];
                return titleArr.count*45+30;
            }
            return 0;
            
            break;
        }
        case 5: {
            //该公司旗下其他品牌
            NSInteger itemNum = [self.brandArr count];
            NSInteger rowNum = itemNum/3;
            NSInteger colNum = itemNum%3;
            if(colNum>0) {
                rowNum += 1;
            }
            return rowNum*90;
            
            break;
        }
            
        default:
            break;
    }
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section==0) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    [backView setBackgroundColor:[UIColor clearColor]];
    
    UIView *itemV = [[UIView alloc] initWithFrame:CGRectMake(0, 10, backView.frame.size.width, 35)];
    [itemV setBackgroundColor:[UIColor whiteColor]];
    [backView addSubview:itemV];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, itemV.frame.size.width-20, 35)];
    [lbMsg setText:[titleArr objectAtIndex:section-1]];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentCenter];
    [lbMsg setFont:FONT15];
    [itemV addSubview:lbMsg];
    
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGFindBrandDetailViewControllerCell";
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
            //基本信息
            
            NSString *contentStr = findModel.note;
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, findModel.cellH-20)];
            [lbMsg setTextColor:COLOR6];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT14];
            [lbMsg setNumberOfLines:0];
            if(!IsStringEmpty(contentStr)) {
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:5.0f];
                [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
                [lbMsg setAttributedText:attStr];
            }
            [cell.contentView addSubview:lbMsg];
            
            break;
        }
        case 1: {
            //品牌资料
            NSArray *itemArr = @[@"品牌等级",@"消费者性别",@"消费者年龄构成"];
            
            //创建“标题”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 25)];
            [lbMsg setText:[itemArr objectAtIndex:indexPath.row]];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT15];
            [cell.contentView addSubview:lbMsg];
            
            //创建“内容”
            UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, SCREEN_WIDTH-170, 25)];
            if(indexPath.row==0) {
                //品牌等级
                [lbMsg2 setText:findModel.level];
            }else if(indexPath.row==1) {
                //消费者性别
                [lbMsg2 setText:findModel.cust_sex];
            }else if(indexPath.row==2) {
                //消费者年龄构成
                [lbMsg2 setText:findModel.cust_age];
            }
            [lbMsg2 setTextColor:COLOR3];
            [lbMsg2 setTextAlignment:NSTextAlignmentRight];
            [lbMsg2 setFont:FONT15];
            [cell.contentView addSubview:lbMsg2];
            
            //创建“分割线”
            if(indexPath.row<[itemArr count]-1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
                [lineView setBackgroundColor:LINE_COLOR];
                [cell.contentView addSubview:lineView];
            }
            
            break;
        }
        case 2: {
            //主要价格带
            
            CGFindPriceModel *model;
            if(self.priceArr.count) {
                model = [self.priceArr objectAtIndex:indexPath.row];
            }
            
            //创建“标题”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 25)];
            [lbMsg setText:model.name];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT15];
            [cell.contentView addSubview:lbMsg];
            
            //创建“内容”
            UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH-120, 25)];
            [lbMsg2 setText:[NSString stringWithFormat:@"%@-%@",model.min_price,model.max_price]];
            [lbMsg2 setTextColor:COLOR3];
            [lbMsg2 setTextAlignment:NSTextAlignmentRight];
            [lbMsg2 setFont:FONT15];
            [cell.contentView addSubview:lbMsg2];
            
            //创建“分割线”
            if(indexPath.row<[self.priceArr count]-1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
                [lineView setBackgroundColor:LINE_COLOR];
                [cell.contentView addSubview:lineView];
            }
            
            break;
        }
        case 3: {
            //主要竞争对手
            
            NSInteger itemNum = [self.competeArr count];
            NSInteger rowNum = itemNum/3;
            NSInteger colNum = itemNum%3;
            if(colNum>0) {
                rowNum += 1;
            }
            CGFloat tWidth = SCREEN_WIDTH/3;
            for (int i=0; i<rowNum; i++) {
                for (int k=0; k<3; k++) {
                    int tIndex = 3*i+k;
                    if(tIndex>itemNum-1) continue;
                    
                    CGFindCompeteModel *model;
                    if(self.competeArr.count) {
                        model = [self.competeArr objectAtIndex:tIndex];
                    }
                    if(!model) continue;
                    
                    //创建“背景层”
                    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(tWidth*k, 90*i, tWidth-1, 89)];
                    [cell.contentView addSubview:btnFunc];
                    
                    //创建“头像”
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-45)/2, 0, 45, 45)];
                    [imgView setContentMode:UIViewContentModeScaleAspectFill];
                    [imgView setClipsToBounds:YES];
                    [imgView.layer setCornerRadius:2.0];
                    [imgView.layer setMasksToBounds:YES];
                    [imgView.layer setBorderWidth:0.5];
                    [imgView.layer setBorderColor:LINE_COLOR.CGColor];
                    [imgView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
                    [btnFunc addSubview:imgView];
                    
                    //创建“标题”
                    NSString *nameStr = model.name;
                    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, tWidth-20, 35)];
                    [lbMsg setText:nameStr];
                    [lbMsg setTextColor:COLOR3];
                    [lbMsg setTextAlignment:NSTextAlignmentCenter];
                    [lbMsg setFont:FONT13];
                    [lbMsg setNumberOfLines:2];
                    if(!IsStringEmpty(nameStr)) {
                        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:nameStr];
                        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                        [style setLineSpacing:5.0f];
                        [style setAlignment:NSTextAlignmentCenter];
                        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, nameStr.length)];
                        [lbMsg setAttributedText:attStr];
                    }
                    [btnFunc addSubview:lbMsg];
                    
                }
            }
            
            break;
        }
        case 4: {
            //开店硬性条件参考标准
            
            static NSString *cellIndentifier = @"CGFindScrollViewCell";
            CGFindScrollViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[CGFindScrollViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier hardwareArr:self.hardwareArr];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //cell.delegate = self;
            return cell;
            
            break;
        }
        case 5: {
            //该公司旗下其他品牌
            
            NSInteger itemNum = [self.brandArr count];
            NSInteger rowNum = itemNum/3;
            NSInteger colNum = itemNum%3;
            if(colNum>0) {
                rowNum += 1;
            }
            CGFloat tWidth = SCREEN_WIDTH/3;
            for (int i=0; i<rowNum; i++) {
                for (int k=0; k<3; k++) {
                    int tIndex = 3*i+k;
                    if(tIndex>itemNum-1) continue;
                    
                    CGFindModel *model;
                    if(self.brandArr.count) {
                        model = [self.brandArr objectAtIndex:tIndex];
                    }
                    if(!model) continue;
                    
                    //创建“背景层”
                    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(tWidth*k, 90*i, tWidth-1, 89)];
                    [cell.contentView addSubview:btnFunc];
                    
                    //创建“头像”
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-45)/2, 0, 45, 45)];
                    [imgView setContentMode:UIViewContentModeScaleAspectFill];
                    [imgView setClipsToBounds:YES];
                    [imgView.layer setCornerRadius:2.0];
                    [imgView.layer setMasksToBounds:YES];
                    [imgView.layer setBorderWidth:0.5];
                    [imgView.layer setBorderColor:LINE_COLOR.CGColor];
                    [imgView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
                    [btnFunc addSubview:imgView];
                    
                    //创建“标题”
                    NSString *nameStr = model.name;
                    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, tWidth-20, 35)];
                    [lbMsg setText:nameStr];
                    [lbMsg setTextColor:COLOR3];
                    [lbMsg setTextAlignment:NSTextAlignmentCenter];
                    [lbMsg setFont:FONT13];
                    [lbMsg setNumberOfLines:2];
                    if(!IsStringEmpty(nameStr)) {
                        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:nameStr];
                        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                        [style setLineSpacing:5.0f];
                        [style setAlignment:NSTextAlignmentCenter];
                        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, nameStr.length)];
                        [lbMsg setAttributedText:attStr];
                    }
                    [btnFunc addSubview:lbMsg];
                }
            }
            
            break;
        }
            
            
        default:
            break;
    }
    
    return cell;
}


/**
 *  获取数据信息
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"depot" forKey:@"app"];
    [param setValue:@"getDetail" forKey:@"act"];
    [param setValue:self.find_id forKey:@"id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            NSLog(@"结果:%@",dataDic);
            
            //品牌详情
            findModel = [CGFindModel mj_objectWithKeyValues:dataDic[@"info"]];
            
            //竞争对手
            self.competeArr = [CGFindCompeteModel mj_objectArrayWithKeyValuesArray:dataDic[@"compete_list"]];
            
            //其他品牌
            self.brandArr = [CGFindModel mj_objectArrayWithKeyValuesArray:dataDic[@"other_brand"]];
            
            //价格带
            self.priceArr = [CGFindPriceModel mj_objectArrayWithKeyValuesArray:dataDic[@"price"]];
            
            //硬件条件
            self.hardwareArr = [dataDic objectForKey:@"hardware_list"];
            
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
