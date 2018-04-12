//
//  CGMemberAddMobileVC.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/28.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGMemberAddMobileVC.h"
#import "CGMineSearchBarView.h"
#import "CGMineTeamMemberMobileCell.h"
#import <MessageUI/MessageUI.h>
#import "CGContactCell.h"

@interface CGMemberAddMobileVC ()<CGMineSearchBarViewDelegate,
                                  CGMineTeamMemberMobileCellDelegate,
                                  MFMessageComposeViewControllerDelegate,
                                  JXContactDelegate>
@property (nonatomic, strong) CGMineSearchBarView *searchView;
@end

@implementation CGMemberAddMobileVC

- (void)viewDidLoad
{
    
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    //创建“搜索框”
    [self searchView];
}

/**
 *  返回按钮事件
 */
- (void)leftButtonItemClick
{
    
    [super leftButtonItemClick];
    [self.searchView.searchBar resignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchView.searchBar becomeFirstResponder];
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
    static NSString *cellIndentifier = @"CGContactCell1";
    CGContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CGContactCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    
    CGTeamMemberModel *model = self.dataArr[indexPath.row];
    cell.teamMemberModel = model;
    cell.delegate = self;
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.searchView.searchBar resignFirstResponder];
}

/**
 *  搜索委托代理
 */
- (void)CGMineSearchBarViewClick:(NSString *)searchStr
{
    
    //get origin data
    [self.dataArr removeAllObjects];
    
    //clear UI
    [self.tableView beginUpdates];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    
    //request data
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"searchUserByMobile" forKey:@"act"];
    [param setValue:searchStr forKey:@"mobile"];
    [param setValue:self.account_id forKey:@"business_id"];
    [MBProgressHUD showSimple:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUDForView:self.view];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               NSArray *dataList = [json objectForKey:@"data"];
                               self.dataArr = [CGTeamMemberModel mj_objectArrayWithKeyValuesArray:dataList];
                               
                               //set empty page
                               [self.tableView emptyViewShowWithDataType:EmptyViewTypeCustomer
                                                                 isEmpty:self.dataArr.count<=0
                                                     emptyViewClickBlock:nil];
                               [self.tableView reloadData];
                           }
                           else
                           {
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           [MBProgressHUD hideHUDForView:self.view];
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
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
            
            break;
        }
        case 200: {
            //添加
//            [self.selecteArr addObject:model];
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark - cell 上的邀请按钮点击
- (void)invateBtnClick:(UIButton *)button model:(CGContactModel *)model
{
    
    CGContactCell *cell = (CGContactCell *)button.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    CGTeamMemberModel *model1 = self.dataArr[index.row];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"ucenter";
    param[@"act"] = @"addGroupMember";
    param[@"business_id"] = self.account_id;
    param[@"member"] = model1.ID;
    [MBProgressHUD showSimple:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUDForView:self.view];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               [MBProgressHUD showMessage:@"添加成功" toView:self.view];
//                               [self CGMineSearchBarViewClick:self.searchView.searchBar.text];
                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                   [self.navigationController popViewControllerAnimated:YES];
                               });
                               
                           }
                           else
                           {
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           [MBProgressHUD hideHUDForView:self.view];
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                       }];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
