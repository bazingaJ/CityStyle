//
//  CGMineMessageUpcomingViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineMessageUpcomingViewController.h"
#import "CGMineMessageUpcomingCell.h"
#import "CGMineMessageUpcomingDetailViewController.h"
#import "CGNotifyBacklogDetailsViewController.h"

@interface CGMineMessageUpcomingViewController ()

@end

@implementation CGMineMessageUpcomingViewController

- (void)viewDidLoad {
    [self setBottomH:40];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    
    self.title = @"待办";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGMineMessageUpcomingCell";
    CGMineMessageUpcomingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGMineMessageUpcomingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGMineMessageUpcomingModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setRightUtilityButtons:[self rightButtons:model] WithButtonWidth:80];
    [cell setDelegate:self];
    [cell setMineMessageUpcomingModel:model indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CGMineMessageUpcomingModel *model;
    if(self.dataArr.count)
    {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if (!model) return;
    
    CGNotifyBacklogDetailsViewController * notifyBacklogDetailsView = [[CGNotifyBacklogDetailsViewController alloc]init];
    notifyBacklogDetailsView.toDo_id = model.id;
    notifyBacklogDetailsView.is_do = model.is_do;
    [self.navigationController pushViewController:notifyBacklogDetailsView animated:YES];
}

- (NSArray *)rightButtons:(CGMineMessageUpcomingModel *)model
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    //设置已办按钮
    if([model.is_do isEqualToString:@"2"]) {
        UIButton *btnFunc2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnFunc2 setTitle:@"已办" forState:UIControlStateNormal];
        [btnFunc2 setTitleColor:COLOR3 forState:UIControlStateNormal];
        [btnFunc2.titleLabel setFont:FONT13];
        [btnFunc2 setBackgroundColor:LINE_COLOR];
        [btnFunc2 setImage:[UIImage imageNamed:@"mine_icon_yiban"] forState:UIControlStateNormal];
        [btnFunc2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btnFunc2 setTitleEdgeInsets:UIEdgeInsetsMake(btnFunc2.imageView.frame.size.height+40 ,-btnFunc2.imageView.frame.size.width-25, 0, 0)];
        //图片距离右边框距离减少图片的宽度，其它不边
        [btnFunc2 setImageEdgeInsets:UIEdgeInsetsMake(-20, 0,0, -btnFunc2.titleLabel.bounds.size.width)];
        [btnFunc2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [rightUtilityButtons addObject:btnFunc2];
    }
    
    //设置删除按钮
    UIButton *btnFunc = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFunc setTitle:@"删除" forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT13];
    [btnFunc setBackgroundColor:GRAY_COLOR];
    [btnFunc setImage:[UIImage imageNamed:@"delete_icon_small"] forState:UIControlStateNormal];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(btnFunc.imageView.frame.size.height+40 ,-btnFunc.imageView.frame.size.width-25, 0, 0)];
    //图片距离右边框距离减少图片的宽度，其它不边
    [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(-20, 0,0, -btnFunc.titleLabel.bounds.size.width)];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [rightUtilityButtons addObject:btnFunc];
    
    return rightUtilityButtons;
}

/**
 *  滑动删除委托代理
 */
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSLog(@"滑动删除委托代理");
    
    CGMineMessageUpcomingCell *tCell = (CGMineMessageUpcomingCell *)cell;
    NSIndexPath *indexPath = tCell.indexPath;
    
    CGMineMessageUpcomingModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    
    switch (index) {
        case 0: {
            //已办
            
            if([model.is_do isEqualToString:@"1"]) {
                //已办
                
                [self deleteToDo:model indexPath:indexPath];
                
            }else{
                //未办
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"ucenter" forKey:@"app"];
                [param setValue:@"setListDo" forKey:@"act"];
                [param setValue:model.id forKey:@"id"];
                [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
                [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                    NSString *code = [json objectForKey:@"code"];
                    if([code isEqualToString:SUCCESS]) {
                        
                        model.is_do = @"1";
                        
                        //刷新
                        [self.tableView beginUpdates];
                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                        //延迟1秒退出
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [MBProgressHUD showSuccess:@"设置成功" toView:self.view];
                        });
                        
                    }
                } failure:^(NSError *error) {
                    NSLog(@"%@",[error description]);
                }];
            }
            
            break;
        }
        case 1: {
            //删除
            
            [self deleteToDo:model indexPath:indexPath];
            
            break;
        }
            
        default:
            break;
    }
    
}

/**
 *  删除
 */
- (void)deleteToDo:(CGMineMessageUpcomingModel *)model indexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"dropList" forKey:@"act"];
    [param setValue:model.id forKey:@"id"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            
            [self.dataArr removeObject:model];
            
//            //移除
//            [self.tableView beginUpdates];
//            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//            [self.tableView endUpdates];
            
            [self.tableView.mj_header beginRefreshing];
            
            //延迟1秒退出
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"删除成功" toView:self.view];
            });
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
}

/**
 *  获取消息数据
 */
- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getMyToDoList" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[CGMineMessageUpcomingModel mj_objectWithKeyValues:itemDic]];
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
