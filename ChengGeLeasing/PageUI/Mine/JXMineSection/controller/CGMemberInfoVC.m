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

- (void)prepareForData
{
    CGMemberModel *model = [CGMemberModel new];
    model.member_name = @"张卫东";
    model.member_updateTime = @"2018.03.01";
    model.member_position = @"管理员";
    [self.dataArr removeAllObjects];
    [self.dataArr addObject:model];
    [self.dataArr addObject:model];
    [self.dataArr addObject:model];
    [self.dataArr addObject:model];
    [self.dataArr addObject:model];
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
    cell.model = self.dataArr[indexPath.row];
    cell.delegate = self;
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:110];
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
    
    return 40.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    
    UIImageView *alertImage = [[UIImageView alloc] init];
    alertImage.frame = CGRectMake(15, (40 - 15) * 0.5, 15, 15);
    alertImage.image = [UIImage imageNamed:alertText];
    [view addSubview:alertImage];
    
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.frame = CGRectMake(40, (40 - 20) * 0.5, SCREEN_WIDTH - 40, 20);
    detailLab.text = detailText;
    detailLab.font = FONT11;
    detailLab.textColor = COLOR3;
    [view addSubview:detailLab];
    
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}

- (void)rightButtonItemClick
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
