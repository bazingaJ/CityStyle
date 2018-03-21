//
//  CGLeaseMattersDetailViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLeaseMattersDetailViewController.h"
#import "CGLeaseMattersModel.h"
#import "ZLPhotoPickerBrowserViewController.h"
@interface CGLeaseMattersDetailViewController () {
    NSMutableArray *titleArr;
    
    //招租事情对象
    CGLeaseMattersModel *leaseInfo;
}

@end

@implementation CGLeaseMattersDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"事项详情";
    
    //设置数据源
    //备注：标题/描述/是否必填/是否可编辑/索引值
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"客户名称",@"0",@"0"]];
    [titleArr addObject:@[@"联系人",@"1",@"1"]];
    [titleArr addObject:@[@"合作意向",@"0",@"2"]];
    [titleArr addObject:@[@"意向铺位",@"0",@"3"]];
    [titleArr addObject:@[@"时间",@"0",@"4"]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(!leaseInfo) return 0;
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
            //详情描述
            return leaseInfo.cellH;
            
            break;
        case 2: {
            //附件
            
            NSInteger imgNum = leaseInfo.images.count;
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
    static NSString *cellIndentifier = @"CGLeaseMattersDetailViewControllerCell";
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
            
            NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
            
            //创建“标题”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
            [lbMsg setText:itemArr[0]];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT16];
            [cell.contentView addSubview:lbMsg];
            
            //创建“内容”
            UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH-150, 25)];
            [lbMsg2 setTextColor:COLOR3];
            [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
            [lbMsg2 setFont:FONT16];
            [cell.contentView addSubview:lbMsg2];
            
            switch ([itemArr[2] integerValue]) {
                case 0: {
                    //客户名称
                    [lbMsg2 setText:leaseInfo.cust_name];
                    
                    break;
                }
                case 1: {
                    //联系人
                    [lbMsg2 setText:leaseInfo.linkman_name];
                    
                    break;
                }
                case 2: {
                    //合作意向
                    
                    NSString *intentStr = @"0%";
                    if(!IsStringEmpty(leaseInfo.intent)) {
                        intentStr = [[NSString stringWithFormat:@"%@",leaseInfo.intent] stringByAppendingString:@"%"];
                    }
                    [lbMsg2 setText:[NSString stringWithFormat:@"%@(%@)",intentStr,leaseInfo.intent_name]];
                    
                    break;
                }
                case 3: {
                    //意向铺位
                    [lbMsg2 setText:leaseInfo.pos_name];
                    
                    break;
                }
                case 4: {
                    //时间
                    [lbMsg2 setText:leaseInfo.time];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            
            if([itemArr[1] integerValue]==1) {
                //创建“拨打电话”
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 12.5, 20, 20)];
                [btnFunc setImage:[UIImage imageNamed:@"tel_icon_blue"] forState:UIControlStateNormal];
                [btnFunc addTouch:^{
                    NSLog(@"拨打电话");
                    
                    NSString *telStr = leaseInfo.linkman_mobile;
                    if(IsStringEmpty(telStr)) {
                        [MBProgressHUD showError:@"暂无电话" toView:self.view];
                        return ;
                    }
                    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel://%@",telStr];
                    UIWebView *callWebView = [[UIWebView alloc] init];
                    [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                    [cell.contentView addSubview:callWebView];
                    
                }];
                [cell.contentView addSubview:btnFunc];
            }
            
            //创建“分割线”
            if(indexPath.row<[titleArr count]-1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 44.5, SCREEN_WIDTH-100, 0.5)];
                [lineView setBackgroundColor:LINE_COLOR];
                [cell.contentView addSubview:lineView];
            }
            
            break;
        }
        case 1: {
            //详情
            
            NSString *introStr = leaseInfo.intro;
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, leaseInfo.cellH-20)];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT16];
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
        case 2: {
            //附件
            
            NSInteger imgNum = leaseInfo.images.count;
            NSMutableArray *imgArr = [NSMutableArray array];
            [imgArr removeAllObjects];
            for (NSInteger i=0; i<imgNum; i++) {
                NSString *imgURL = leaseInfo.images[i];
                
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (i%3)*(pictureHW+10), 10 +(i/3)*(pictureHW+10), pictureHW, pictureHW)];
                [imgView setContentMode:UIViewContentModeScaleAspectFill];
                [imgView setClipsToBounds:YES];
                [imgView.layer setCornerRadius:4.0];
                imgView.userInteractionEnabled =YES;
                [imgView.layer setMasksToBounds:YES];
                imgView.tag = 10;
                [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
                [imgView setUserInteractionEnabled:YES];
                [cell.contentView addSubview:imgView];
                
                ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
                photo.photoURL = [NSURL URLWithString:imgURL];
                [imgArr addObject:photo];
                [imgView addTouch:^{
                    //点击头像放大
                    
                    // 图片游览器
                    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
                    // 淡入淡出效果
                    pickerBrowser.status = UIViewAnimationAnimationStatusFade;
                    // 数据源/delegate
                    pickerBrowser.photos = imgArr;
                    // 能够删除
                    pickerBrowser.delegate = self;
                    // 当前选中的值
                    pickerBrowser.currentIndex = imgView.tag -10;
                    // 展示控制器
                    [pickerBrowser showPickerVc:self];
                }];
            }
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"getIntentDetailInfo" forKey:@"act"];
    [param setValue:self.lease_id forKey:@"id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            leaseInfo = [CGLeaseMattersModel mj_objectWithKeyValues:dataDic];
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
