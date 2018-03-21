
//
//  CGTeamMemberMobileAddViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGTeamMemberMobileAddViewController.h"
#import "CGTeamMemberModel.h"

@interface CGTeamMemberMobileAddViewController ()

@property (nonatomic, strong) CGMineSearchBarView *searchView;



@end

@implementation CGTeamMemberMobileAddViewController

/**
 *  懒加载搜索框
 */
- (CGMineSearchBarView *)searchView {
    if(!_searchView) {
        _searchView = [[CGMineSearchBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, 45)];
        [_searchView setDelegate:self];
        self.navigationItem.titleView = _searchView;
    }
    return _searchView;
}

/**
 *  已选择的数组
 */
//- (NSMutableArray *)selecteArr {
//    if(!_selecteArr) {
//        _selecteArr = [NSMutableArray array];
//    }
//    return _selecteArr;
//}

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    
    //创建“搜索框”
    [self searchView];
}

/**
 *  返回按钮事件
 */
- (void)leftButtonItemClick {
    [super leftButtonItemClick];
    [self.searchView.searchBar resignFirstResponder];
    
    //回调
    if(self.callBack)
    {
        self.callBack(self.selecteArr);
    }
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGMineTeamMemberMobileCell";
    CGMineTeamMemberMobileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGMineTeamMemberMobileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGTeamMemberModel *model;
    if(self.dataArr.count)
    {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setDelegate:self];
    cell.isAdd = self.isAdd;
    [cell setTeamMemberModel:model pro_id:self.pro_id];
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchView.searchBar resignFirstResponder];
}

/**
 *  搜索委托代理
 */
- (void)CGMineSearchBarViewClick:(NSString *)searchStr {
    NSLog(@"搜索委托代理");
    
    //获取数据源
    [self.dataArr removeAllObjects];
    
    //清空界面
    [self.tableView beginUpdates];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    
    //根据根据判断状态
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"searchUserByMobile" forKey:@"act"];
    [param setValue:searchStr forKey:@"mobile"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSArray *dataList = [json objectForKey:@"data"];
            self.dataArr = [CGTeamMemberModel mj_objectArrayWithKeyValuesArray:dataList];
            
            for (CGTeamMemberModel *model in self.dataArr)
            {
                for (CGTeamMemberModel *seleModel in self.selecteArr)
                {
                    if ([model.id isEqualToString:seleModel.id])
                    {
                        model.isAdd = YES;
                    }
                }
            }
            
        }
        else
        {
//            [MBProgressHUD showError:msg toView:self.view];
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
    }];
    
}

/**
 *  邀请委托代理
 */
- (void)CGMineTeamMemberMobileCellClick:(UIButton *)btnFunc model:(CGTeamMemberModel *)model {
    NSLog(@"邀请委托代理");
    
    switch (btnFunc.tag) {
        case 100: {
            //邀请
            //程序内调用系统发短信
            [self showMessageView:[NSArray arrayWithObjects:model.mobile, nil] title:model.name body:@"我邀请你加入商业不动产租赁管家——城格租赁 ，点击链接下载http://t.cn/RXidqzh"];
            
            //程序外调用系统发短信
            //[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://13888888888"]];
            
            break;
        }
        case 200: {
            //添加
            [self.selecteArr addObject:model];
            break;
        }
            
        default:
            break;
    }
    
}

-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
        //                                                        message:@"该设备不支持短信功能"
        //                                                       delegate:nil
        //                                              cancelButtonTitle:@"确定"
        //                                              otherButtonTitles:nil, nil];
        //        [alert show];
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent: {
            NSLog(@"信息传送成功");
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"信息传送成功" toView:self.view];
            });
            
            break;
        }
        case MessageComposeResultFailed: {
            NSLog(@"信息传送失败");
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"信息传送失败" toView:self.view];
            });
            
            break;
        }
        case MessageComposeResultCancelled: {
            NSLog(@"信息被用户取消传送");
            
            break;
        }
            
        default:
            break;
    }
    
}

@end
