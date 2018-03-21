//
//  CGFindBrandContactViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/15.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGFindBrandContactViewController.h"
#import "CGFindLinkmanModel.h"

@interface CGFindBrandContactViewController () {
    NSMutableArray *titleArr;
}

@end

@implementation CGFindBrandContactViewController

- (void)viewDidLoad {
    [self setBottomH:115];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置数据源
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"联系人",@"0"]];
    [titleArr addObject:@[@"电话",@"1"]];
    [titleArr addObject:@[@"性别",@"0"]];
    [titleArr addObject:@[@"职位",@"0"]];
    [titleArr addObject:@[@"邮箱",@"0"]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [titleArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGFindBrandContactViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
    
    CGFindLinkmanModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 25)];
    [lbMsg setText:itemArr[0]];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [cell.contentView addSubview:lbMsg];
    
    //创建“内容”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, SCREEN_WIDTH-110, 25)];
    [lbMsg2 setTextColor:COLOR3];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT16];
    [cell.contentView addSubview:lbMsg2];
    
    switch (indexPath.row) {
        case 0: {
            //联系人
            [lbMsg2 setText:model.name];
            
            break;
        }
        case 1: {
            //电话
            [lbMsg2 setText:model.real_tel];
            
            //创建“电话”
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 12.5, 20, 20)];
            [btnFunc setImage:[UIImage imageNamed:@"tel_icon_orange"] forState:UIControlStateNormal];
            [btnFunc addTouch:^{
                NSLog(@"拨打电话");
                
                NSString *telStr = model.real_tel;
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
            
            break;
        }
        case 2: {
            //性别
            [lbMsg2 setText:model.sex_name];
            
            break;
        }
        case 3: {
            //职位
            [lbMsg2 setText:model.job];
            
            break;
        }
        case 4: {
            //邮箱
            [lbMsg2 setText:model.email];
            
            break;
        }
            
        default:
            break;
    }
    
    //创建“分割线”
    if(indexPath.row<[titleArr count]-1) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(80, 44.5, SCREEN_WIDTH-80, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [cell.contentView addSubview:lineView];
    }
    
    return cell;
}

/**
 *  获取数据信息
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"depot" forKey:@"app"];
    [param setValue:@"getLinkmanList" forKey:@"act"];
    [param setValue:self.find_id forKey:@"id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSArray *dataList = json[@"data"][@"contact_list"];
            self.dataArr = [CGFindLinkmanModel mj_objectArrayWithKeyValuesArray:dataList];
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
