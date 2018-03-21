//
//  CGLinkmanViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLinkmanViewController.h"
#import "CGLinkmanAddViewController.h"

@interface CGLinkmanViewController ()

@end

@implementation CGLinkmanViewController

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
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"联系人";
    
    if ([self.isMine isEqualToString:@"1"])
    {
        if (!self.isAllCust)
        {
            //创建“添加待办”按钮
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-90, SCREEN_WIDTH, 45)];
            [btnFunc setTitle:@"添加联系人" forState:UIControlStateNormal];
            [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT17];
            [btnFunc setImage:[UIImage imageNamed:@"customer_add_white"] forState:UIControlStateNormal];
            [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            [btnFunc setBackgroundColor:MAIN_COLOR];
            [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btnFunc];
        }
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0) {
        return 10;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGLinkmanModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    return model.cellH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
//    if (self.type ==4) return nil;
    
    if(section>0) return [UIView new];
    
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    [btnFunc setBackgroundColor:GRAY_COLOR];
    [btnFunc setTitle:[HelperManager CreateInstance].proName forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT14];
    [btnFunc setImage:[UIImage imageNamed:@"customer_icon_contact"] forState:UIControlStateNormal];
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    return btnFunc;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGLinkmanCell";
    CGLinkmanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGLinkmanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGLinkmanModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    [cell setDelegate:self];
    [cell setLinkmanModel:model indexPath:indexPath];
    
    return cell;
}

/**
 *  编辑客户委托代理
 */
- (void)CGLinkmanCellEditClick:(CGLinkmanModel *)model indexPath:(NSIndexPath *)indexPath {
    NSLog(@"编辑客户委托代理");
    if (self.isAllCust)
    {
        [MBProgressHUD showError:@"不允许编辑联系人" toView:self.view];
        return;
    }
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGLinkmanAddViewController *addView = [[CGLinkmanAddViewController alloc] init];
    addView.title = @"编辑联系人";
    addView.linkModel = model;
    addView.cust_id = self.cust_id;
    addView.callBack = ^{
        [self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:addView animated:YES];
    
}

/**
 *  添加联系人
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"添加联系人");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGLinkmanAddViewController *addView = [[CGLinkmanAddViewController alloc] init];
    addView.title = @"添加联系人";
    addView.cust_id = self.cust_id;
    addView.callBack = ^{
        [self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:addView animated:YES];
    
}

/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"getLinkmanList" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.cust_id forKey:@"cust_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[CGLinkmanModel mj_objectWithKeyValues:itemDic]];
                }
                
                //当前总数
                NSString *dataNum = [dataDic objectForKey:@"count"];
                if(!IsStringEmpty(dataNum)) {
                    self.totalNum = [dataNum intValue];
                }else{
                    self.totalNum = 0;
                }
            }
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
    }];
    
}



@end
