//
//  CGMineFormatViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineFormatViewController.h"

@interface CGMineFormatViewController ()

@end

@implementation CGMineFormatViewController

- (void)viewDidLoad {
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"业态管理";
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return self.dataArr.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==1) {
        return 65;
    }
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            
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
            
            break;
        }
        case 1: {
            //新建业态
            
            static NSString *cellIndentifier = @"CGMineFormatViewControllerCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            for (UIView *view in cell.contentView.subviews) {
                [view removeFromSuperview];
            }
            
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH-20, 45)];
            [btnFunc setTitle:@"新增业态" forState:UIControlStateNormal];
            [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT17];
            [btnFunc setBackgroundColor:MAIN_COLOR];
            [btnFunc.layer setCornerRadius:4.0];
            [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnFunc];
            
            return cell;
            
            break;
        }
            
        default:
            break;
    }
    return [UITableViewCell new];
}

/**
 *  业态管理委托代理
 */
- (void)CGMineFormatCellClick:(CGFormatModel *)model tIndex:(NSInteger)tIndex indexPath:(NSIndexPath *)indexPath {
    NSLog(@"业态管理委托代理");
    
    switch (tIndex) {
        case 0: {
            //编辑
            
            CGMineFormatEditPopupView *popupView = [[CGMineFormatEditPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 300, 175) titleStr:@"编辑业态" contentStr:model.name];
            popupView.callBack = ^(NSInteger tIndex, NSString *content) {
                NSLog(@"编辑、添加业态回调成功:%zd-%@",tIndex,content);
                [self.popup dismiss:YES];
                
                if(tIndex==0) return ;
                
                //项目ID验证
                if(IsStringEmpty(self.pro_id)) {
                    [MBProgressHUD showError:@"项目ID不能为空" toView:self.view];
                    return ;
                }
                
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"ucenter" forKey:@"app"];
                [param setValue:@"setCate" forKey:@"act"];
                [param setValue:self.pro_id forKey:@"pro_id"];
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
                    NSString *msg = [json objectForKey:@"msg"];
                    NSString *code = [json objectForKey:@"code"];
                    if([code isEqualToString:SUCCESS]) {
                        
                        [self.dataArr removeObject:model];
                        
                        //静态刷新
                        [self.tableView beginUpdates];
                        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                        [self.tableView reloadData];
                        
                        //延迟一秒返回
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [MBProgressHUD showSuccess:@"删除成功" toView:self.view];
                        });
                    }else{
                        [MBProgressHUD showError:msg toView:self.view];
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
 *  新增业态
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"新增业态");
    
    CGMineFormatEditPopupView *popupView = [[CGMineFormatEditPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 300, 175) titleStr:@"新增业态" contentStr:@""];
    popupView.callBack = ^(NSInteger tIndex, NSString *content)
    {
        NSLog(@"编辑、添加业态回调成功:%zd-%@",tIndex,content);
        [self.popup dismiss:YES];
        
        if (tIndex ==0) return ;
        
        //项目ID验证
        if(IsStringEmpty(self.pro_id)) {
            [MBProgressHUD showError:@"项目ID不能为空" toView:self.view];
            return ;
        }
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:@"ucenter" forKey:@"app"];
        [param setValue:@"setCate" forKey:@"act"];
        [param setValue:self.pro_id forKey:@"pro_id"];
        [param setValue:content forKey:@"name"];
        [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
            NSString *code = [json objectForKey:@"code"];
            if([code isEqualToString:SUCCESS])
            {
                NSDictionary *dataDic = [json objectForKey:@"data"];
                CGFormatModel *model = [CGFormatModel mj_objectWithKeyValues:dataDic];
                [self.dataArr insertObject:model atIndex:0];
                
                //静态加入数据
                if(self.dataArr.count<=1)
                {
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
            else
            {
                [MBProgressHUD showError:json[@"msg"] toView:self.view];
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
    [param setValue:@"getProInfo" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [param setValue:@"5" forKey:@"type"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if([dataDic isKindOfClass:[NSDictionary class]]) {
                NSArray *dataList = [dataDic objectForKey:@"list"];
                self.dataArr = [CGFormatModel mj_objectArrayWithKeyValuesArray:dataList];
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
