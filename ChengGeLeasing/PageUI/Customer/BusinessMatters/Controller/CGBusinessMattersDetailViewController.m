//
//  CGBusinessMattersDetailViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGBusinessMattersDetailViewController.h"
#import "CGBusinessMattersModel.h"
#import "ZLPhotoPickerBrowserViewController.h"

@interface CGBusinessMattersDetailViewController () {
    NSArray *titleArr;
    
    //经营事项对象
    CGBusinessMattersModel *businessModel;
}
@end

@implementation CGBusinessMattersDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"经营事项";
    
    //设置数据源
    titleArr = @[@"联系人姓名",@"经营状态",@"时间"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(!businessModel) return 0;
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==1) {
        return [titleArr count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section>=2) {
        return 35;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            //当前客户
            return 70;
            
            break;
        case 1:
            //基本信息
            return 45;
            
            break;
        case 2:
            //事项详情
            return businessModel.cellH;
            
            break;
        case 3: {
            //附件
            NSInteger imgNum = businessModel.images.count;
            NSInteger rowNum = 0;
            if(imgNum>0) {
                rowNum = imgNum/3;
                NSInteger colNum = imgNum%3;
                if(colNum>0) {
                    rowNum += 1;
                }
            }else{
                rowNum  =1;
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
    
    //创建“事项记录”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-20, 35)];
    if(section==2) {
        [lbMsg setText:@"事项记录"];
    }else if(section==3) {
        [lbMsg setText:@"附件"];
    }
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGBusinessMattersDetailViewControllerCell";
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
            //项目信息
            
            //创建“标题”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, SCREEN_WIDTH-70, 20)];
            [lbMsg setText:businessModel.cust_name];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT16];
            [cell.contentView addSubview:lbMsg];
            
            //创建“首字母”
            UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 10, 50, 50)];
            [lbMsg2.layer setCornerRadius:4];
            [lbMsg2.layer setMasksToBounds:YES];
            [lbMsg2 setBackgroundColor:MAIN_COLOR];
            [lbMsg2 setText:businessModel.cust_first_letter];
            [lbMsg2 setTextColor:[UIColor whiteColor]];
            [lbMsg2 setTextAlignment:NSTextAlignmentCenter];
            [lbMsg2 setFont:FONT24];
            [cell.contentView addSubview:lbMsg2];
            
            //创建“分割线”
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 69.5, SCREEN_WIDTH-100, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
            
            break;
        }
        case 1: {
            //联系人信息
            
            //创建“标题”
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 85, 25)];
            [lbMsg setText:[titleArr objectAtIndex:indexPath.row]];
            [lbMsg setTextColor:COLOR3];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT15];
            [cell.contentView addSubview:lbMsg];
            
            //创建“内容”
            UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH-150, 25)];
            [lbMsg2 setTextColor:COLOR3];
            [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
            [lbMsg2 setFont:FONT16];
            [cell.contentView addSubview:lbMsg2];
            
            switch (indexPath.row) {
                case 0: {
                    //联系人姓名
                    [lbMsg2 setText:businessModel.linkman_name];
                    
                    break;
                }
                case 1: {
                    //经营状态
                    [lbMsg2 setText:businessModel.status_name];
                    
                    break;
                }
                case 2: {
                    //时间
                    [lbMsg2 setText:businessModel.add_date];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            //创建“分割线”
            if(indexPath.row<2) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 44.5, SCREEN_WIDTH-100, 0.5)];
                [lineView setBackgroundColor:LINE_COLOR];
                [cell.contentView addSubview:lineView];
            }
            
            break;
        }
        case 2: {
            //事项记录
            
            //创建“描述”
            NSString *introStr = businessModel.intro;
            UILabel *lbMsg6 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, businessModel.cellH-20)];
            [lbMsg6 setTextColor:COLOR9];
            [lbMsg6 setTextAlignment:NSTextAlignmentLeft];
            [lbMsg6 setFont:FONT14];
            [lbMsg6 setNumberOfLines:0];
            if(!IsStringEmpty(introStr)) {
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:introStr];
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:5.0f];
                [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, introStr.length)];
                [lbMsg6 setAttributedText:attStr];
            }
            [cell.contentView addSubview:lbMsg6];
            
            break;
        }
        case 3: {
            //附件
            
            NSInteger imgNum = businessModel.images.count;
            
            NSMutableArray *imgArr = [NSMutableArray array];
            [imgArr removeAllObjects];
            
            for (NSInteger i=0; i<imgNum; i++)
            {
                NSString *imgURL = businessModel.images[i];
                
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (i%3)*(pictureHW+10), 10 +(i/3)*(pictureHW+10), pictureHW, pictureHW)];
                [imgView setContentMode:UIViewContentModeScaleAspectFill];
                [imgView setClipsToBounds:YES];
                [imgView.layer setCornerRadius:4.0];
                imgView.tag =10+i;
                [imgView.layer setMasksToBounds:YES];
                imgView.userInteractionEnabled =YES;
                [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
                [imgView setUserInteractionEnabled:YES];
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
                [cell.contentView addSubview:imgView];
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
    [param setValue:@"getOperateDetailInfo" forKey:@"act"];
    [param setValue:self.business_id forKey:@"id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            businessModel = [CGBusinessMattersModel mj_objectWithKeyValues:dataDic];
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
    }];
    
}

@end
