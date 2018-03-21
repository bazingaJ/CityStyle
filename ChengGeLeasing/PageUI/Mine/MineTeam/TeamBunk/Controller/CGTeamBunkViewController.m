//
//  CGTeamBunkViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGTeamBunkViewController.h"
#import "CGTeamBunkEditViewController.h"
#import "CGBunkAreaModel.h"

@interface CGTeamBunkViewController ()

@end

@implementation CGTeamBunkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"新增铺位";
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==self.dataArr.count) {
        return 1;
    }
    
    CGBunkAreaModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:section];
    }
    return model.pos_list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section<self.dataArr.count) {
        return 35;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==self.dataArr.count) {
        return 80;
    }
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section==self.dataArr.count) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    
    CGBunkAreaModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:section];
    }
    
    //创建“头标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-20, 35)];
    [lbMsg setText:model.name];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==[self.dataArr count]) {
        
        static NSString *cellIndentifier = @"CGTeamBunkViewControllerCell";
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
        [btnFunc setTitle:@"新增铺位" forState:UIControlStateNormal];
        [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT17];
        [btnFunc setBackgroundColor:MAIN_COLOR];
        [btnFunc.layer setCornerRadius:4.0];
        [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnFunc];
        
        return cell;
        
    }else{
        
        static NSString *cellIndentifier = @"CGTeamBunkCell";
        CGTeamBunkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[CGTeamBunkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }

        CGBunkAreaModel *areaModel;
        if(self.dataArr.count) {
            areaModel = [self.dataArr objectAtIndex:indexPath.section];
        }
        CGBunkModel *model;
        if(areaModel.pos_list.count) {
            model = [areaModel.pos_list objectAtIndex:indexPath.row];
        }
        [cell setDelegate:self];
        [cell setBunkModel:model indexPath:indexPath];

        return cell;
    }
}

/**
 *  铺位委托代理
 */
- (void)CGTeamBunkCellClick:(CGBunkModel *)model tIndex:(NSInteger)tIndex indexPath:(NSIndexPath *)indexPath {
    NSLog(@"铺位委托代理");
    
    switch (tIndex) {
        case 0: {
            //编辑铺位
            
            CGTeamBunkEditViewController *editView = [[CGTeamBunkEditViewController alloc] init];
            editView.pro_id = self.pro_id;
            editView.pos_id = model.pos_id;
            editView.callBack = ^{
                NSLog(@"新增铺位回调成功");
                
                [self.tableView.mj_header beginRefreshing];
                
            };
            [self.navigationController pushViewController:editView animated:YES];
            
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
                [param setValue:@"dropPos" forKey:@"act"];
                [param setValue:model.pos_id forKey:@"pro_id"];
                [param setValue:self.pro_id forKey:@"pos_id"];
                [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                    NSString *msg = [json objectForKey:@"msg"];
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
 *  新增铺位
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"新增铺位");
    
    CGTeamBunkEditViewController *editView = [[CGTeamBunkEditViewController alloc] init];
    editView.pro_id = self.pro_id;
    editView.callBack = ^{
        NSLog(@"新增铺位回调成功");
        
        [self.tableView.mj_header beginRefreshing];
        
    };
    [self.navigationController pushViewController:editView animated:YES];
    
}

/**
 *  获取数据列表
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getProInfo" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [param setValue:@"4" forKey:@"type"];
    [param setValue:@(self.pageIndex) forKey:@"page"];//预留
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if([dataDic isKindOfClass:[NSDictionary class]]) {
                NSArray *dataList = [dataDic objectForKey:@"list"];
                self.dataArr = [CGBunkAreaModel mj_objectArrayWithKeyValuesArray:dataList];
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
