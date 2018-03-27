//
//  CGMemberInfoVC.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGMemberInfoVC.h"
#import "CGMemberModel.h"
#import "CGMemberCell.h"
#import "CGMemberRemoveV.h"
#import "CGTeamMemberContactAddViewController.h"
#import "CGTeamMemberMobileAddViewController.h"
#import "CGMemberContactVC.h"

static NSString *const currentTitle = @"成员信息";

static NSString *const detailText = @"您当前企业VIP账户剩余时间也不足一个月，请尽快续费";

static NSString *const alertText = @"remind";

static NSString *const cancelBtnText = @"取消管理员";

static NSString *const cancelPicText = @"cancelM";

static NSString *const removeText = @"移除";

static NSString *const removePicText = @"remove";

static NSString *const addText = @"mine_add_customer";

static NSString *cellIdentifier = @"CGMemberCell1";

@interface CGMemberInfoVC ()<SWTableViewCellDelegate>
@property (nonatomic, strong) KLCPopup *popup;
@end

@implementation CGMemberInfoVC

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [self setRightButtonItemImageName:addText];
    [super viewDidLoad];
    self.title = currentTitle;
    [self prepareForData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getMemberListData];
}

- (void)prepareForData
{
//    CGMemberModel *model = [CGMemberModel new];
//    model.name = @"张卫东";
//    model.add_date = @"升级时间：2018.03.01";
//    model.type_name = @"管理员";
//    [self.dataArr removeAllObjects];
//    [self.dataArr addObject:model];
//    [self.dataArr addObject:model];
//    [self.dataArr addObject:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CGMemberCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    CGMemberModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    if (![model.is_owner isEqualToString:@"1"])
    {
        cell.delegate = self;
        [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:110];
    }
    
    return cell;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    //设置已办按钮
    UIButton *btnFunc2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFunc2 setTitle:cancelBtnText forState:UIControlStateNormal];
    [btnFunc2 setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc2.titleLabel setFont:FONT14];
    [btnFunc2 setBackgroundColor:GRAY_COLOR];
    [btnFunc2 setImage:[UIImage imageNamed:cancelPicText] forState:UIControlStateNormal];
//    [btnFunc2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnFunc2 setTitleEdgeInsets:UIEdgeInsetsMake(45 ,0, 0, 0)];
    //图片距离右边框距离减少图片的宽度，其它不边
    [btnFunc2 setImageEdgeInsets:UIEdgeInsetsMake(0, 47, 25, 0)];
    [rightUtilityButtons addObject:btnFunc2];
    
    //设置删除按钮
    UIButton *btnFunc = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFunc setTitle:removeText forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT14];
    [btnFunc setBackgroundColor:GRAY_COLOR];
    [btnFunc setImage:[UIImage imageNamed:removePicText] forState:UIControlStateNormal];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(45 ,0, 0, 5)];
    //图片距离右边框距离减少图片的宽度，其它不边
    [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 47, 25, 0)];
    [rightUtilityButtons addObject:btnFunc];
    
    return rightUtilityButtons;
}

/**
 *  滑动删除委托代理
 */
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGMemberCell *tCell = (CGMemberCell *)cell;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tCell];
    
    CGMemberModel *model;
    if(self.dataArr.count)
    {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    
    if(!model) return;
    
    switch (index) {
        case 0: {
            //取消管理员
            NSLog(@"取消管理员");
            
            break;
        }
        case 1: {
            //移除
            NSLog(@"移除");
            CGMemberRemoveV *view = [[CGMemberRemoveV alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 300, 155) windowTitle:@"确定移除成员"];
            view.clickCallBack = ^(NSInteger tIndex) {
                [self.popup dismiss:YES];
                if (tIndex == 0 || tIndex == 1)
                {
                    return ;
                }
                else
                {
                    [MBProgressHUD showMessage:@"确定删除" toView:self.view];
                }
            };
            self.popup = [KLCPopup popupWithContentView:view
                                               showType:KLCPopupShowTypeGrowIn
                                            dismissType:KLCPopupDismissTypeGrowOut
                                               maskType:KLCPopupMaskTypeDimmed
                               dismissOnBackgroundTouch:NO
                                  dismissOnContentTouch:NO];
            [self.popup show];
            break;
        }
            
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 30.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:self.endDate];
    NSTimeInterval endInterval = [date timeIntervalSince1970];
    NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
    // 到期日期时间戳 - 当前时间戳是否 小于一个月的时间戳
    if (endInterval - nowInterval <= 3600 * 24 * 30)
    {
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        
        UIImageView *alertImage = [[UIImageView alloc] init];
        alertImage.frame = CGRectMake(15, (30 - 15) * 0.5, 15, 15);
        alertImage.image = [UIImage imageNamed:alertText];
        [view addSubview:alertImage];
        
        UILabel *detailLab = [[UILabel alloc] init];
        detailLab.frame = CGRectMake(40, (30 - 20) * 0.5, SCREEN_WIDTH - 40, 20);
        detailLab.text = detailText;
        detailLab.font = FONT11;
        detailLab.textColor = COLOR3;
        [view addSubview:detailLab];
        
        return view;
    }
    return nil;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}

- (void)rightButtonItemClick
{
    
    UIAlertController *alertController = [[UIAlertController alloc] init];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从手机通讯录添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"从手机通讯录添加");
        
        //通讯录添加成员
        CGMemberContactVC *bookView = [[CGMemberContactVC alloc] init];
//        bookView.pro_id = self.pro_id;
//        bookView.selecteArr = self.allArr;
        [self.navigationController pushViewController:bookView animated:YES];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"输入手机号添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"输入手机号添加");
        
        //手机号码添加
        CGTeamMemberMobileAddViewController *mobileView = [[CGTeamMemberMobileAddViewController alloc] init];
//        mobileView.pro_id = self.pro_id;
//        //把已选的客户带过去
//        mobileView.selecteArr = self.allArr;
        [self.navigationController pushViewController:mobileView animated:YES];
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Get Members List Data
- (void)getMemberListData
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"ucenter";
    param[@"act"] = @"getGroupMember";
    param[@"business_id"] = self.account_id;
    [MBProgressHUD showSimple:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               NSArray *dataArr = [json objectForKey:@"data"];
                               [self.dataArr removeAllObjects];
                               self.dataArr = [CGMemberModel mj_objectArrayWithKeyValuesArray:dataArr];
                               [self.tableView reloadData];
                               //设置空白页面
                               [self.tableView emptyViewShowWithDataType:EmptyViewTypeMember
                                                                 isEmpty:self.dataArr.count<=0
                                                     emptyViewClickBlock:nil];
                           }
                           else
                           {
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                       }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
