//
//  CGMineTeamCustomerFormatViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamCustomerFormatViewController.h"
#import "CGMineFormatViewController.h"

@interface CGMineTeamCustomerFormatViewController () {
    //项目ID
    NSString *pro_id;
}

@end

@implementation CGMineTeamCustomerFormatViewController

- (void)viewDidLoad {
    [self setBottomH:90];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-90, SCREEN_WIDTH, 45)];
    [btnFunc setTitle:@"新增储备客户业态" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

/**
 *  刷新客户列表
 */
- (void)reloadCustomerList {
    [self.tableView.mj_header beginRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    [backView setBackgroundColor:BACK_COLOR];
    
    //创建“我的储备客户业态”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, backView.frame.size.width-20, 25)];
    [lbMsg setText:@"我的储备客户业态"];
    [lbMsg setTextColor:COLOR9];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGMineFormatCell";
    CGMineFormatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGMineFormatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFormatModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setDelegate:self];
    [cell setMineFormatModel:model indexPath:indexPath];
    
    return cell;
}

/**
 *  储备客户功能按钮委托代理
 */
- (void)CGMineFormatCellClick:(CGFormatModel *)model tIndex:(NSInteger)tIndex indexPath:(NSIndexPath *)indexPath {
    NSLog(@"储备客户功能按钮委托代理");
    
    switch (tIndex) {
        case 0: {
            //编辑
            
            CGMineFormatEditPopupView *popupView = [[CGMineFormatEditPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 300, 175) titleStr:@"编辑业态" contentStr:model.name];
            popupView.callBack = ^(NSInteger tIndex, NSString *content) {
                NSLog(@"编辑、添加业态回调成功:%zd-%@",tIndex,content);
                [self.popup dismiss:YES];
                
                if(tIndex==0) return ;
                
                //项目ID验证
                if(IsStringEmpty(pro_id)) {
                    [MBProgressHUD showError:@"项目ID不能为空" toView:self.view];
                    return ;
                }
                
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"ucenter" forKey:@"app"];
                [param setValue:@"setCate" forKey:@"act"];
                [param setValue:pro_id forKey:@"pro_id"];
                [param setValue:model.id forKey:@"cate_id"];
                [param setValue:content forKey:@"name"];
                [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                    NSString *code = [json objectForKey:@"code"];
                    if([code isEqualToString:SUCCESS]) {
                        NSDictionary *dataDic = [json objectForKey:@"data"];
                        CGFormatModel *newModel = [CGFormatModel mj_objectWithKeyValues:dataDic];
                        model.name = newModel.name;
                        
                        //静态加入数据
                        [self.tableView beginUpdates];
                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                        //延迟一秒返回
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [MBProgressHUD showSuccess:@"编辑成功" toView:self.view];
                        });
                        
                    }
                } failure:^(NSError *error) {
                    NSLog(@"%@",[error description]);
                }];
                
            };
            self.popup = [KLCPopup popupWithContentView:popupView
                                               showType:KLCPopupShowTypeGrowIn
                                            dismissType:KLCPopupDismissTypeGrowOut
                                               maskType:KLCPopupMaskTypeDimmed
                               dismissOnBackgroundTouch:NO
                                  dismissOnContentTouch:NO];
            [self.popup show];
            
            break;
        }
        case 1: {
            //删除
            
            UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"警告" message:@"您确定要删除吗?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"删除");
                
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"ucenter" forKey:@"app"];
                [param setValue:@"dropCate" forKey:@"act"];
                [param setValue:model.id forKey:@"cate_id"];
                [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                    NSString *code = [json objectForKey:@"code"];
                    if([code isEqualToString:SUCCESS]) {
                        
                        [self.dataArr removeObject:model];
                        
                        //静态刷新
                        [self.tableView beginUpdates];
                        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                        //延迟一秒返回
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [MBProgressHUD showSuccess:@"删除成功" toView:self.view];
                        });
                    }
                } failure:^(NSError *error) {
                    NSLog(@"%@",[error description]);
                }];
                
            }];
            [aler addAction:cancelAction];
            [aler addAction:okAction];
            [self presentViewController:aler animated:YES completion:nil];
            
            break;
        }
            
        default:
            break;
    }
    
}

/**
 *  新增储备客户业态按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"新增储备客户业态");
    
    CGMineFormatEditPopupView *popupView = [[CGMineFormatEditPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 300, 175) titleStr:@"添加业态" contentStr:@""];
    popupView.callBack = ^(NSInteger tIndex, NSString *content) {
        NSLog(@"编辑、添加业态回调成功:%zd-%@",tIndex,content);
        [self.popup dismiss:YES];
        
        //项目ID验证
        if(IsStringEmpty(pro_id)) {
            [MBProgressHUD showError:@"项目ID不能为空" toView:self.view];
            return ;
        }
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:@"ucenter" forKey:@"app"];
        [param setValue:@"setCate" forKey:@"act"];
        [param setValue:pro_id forKey:@"pro_id"];
        [param setValue:content forKey:@"name"];
        [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
            NSString *code = [json objectForKey:@"code"];
            if([code isEqualToString:SUCCESS]) {
                NSDictionary *dataDic = [json objectForKey:@"data"];
                CGFormatModel *model = [CGFormatModel mj_objectWithKeyValues:dataDic];
                [self.dataArr insertObject:model atIndex:0];
                
                //静态加入数据
                if(self.dataArr.count<=1) {
                    [self.tableView reloadData];
                }else{
                    [self.tableView beginUpdates];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    [self.tableView endUpdates];
                }
                
                //延迟一秒返回
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD showSuccess:@"添加成功" toView:self.view];
                });
                
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",[error description]);
        }];
        
    };
    self.popup = [KLCPopup popupWithContentView:popupView
                                       showType:KLCPopupShowTypeGrowIn
                                    dismissType:KLCPopupDismissTypeGrowOut
                                       maskType:KLCPopupMaskTypeDimmed
                       dismissOnBackgroundTouch:NO
                          dismissOnContentTouch:NO];
    [self.popup show];
    
}

/**
 *  获取数据源
 */
- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getTrunkCateList" forKey:@"act"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if([dataDic isKindOfClass:[NSDictionary class]]) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                if([dataArr isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *itemDic in dataArr) {
                        [self.dataArr addObject:[CGFormatModel mj_objectWithKeyValues:itemDic]];
                    }
                }
                
                //项目ID
                pro_id = [dataDic objectForKey:@"pro_id"];
                
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
