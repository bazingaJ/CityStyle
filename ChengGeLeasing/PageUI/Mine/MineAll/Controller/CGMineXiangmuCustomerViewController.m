//
//  CGMineXiangmuCustomerViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineXiangmuCustomerViewController.h"
#import "CGCustomerCopyViewController.h"
#import "CGCustomerDetailViewController.h"

@interface CGMineXiangmuCustomerViewController () {
    //搜索关键词
    NSString *keywordStr;
    //A-Z
    NSString *simple_keywords;
    //业态
    NSString *cateId;
    //项目
    NSString *proId;
}

@end

@implementation CGMineXiangmuCustomerViewController

/**
 *  懒加载顶部视图
 */
- (CGCustomerTopView *)topView {
    if(!_topView) {
        _topView = [[CGCustomerTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) isXiangmu:YES];
        [_topView setDelegate:self];
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (void)viewDidLoad {
    [self setTopH:150];
    [self setBottomH:45];
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"项目客户";
    
    //创建“顶部视图”
    [self topView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGXiangmuCustomerCell";
    CGXiangmuCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGXiangmuCustomerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGCustomerModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:100];
    [cell setDelegate:self];
    [cell setCustomerModel:model indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CGCustomerModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    if(!model) return;
    
    //客户详情
    CGCustomerDetailViewController *detailView = [[CGCustomerDetailViewController alloc] init];
    [detailView setTitle:model.name];
    detailView.cust_id = model.id;
    detailView.isMine = model.is_mine;
    detailView.isAllCust = YES;
    if ([model.intent isEqualToString:@"90"] ||[model.intent isEqualToString:@"100"]) {
        detailView.isSign = YES;
    }
    [self.navigationController pushViewController:detailView animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    //隐藏键盘
    [self.topView.searchView.tbxContent resignFirstResponder];
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    //设置已办按钮
    UIButton *btnFunc2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFunc2 setTitle:@"复制" forState:UIControlStateNormal];
    [btnFunc2 setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc2.titleLabel setFont:FONT14];
    [btnFunc2 setBackgroundColor:GRAY_COLOR];
    [btnFunc2 setImage:[UIImage imageNamed:@"copy_icon_big"] forState:UIControlStateNormal];
    [btnFunc2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnFunc2 setTitleEdgeInsets:UIEdgeInsetsMake(btnFunc2.imageView.frame.size.height+70 ,-btnFunc2.imageView.frame.size.width-60, 0, 0)];
    //图片距离右边框距离减少图片的宽度，其它不边
    [btnFunc2 setImageEdgeInsets:UIEdgeInsetsMake(30, -30, 50, -btnFunc2.titleLabel.bounds.size.width)];
    [btnFunc2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [rightUtilityButtons addObject:btnFunc2];
    
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

    CGXiangmuCustomerCell *tCell = (CGXiangmuCustomerCell *)cell;
    NSIndexPath *indexPath = tCell.indexPath;
    
    CGCustomerModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.section];
    }
    if(!model) return;
    
    switch (index) {
        case 0: {
            //复制
            
            CGCustomerCopyViewController *copyView = [[CGCustomerCopyViewController alloc] init];
            copyView.old_proId = model.pro_id;
            copyView.cust_id = model.id;
            copyView.callBack = ^{
                NSLog(@"复制客户回调成功");
                
                [self.tableView.mj_header beginRefreshing];
            };
            [self.navigationController pushViewController:copyView animated:YES];
            
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
                [param setValue:@"dropCust" forKey:@"act"];
                [param setValue:model.id forKey:@"cust_id"];
                [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                    NSString *msg = [json objectForKey:@"msg"];
                    NSString *code = [json objectForKey:@"code"];
                    if([code isEqualToString:SUCCESS]) {
                        
                        [self.dataArr removeObject:model];
                        
                        //界面上移除
                        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
                        [self.tableView beginUpdates];
                        [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                        //延迟一秒返回
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
 *  搜索委托代理
 */
- (void)CGCustomerTopViewSearchBarViewClick:(NSString *)searchStr {
    NSLog(@"搜索委托代理");
    keywordStr = searchStr;
    //搜索
    [self.tableView.mj_header beginRefreshing];
    
}

/**
 *  项目委托代理
 */
- (void)CGCustomerTopViewTeamXiangmuSelectClick:(NSString *)pro_id {
    NSLog(@"项目委托代理");
    
    proId = pro_id;
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  A-Z委托代理
 */
- (void)CGCustomerTopViewAZSelectClick:(NSString *)letterStr {
    NSLog(@"A-Z委托代理");
    
    simple_keywords = letterStr;
    [self.tableView.mj_header beginRefreshing];
    
}

/**
 *  业态委托代理
 */
- (void)CGCustomerTopViewFormatSelectClick:(NSString *)formatId {
    NSLog(@"业态委托代理");
    
    cateId = formatId;
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  获取客户数据
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getMyCustList" forKey:@"act"];
    [param setValue:keywordStr forKey:@"keywords"];
    [param setValue:simple_keywords forKey:@"simple_keywords"];//待完善
    [param setValue:cateId forKey:@"cate_id"];//待完善
    [param setValue:proId forKey:@"pro_id"];//待完善
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[CGCustomerModel mj_objectWithKeyValues:itemDic]];
                }
                
                //当前总数
                NSString *dataNum = [dataDic objectForKey:@"count"];
                if(!IsStringEmpty(dataNum)) {
                    self.totalNum = [dataNum intValue];
                }else{
                    self.totalNum = 0;
                }
                
                //设置客户资源数
                self.topView.customerNum = dataNum;
            }
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
    }];
    
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}

@end
