//
//  CGCustomerInfoViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/21.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGCustomerInfoViewController.h"
#import "CGCustomerInfoEditViewController.h"
#import "CGCustomerModel.h"

@interface CGCustomerInfoViewController () {
    NSMutableDictionary *titleDic;
    
    //物业
    NSMutableArray *imgArr;
    
    //客户对象
    CGCustomerModel *customerModel;
}

@end

@implementation CGCustomerInfoViewController

- (void)viewDidLoad {
    [self setRightButtonItemTitle:@"编辑"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置数据源
    //备注：标题/索引
    titleDic = [NSMutableDictionary dictionary];
    
    //第一区块
    NSMutableArray *titleArr1 = [NSMutableArray array];
    [titleArr1 addObject:@[@"客户名称",@"100"]];
    [titleArr1 addObject:@[@"所属团队",@"101"]];
    [titleArr1 addObject:@[@"经营业态",@"102"]];
    [titleArr1 addObject:@[@"官网",@"103"]];
    [titleDic setValue:titleArr1 forKey:@"1"];
    
    //第二区块
    NSMutableArray *titleArr2 = [NSMutableArray array];
    [titleArr2 addObject:@[@"面积需求",@"200"]];
    [titleArr2 addObject:@[@"合作年限",@"201"]];
    [titleDic setValue:titleArr2 forKey:@"2"];
    
    //物业条件
    imgArr = [NSMutableArray array];
    [imgArr addObject:@[@"bunk_huo_normal",@"bunk_huo_selected",@"可明火",@"1"]];
    [imgArr addObject:@[@"bunk_tianranqi_normal",@"bunk_tianranqi_selected",@"天然气管道",@"2"]];
    [imgArr addObject:@[@"bunk_meiqi_normal",@"bunk_meiqi_selected",@"煤气罐",@"3"]];
    [imgArr addObject:@[@"bunk_dianya_normal",@"bunk_dianya_selected",@"380伏",@"4"]];
    [imgArr addObject:@[@"bunk_shangshui_normal",@"bunk_shangshui_selected",@"上水",@"5"]];
    [imgArr addObject:@[@"bunk_xiashui_normal",@"bunk_xiashui_selected",@"下水",@"6"]];
    [imgArr addObject:@[@"bunk_yanguan_normal",@"bunk_yanguan_selected",@"烟管道",@"7"]];
    [imgArr addObject:@[@"bunk_guandao_normal",@"bunk_guandao_selected",@"排污管道",@"8"]];
    [imgArr addObject:@[@"bunk_park_normal",@"bunk_park_selected",@"停车位",@"9"]];
    [imgArr addObject:@[@"bunk_waibai_normal",@"bunk_waibai_selected",@"外摆区",@"10"]];
    
}

/**
 *  编辑按钮事件
 */
- (void)rightButtonItemClick {
    NSLog(@"编辑");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGCustomerInfoEditViewController *editView = [[CGCustomerInfoEditViewController alloc] init];
    editView.customerModel = customerModel;
    editView.callBack = ^(CGCustomerModel *customerInfo) {
        NSLog(@"编辑名片回调成功");
        
        customerModel = customerInfo;
        
        [self.tableView reloadData];
        
    };
    [self.navigationController pushViewController:editView animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(!customerModel) return 0;
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0 || section==3) {
        return 1;
    }else{
        NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",section]];
        return [titleArr count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section>=2) {
        return 35;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0) {
        return 70;
    }else if(indexPath.section==3) {
        return 200;
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
        [lbMsg setText:@"拓展计划"];
    }else if(section==3) {
        [lbMsg setText:@"物业条件"];
    }
    [lbMsg setTextColor:COLOR9];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGCustomerInfoViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if(indexPath.section==0) {
        //头像
        
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
        
    }else if(indexPath.section==3) {
        //物业条件
        
        NSInteger itemNum = [imgArr count];
        CGFloat tWidth = (SCREEN_WIDTH-20)/5;
        for (int i=0; i<2; i++) {
            for (int k=0; k<5; k++) {
                NSInteger tIndex = 5*i+k;
                if(tIndex>itemNum-1) continue;
                
                NSArray *itemArr = [imgArr objectAtIndex:tIndex];
                
                BOOL isContain = [customerModel.propertyArr containsObject:itemArr[3]];
                
                //创建“背景层”
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10+tWidth*k, 100*i, tWidth-1, 99)];
                [btnFunc setTag:tIndex];
                [btnFunc setSelected:isContain];
                [cell.contentView addSubview:btnFunc];
                
                UIImage *img = nil;
                if(isContain) {
                    img = [UIImage imageNamed:itemArr[1]];
                }else{
                    img = [UIImage imageNamed:itemArr[0]];
                }
                CGFloat tW = img.size.width;
                CGFloat tH = img.size.height;
                
                //创建“图标”
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-tW)/2, 20, tW, tH)];
                [imgView setImage:img];
                [btnFunc addSubview:imgView];
                
                //创建“标题”
                UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, tWidth, 20)];
                [lbMsg setText:itemArr[2]];
                if(isContain) {
                    [lbMsg setTextColor:RED_COLOR];
                }else{
                    [lbMsg setTextColor:COLOR9];
                }
                [lbMsg setTextAlignment:NSTextAlignmentCenter];
                [lbMsg setFont:FONT13];
                [btnFunc addSubview:lbMsg];
                
            }
        }
        
    }else{
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
        
        //创建“内容”
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH-120, 25)];
        [lbMsg2 setTextColor:COLOR3];
        [lbMsg2 setTextAlignment:NSTextAlignmentRight];
        [lbMsg2 setFont:FONT16];
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
                //经营业态
                [lbMsg2 setText:customerModel.cate_name];
                
                break;
            }
            case 103: {
                //官网
                [lbMsg2 setText:customerModel.website];
                
                break;
            }
            case 200: {
                //面积需求
                NSString *needStr = @"0";
                if(!IsStringEmpty(customerModel.need_area)) {
                    needStr = customerModel.need_area;
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"%@m²",needStr]];
                
                break;
            }
            case 201: {
                //合作年限
                NSString *yearStr = @"0";
                if(!IsStringEmpty(customerModel.years)) {
                    yearStr = customerModel.years;
                }
                [lbMsg2 setText:[NSString stringWithFormat:@"%@年",yearStr]];
                
                break;
            }
                
            default:
                break;
        }
        
        
        //创建“分割线”
        if(indexPath.row<[titleArr count]-1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
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
    [param setValue:@"getCustInfo" forKey:@"act"];
    [param setValue:self.cust_id forKey:@"cust_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            customerModel = [CGCustomerModel mj_objectWithKeyValues:dataDic];
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
