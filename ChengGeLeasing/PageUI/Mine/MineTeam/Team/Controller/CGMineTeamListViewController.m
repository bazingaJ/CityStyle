//
//  CGMineTeamListViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamListViewController.h"
#import "CGMineTeamDetailViewController.h"
#import "CGTeamAddViewController.h"
#import "CGUpdateView.h"
#import "CGUpgradeVersionVC.h"

@interface CGMineTeamListViewController ()
@property (nonatomic, strong) KLCPopup *popup;
@property (nonatomic, strong) NSString *mypronum;
@end

@implementation CGMineTeamListViewController

- (void)viewDidLoad {
    [self setBottomH:90];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    
    
    //创建“新建项目”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-90, SCREEN_WIDTH, 45)];
    [btnFunc setTitle:@"新建项目" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

/**
 *  刷新项目列表
 */
- (void)reloadXiangmuList {
    [self.tableView.mj_header beginRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    
    //创建“项目列表”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, backView.frame.size.width-20, 25)];
    [lbMsg setText:[NSString stringWithFormat:@"我创建的项目团队：%zd",self.totalNum]];
    [lbMsg setTextColor:COLOR9];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGMineTeamXiangmuCell";
    CGMineTeamXiangmuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGMineTeamXiangmuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGTeamXiangmuModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    //曾参与的项目
    if(self.type==3) {
        [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:100];
        [cell setDelegate:self];
    }
    [cell setTeamXiangmuModel:model indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CGTeamXiangmuModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    
    //团队详情
    CGMineTeamDetailViewController *detailView = [[CGMineTeamDetailViewController alloc] init];
    detailView.type = self.type;
    detailView.pro_id = model.id;
    detailView.callBack = ^(CGTeamXiangmuModel *xiangmuModel) {
        NSLog(@"详情页回调成功");
        
        [self.tableView.mj_header beginRefreshing];
        
//        //刷新当前数据
//        [self.tableView beginUpdates];
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [self.tableView endUpdates];
    };
    [self.navigationController pushViewController:detailView animated:YES];
    
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    //设置删除按钮
    UIButton *btnFunc = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFunc setTitle:@"删除" forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT14];
    [btnFunc setBackgroundColor:GRAY_COLOR];
    [btnFunc setImage:[UIImage imageNamed:@"delete_icon_big"] forState:UIControlStateNormal];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(btnFunc.imageView.frame.size.height+70 ,-btnFunc.imageView.frame.size.width-60, 0, 0)];
    //图片距离右边框距离减少图片的宽度，其它不边
    [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(30, -30, 50, -btnFunc.titleLabel.bounds.size.width)];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [rightUtilityButtons addObject:btnFunc];
    
    return rightUtilityButtons;
}

/**
 *  滑动删除委托代理
 */
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSLog(@"滑动删除委托代理");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    CGMineTeamXiangmuCell *tCell = (CGMineTeamXiangmuCell *)cell;
    NSIndexPath *indexPath = tCell.indexPath;
    
    CGTeamXiangmuModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    
    UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"警告" message:@"您确定要删除吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"删除");
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:@"ucenter" forKey:@"app"];
        [param setValue:@"dropPosRel" forKey:@"act"];
        [param setValue:model.id forKey:@"id"];
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
    
}

/**
 *  新建项目按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"新建项目");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    
    // 判断是否能够继续创建新的项目 与本地存储的 免费或者vip账户进行比对
    if ([HelperManager CreateInstance].isFree)
    {
        
        if ([self.mypronum integerValue] >= [FREE_PRONUM integerValue])
        {
            CGUpdateView *view = [[CGUpdateView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 275, 345) contentStr:@"创建更多项目\n邀请小伙伴一起合作"];
            view.clickCallBack = ^(NSInteger tIndex) {
                [self.popup dismiss:YES];
                if (tIndex == 0)
                {
                    return ;
                }
                else
                {
                    CGUpgradeVersionVC *vc = [CGUpgradeVersionVC new];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            };
            self.popup = [KLCPopup popupWithContentView:view
                                               showType:KLCPopupShowTypeGrowIn
                                            dismissType:KLCPopupDismissTypeGrowOut
                                               maskType:KLCPopupMaskTypeDimmed
                               dismissOnBackgroundTouch:NO
                                  dismissOnContentTouch:NO];
            [self.popup show];
            return ;
        }
    
    }
    else
    {
        // VIP账户的 数量如果是0 意思就是 不限制数量
        if ([VIP_PRONUM integerValue] != 0)
        {
            if ([self.mypronum integerValue] >= [VIP_PRONUM integerValue])
            {
                CGUpdateView *view = [[CGUpdateView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 275, 345) contentStr:@"创建更多项目\n邀请小伙伴一起合作"];
                view.clickCallBack = ^(NSInteger tIndex) {
                    [self.popup dismiss:YES];
                    if (tIndex == 0)
                    {
                        return ;
                    }
                    else
                    {
                        CGUpgradeVersionVC *vc = [CGUpgradeVersionVC new];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                };
                self.popup = [KLCPopup popupWithContentView:view
                                                   showType:KLCPopupShowTypeGrowIn
                                                dismissType:KLCPopupDismissTypeGrowOut
                                                   maskType:KLCPopupMaskTypeDimmed
                                   dismissOnBackgroundTouch:NO
                                      dismissOnContentTouch:NO];
                [self.popup show];
                return ;
            }
        }
        
    }
    
    CGTeamAddViewController *addView = [[CGTeamAddViewController alloc] init];
    addView.callBack = ^{
        [self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:addView animated:YES];
    
}

/**
 *  获取数据源
 */
- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getProList" forKey:@"act"];
    [param setValue:@(self.type) forKey:@"type"];//类型:1我创建的 2我加入的 3我曾经加入的
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if (self.type == 1)
            {
                self.mypronum = dataDic[@"count"];
            }
            
            
            if([dataDic isKindOfClass:[NSDictionary class]]) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                if([dataArr isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *itemDic in dataArr) {
                        [self.dataArr addObject:[CGTeamXiangmuModel mj_objectWithKeyValues:itemDic]];
                    }
                }
                
                //当前总数
                NSString *dataNum = [dataDic objectForKey:@"count"];
                if(!IsStringEmpty(dataNum)) {
                    self.totalNum = [dataNum intValue];
                }else{
                    self.totalNum = 0;
                }
            }
            
            //设置空白页面
            [self.tableView emptyViewShowWithDataType:EmptyViewTypeTeam
                                              isEmpty:self.dataArr.count<=0
                                  emptyViewClickBlock:nil];
            
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
