//
//  CGMineTeamDetailViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamDetailViewController.h"
#import "CGMineTeamMemberListViewController.h"
#import "CGTeamMemberContactAddViewController.h"
#import "CGTeamMemberDeleteViewController.h"
#import "CGMineTeamGroupViewController.h"
#import "CGMineTeamNameEditViewController.h"
#import "CGTeamMemberMobileAddViewController.h"
#import "CGMineTeamAreaViewController.h"
#import "CGTeamBunkViewController.h"
#import "CGMineFormatViewController.h"
#import "CGMineTransferViewController.h"
#import "CGMineAuthViewController.h"
#import "CGMineHandoverViewController.h"
#import "CGRentDefineVC.h"
#import "CGUpdateView.h"
#import "CGUpgradeVersionVC.h"
#import "CGBuySeatVC.h"
#import "CGBuySeatView.h"
#import "CGAddVipMemberViewController.h"

@interface CGMineTeamDetailViewController () {
    NSMutableDictionary *titleDic;
    
    //项目对象
    CGTeamXiangmuModel *xiangmuModel;
}

@property (nonatomic, strong) NSMutableArray *allArr;
@property (nonatomic, strong) KLCPopup *popup;

@end

@implementation CGMineTeamDetailViewController

- (NSMutableArray *)allArr {
    if(!_allArr) {
        _allArr = [NSMutableArray array];
    }
    return _allArr;
}

- (void)viewDidLoad {
    [self setBottomH:45];
    [super viewDidLoad];
    
    self.title = @"项目管理";
    
    //设置模拟成员
    CGTeamMemberModel *model = [CGTeamMemberModel new];
    model.name = @"";
    model.avatar = @"mine_member_add";
    [self.dataArr addObject:model];
    
    //设置数据源
    titleDic = [NSMutableDictionary dictionary];
    
    //第一区块
    NSMutableArray *titleArr1 = [NSMutableArray array];
    [titleArr1 addObject:@[@"名称",@"0"]];
    [titleArr1 addObject:@[@"分组",@"1"]];
    [titleArr1 addObject:@[@"分配权限",@"2"]];
    [titleArr1 addObject:@[@"交接客户",@"3"]];
    if(self.type==1) {
        [titleArr1 addObject:@[@"创建人转移",@"4"]];
    }
    [titleDic setValue:titleArr1 forKey:@"1"];
    
    //第二区块
    NSMutableArray *titleArr2 = [NSMutableArray array];
    [titleArr2 addObject:@[@"区域",@"0"]];
    [titleArr2 addObject:@[@"铺位",@"1"]];
    [titleArr2 addObject:@[@"业态",@"2"]];
//    [titleArr2 addObject:@[@"租金定义",@"3"]];
    [titleDic setValue:titleArr2 forKey:@"2"];
    
    //创建“解散项目”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    if(self.type==1) {
        //创建的项目
        [btnFunc setTitle:@"解散项目" forState:UIControlStateNormal];
    }else if(self.type==2) {
        //加入的项目
        [btnFunc setTitle:@"退出项目" forState:UIControlStateNormal];
    }
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc setTag:self.type];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  左侧返回按钮事件
 */
- (void)leftButtonItemClick {
    [super leftButtonItemClick];
    
    if(self.callBack) {
        self.callBack(xiangmuModel);
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(!xiangmuModel) return 0;
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return 1;
    }else{
        NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",section]];
        return [titleArr count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0) {
        NSInteger itemNum = [self.dataArr count];
        NSInteger rowNum = itemNum/5;
        NSInteger colNum = itemNum%5;
        if(colNum>0) {
            rowNum += 1;
        }
        return rowNum*100;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section==0) {
        return 40;
    }else if(section==2) {
        return 10;
    }
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    if(section==0) {
        [backView setBackgroundColor:[UIColor whiteColor]];
    }
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, backView.frame.size.width-20, 25)];
    if(section==0) {
        NSString * memberNum =xiangmuModel.member_num;
//
//        if(memberNum<=1) {
//            memberNum = 0;
//        }
//        else if (memberNum ==2)
//        {
//            memberNum =1;
//        }
//        else if(memberNum>=3)
//        {
//            memberNum -= 2;
//        }
     
    [lbMsg setText:[NSString stringWithFormat:@"团队成员(%@)",memberNum]];
    }else if(section==1) {
        [lbMsg setText:@"项目管理"];
    }else if(section==2) {
        [lbMsg setText:@"项目设置"];
    }
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if(section>0) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [backView setBackgroundColor:[UIColor whiteColor]];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backView.frame.size.width, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [backView addSubview:lineView];
    
    //创建“查看全部成员”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [btnFunc setTitle:@"查看全部成员>>" forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT16];
    [btnFunc addTouch:^{
        NSLog(@"查看全部成员");
        
        CGMineTeamMemberListViewController *allView = [[CGMineTeamMemberListViewController alloc] init];
        allView.pro_id = self.pro_id;
        [self.navigationController pushViewController:allView animated:YES];
        
    }];
    [backView addSubview:btnFunc];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGMineTeamDetailViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if(indexPath.section==0) {
        //设置添加按钮模型
        CGTeamMemberModel *model = [CGTeamMemberModel new];
        model.name = @"";
        model.avatar = @"mine_member_add";
        [self.dataArr addObject:model];
        
        if(self.dataArr.count>2)
        {
            // 设置移除按钮模型
            CGTeamMemberModel *model2 = [CGTeamMemberModel new];
            model2.name = @"";
            model2.avatar = @"mine_member_delete";
            [self.dataArr addObject:model2];
        }
        NSInteger itemNum = [self.dataArr count];
        NSInteger rowNum = itemNum/5;
        NSInteger colNum = itemNum%5;
        if(colNum>0)
        {
            rowNum += 1;
        }
        CGFloat tWidth = (SCREEN_WIDTH-20)/5;
        for (int i=0; i<rowNum; i++) {
            for (int k=0; k<5; k++) {
                int tIndex = 5*i+k;
                if(tIndex>itemNum-1) continue;
                
                CGTeamMemberModel *model = [self.dataArr objectAtIndex:tIndex];
                
                //创建“背景层”
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10+tWidth*k, 100*i, tWidth-1, 99)];
                if(itemNum==1) {
                    [btnFunc setTag:2];
                }
                else
                {
                    if (itemNum ==2)
                    {
                        if (k==1)
                        {
                             [btnFunc setTag:2];
                        }
                    }
                    else
                    {
                         [btnFunc setTag:(itemNum-tIndex)];
                    }
                   
                }
                [btnFunc addTarget:self action:@selector(btnFuncTeamMemClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btnFunc];
                
                if(tIndex>itemNum-3) {
                    
                    if (itemNum==2)
                    {
                        if (k==0)
                        {
                            //创建“头像”
                            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-50)/2, 10, 50, 50)];
                            [imgView setContentMode:UIViewContentModeScaleAspectFill];
                            [imgView setClipsToBounds:YES];
                            [imgView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"contact_icon_avatar"]];
                            [imgView.layer setCornerRadius:4.0];
                            [imgView.layer setMasksToBounds:YES];
                            [btnFunc addSubview:imgView];
                        }
                        else
                        {
                            //添加、删除
                            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-50)/2, 10, 50, 50)];
                            [imgView.layer setCornerRadius:4.0];
                            [imgView.layer setMasksToBounds:YES];
                            [imgView setImage:[UIImage imageNamed:model.avatar]];
                            [btnFunc addSubview:imgView];
                        }
                    }
                    else
                    {
                        //添加、删除
                        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-50)/2, 10, 50, 50)];
                        [imgView.layer setCornerRadius:4.0];
                        [imgView.layer setMasksToBounds:YES];
                        [imgView setImage:[UIImage imageNamed:model.avatar]];
                        [btnFunc addSubview:imgView];
                    }
                    
                }else{
                    
                    //创建“头像”
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-50)/2, 10, 50, 50)];
                    [imgView setContentMode:UIViewContentModeScaleAspectFill];
                    [imgView setClipsToBounds:YES];
                    [imgView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"contact_icon_avatar"]];
                    [imgView.layer setCornerRadius:4.0];
                    [imgView.layer setMasksToBounds:YES];
                    [btnFunc addSubview:imgView];
                    
                }
                
                //创建“名称”
                UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, tWidth, 20)];
                [lbMsg setText:model.name];
                [lbMsg setTextColor:COLOR3];
                [lbMsg setTextAlignment:NSTextAlignmentCenter];
                [lbMsg setFont:FONT15];
                [btnFunc addSubview:lbMsg];
                
            }
        }
        
    }else{
        
        NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",indexPath.section]];
        NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 25)];
        [lbMsg setText:itemArr[0]];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [cell.contentView addSubview:lbMsg];
        
        //创建“内容”
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-130, 25)];
        [lbMsg2 setTextColor:COLOR3];
        [lbMsg2 setTextAlignment:NSTextAlignmentRight];
        [lbMsg2 setFont:FONT16];
        [cell.contentView addSubview:lbMsg2];
        
        switch (indexPath.section) {
            case 1: {
                switch ([itemArr[1] integerValue]) {
                    case 0: {
                        //名称
                        [lbMsg2 setText:xiangmuModel.name];
                        
                        break;
                    }
                    case 1: {
                        //分组
                        NSInteger team_num = 0;
                        if(!IsStringEmpty(xiangmuModel.team_num)) {
                            team_num = [xiangmuModel.team_num integerValue];
                        }
                        [lbMsg2 setText:[NSString stringWithFormat:@"%zd个分组",team_num]];
                        
                        break;
                    }
                    case 2: {
                        //分配权限
                        
                        break;
                    }
                    case 3: {
                        //交接客户
                        
                        break;
                    }
                    case 4: {
                        //创建人转移
                        
                        break;
                    }
                        
                    default:
                        break;
                }
                break;
            }
            case 2: {
                switch ([itemArr[1] integerValue]) {
                    case 0: {
                        //区域
                        NSInteger group_num = 0;
                        if(!IsStringEmpty(xiangmuModel.group_num)) {
                            group_num = [xiangmuModel.group_num integerValue];
                        }
                        [lbMsg2 setText:[NSString stringWithFormat:@"%zd个",group_num]];
                        
                        break;
                    }
                    case 1: {
                        //铺位
                        NSInteger pos_num = 0;
                        if(!IsStringEmpty(xiangmuModel.pos_num)) {
                            pos_num = [xiangmuModel.pos_num integerValue];
                        }
                        [lbMsg2 setText:[NSString stringWithFormat:@"%zd个",pos_num]];
                        
                        break;
                    }
                    case 2: {
                        //业态
                        NSInteger cate_num = 0;
                        if(!IsStringEmpty(xiangmuModel.cate_num)) {
                            cate_num = [xiangmuModel.cate_num integerValue];
                        }
                        [lbMsg2 setText:[NSString stringWithFormat:@"%zd个",cate_num]];
                        
                        break;
                    }
                    case 3: {
                        //租金定义
                        
                        
                        break;
                    }
                        
                    default:
                        break;
                }
                
                break;
            }
                
            default:
                break;
        }
        
        //创建“右侧尖头”
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
        [imgView setImage:[UIImage imageNamed:@"mine_arrow_right"]];
        [cell.contentView addSubview:imgView];
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [cell.contentView addSubview:lineView];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",indexPath.section]];
    NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
    
    switch (indexPath.section) {
        case 1: {
            switch ([itemArr[1] integerValue]) {
                case 0: {
                    //名称
                    
                    CGMineTeamNameEditViewController *nameView = [[CGMineTeamNameEditViewController alloc] init];
                    nameView.pro_id = self.pro_id;
                    nameView.xiangmuModel = xiangmuModel;
                    nameView.callBack = ^(CGTeamXiangmuModel *model) {
                        NSLog(@"编辑名称回调成功");
                        
                        xiangmuModel.name = model.name;
                        xiangmuModel.cover_url = model.cover_url;
                        
                        //刷新
                        [self.tableView beginUpdates];
                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                    };
                    [self.navigationController pushViewController:nameView animated:YES];
                    
                    break;
                }
                case 1: {
                    //分组
                    
                    CGMineTeamGroupViewController *groupView = [[CGMineTeamGroupViewController alloc] init];
                    groupView.pro_id = self.pro_id;
                    groupView.callBack = ^(NSInteger groupNum) {
                        NSLog(@"分组管理回调成功:%zd",groupNum);
                        
                        xiangmuModel.team_num = [NSString stringWithFormat:@"%zd",groupNum];
                        
                        //刷新
                        [self.tableView beginUpdates];
                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                    };
                    [self.navigationController pushViewController:groupView animated:YES];
                    
                    break;
                }
                case 2: {
                    //分配权限
                    
                    CGMineAuthViewController *authView = [[CGMineAuthViewController alloc] init];
                    authView.pro_id = self.pro_id;
                    [self.navigationController pushViewController:authView animated:YES];
                    
                    break;
                }
                case 3: {
                    //交接客户
                    
                    CGMineHandoverViewController *handoverView = [[CGMineHandoverViewController alloc] init];
                    handoverView.pro_id = self.pro_id;
                    [self.navigationController pushViewController:handoverView animated:YES];
                    
                    break;
                }
                case 4: {
                    //创建人转移
                    
                    CGMineTransferViewController *transferView = [[CGMineTransferViewController alloc] init];
                    transferView.pro_id = self.pro_id;
                    [self.navigationController pushViewController:transferView animated:YES];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            break;
        }
        case 2: {
            switch ([itemArr[1] integerValue]) {
                case 0: {
                    //区域
                    
                    CGMineTeamAreaViewController *areaView = [[CGMineTeamAreaViewController alloc] init];
                    areaView.pro_id = self.pro_id;
                    [self.navigationController pushViewController:areaView animated:YES];
                    
                    break;
                }
                case 1: {
                    //铺位
                    
                    CGTeamBunkViewController *bunkView = [[CGTeamBunkViewController alloc] init];
                    bunkView.pro_id = self.pro_id;
                    [self.navigationController pushViewController:bunkView animated:YES];
                    
                    break;
                }
                case 2: {
                    //业态
                    
                    CGMineFormatViewController *formatView = [[CGMineFormatViewController alloc] init];
                    formatView.pro_id = self.pro_id;
                    [self.navigationController pushViewController:formatView animated:YES];
                    
                    break;
                }
                case 3: {
                    //租金定义
                    
                    CGRentDefineVC *defineVC = [[CGRentDefineVC alloc] init];
                    defineVC.pro_id = self.pro_id;
                    defineVC.rentDict = xiangmuModel.rent;
                    [self.navigationController pushViewController:defineVC animated:YES];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            break;
        }
            
        default:
            break;
    }
}

/**
 *  团队成员点击事件
 */
- (void)btnFuncTeamMemClick:(UIButton *)btnSender {
    NSLog(@"团队成员：%zd",btnSender.tag);
    
    switch (btnSender.tag) {
        case 1:
        {
            //删除成员
            
            if ([HelperManager CreateInstance].isFree)
            {
                CGTeamMemberDeleteViewController *deleteView = [[CGTeamMemberDeleteViewController alloc] init];
                deleteView.pro_id = self.pro_id;
                deleteView.callBack = ^{
                    NSLog(@"删除回调成功");
                    
                    [self.tableView.mj_header beginRefreshing];
                };
                [self.navigationController pushViewController:deleteView animated:YES];
            }
            else
            {
                // 添加成员
                CGAddVipMemberViewController *vc = [[CGAddVipMemberViewController alloc] init];
                vc.pro_id = self.pro_id;
                vc.isAdd = @"2";
                vc.selectdArr = self.allArr;
                vc.account_id = self.account_id;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
            
            
            
            break;
        }
        case 2: {
            //添加成员
            // 判断是否能够继续创建新的项目 与本地存储的 免费或者vip账户进行比对
            if ([HelperManager CreateInstance].isFree)
            {
                if (self.allArr.count >= [FREE_USERNUM integerValue])
                {
                    CGUpdateView *view = [[CGUpdateView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 275, 345) contentStr:@"添加更多项目小伙伴一起合作"];
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
                UIAlertController *alertController = [[UIAlertController alloc] init];
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"从手机通讯录添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    NSLog(@"从手机通讯录添加");
                    
                    //通讯录添加成员
                    CGTeamMemberContactAddViewController *bookView = [[CGTeamMemberContactAddViewController alloc] init];
                    bookView.pro_id = self.pro_id;
                    bookView.selecteArr = self.allArr;
                    bookView.callBack = ^(NSMutableArray *memberArr) {
                        NSLog(@"回调成功");
                        
                        //移除添加、删除
                        if(self.dataArr.count>=3) {
                            [self.dataArr removeLastObject];
                            [self.dataArr removeLastObject];
                        }
                        
                        //添加新成员
                        for (int i=0; i<memberArr.count; i++)
                        {
                            CGTeamMemberModel *model = [memberArr objectAtIndex:i];
                            if(self.dataArr.count>8) continue;
                            [self.dataArr addObject:model];
                        }
                        
                        //刷新单元格
                        [self.tableView beginUpdates];
                        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
                        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                    };
                    [self.navigationController pushViewController:bookView animated:YES];
                    
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"输入手机号添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    NSLog(@"输入手机号添加");
                    
                    //手机号码添加
                    CGTeamMemberMobileAddViewController *mobileView = [[CGTeamMemberMobileAddViewController alloc] init];
                    mobileView.pro_id = self.pro_id;
                    //把已选的客户带过去
                    mobileView.selecteArr = self.allArr;
                    mobileView.callBack = ^(NSMutableArray *memberArr) {
                        NSLog(@"回调成功");
                        
                        //移除添加、删除
                        if(self.dataArr.count>=3) {
                            [self.dataArr removeLastObject];
                            [self.dataArr removeLastObject];
                        }
                        
                        //添加新成员
                        for (int i=0; i<memberArr.count; i++)
                        {
                            CGTeamMemberModel *model = [memberArr objectAtIndex:i];
                            if(self.dataArr.count>8) continue;
                            [self.dataArr addObject:model];
                        }
                        
                        //刷新单元格
                        [self.tableView beginUpdates];
                        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
                        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                    };
                    [self.navigationController pushViewController:mobileView animated:YES];
                    
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
                // VIP账户的 数量如果是0 意思就是 不限制数量
                if ([VIP_USERNUM integerValue] != 0)
                {
                    if (self.allArr.count >= [VIP_USERNUM integerValue])
                    {
                        CGBuySeatView *view = [[CGBuySeatView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 275, 260) contentStr:@"请购买席位\n邀请小伙伴一起合作"];
                        view.clickCallBack = ^(NSInteger tIndex) {
                            [self.popup dismiss:YES];
                            if (tIndex == 0 || tIndex == 1)
                            {
                                return ;
                            }
                            else
                            {
                                CGBuySeatVC *vc = [CGBuySeatVC new];
                                vc.endTime = self.endTime;
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
                
                // 添加成员
                CGAddVipMemberViewController *vc = [[CGAddVipMemberViewController alloc] init];
                vc.pro_id = self.pro_id;
                vc.account_id = self.account_id;
                vc.isAdd = @"1";
                vc.selectdArr = self.allArr;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            

            
            break;
        }
            
        default:
            break;
    }
    
}

/**
 *  解散项目按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"解散项目");
    
    switch (btnSender.tag) {
        case 1: {
            //解散项目
            UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"警告" message:@"您确定要解散当前的项目吗?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"解散");
                
                [MBProgressHUD showMsg:@"处理中..." toView:self.view];
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"ucenter" forKey:@"app"];
                [param setValue:@"dismissProject" forKey:@"act"];
                [param setValue:self.pro_id forKey:@"pro_id"];
                [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                    [MBProgressHUD hideHUD:self.view];
                    NSString *code = [json objectForKey:@"code"];
                    if([code isEqualToString:SUCCESS]) {
                        [MBProgressHUD showSuccess:@"解散项目成功" toView:self.view];
                        if ([self.pro_id isEqualToString:[HelperManager CreateInstance].proId])
                        {
                            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                            [userDefault removeObjectForKey:@"proId"];
                            [userDefault removeObjectForKey:@"proName"];
                            [userDefault synchronize];
                        }
                        
                        //延迟一秒返回
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                        
                    }
                } failure:^(NSError *error) {
                    NSLog(@"%@",[error description]);
                    [MBProgressHUD hideHUD:self.view];
                }];
                
            }];
            [aler addAction:cancelAction];
            [aler addAction:okAction];
            [self presentViewController:aler animated:YES completion:nil];
            
            break;
        }
        case 2: {
            //退出项目
            
            UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"警告" message:@"您确定要解散当前的项目吗?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"退出项目");
                
                [MBProgressHUD showMsg:@"处理中..." toView:self.view];
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"ucenter" forKey:@"app"];
                [param setValue:@"quitProject" forKey:@"act"];
                [param setValue:self.pro_id forKey:@"pro_id"];
                [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                    [MBProgressHUD hideHUD:self.view];
                    NSString *code = [json objectForKey:@"code"];
                    if([code isEqualToString:SUCCESS]) {
                        [MBProgressHUD showSuccess:@"退出项目成功" toView:self.view];
                        
                        //延迟一秒返回
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                    }
                } failure:^(NSError *error) {
                    NSLog(@"%@",[error description]);
                    [MBProgressHUD hideHUD:self.view];
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
 *  获取项目详情页
 */
- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getProInfo" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [param setValue:@"1" forKey:@"type"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            xiangmuModel = [CGTeamXiangmuModel mj_objectWithKeyValues:dataDic];
            
            //团队成员
            if(xiangmuModel.list.count) {
                [self.allArr removeAllObjects];
                [self.dataArr removeAllObjects];
                for (int i=0; i<xiangmuModel.list.count; i++) {
                    [self.allArr addObject:xiangmuModel.list[i]];
                    
                    if(self.dataArr.count<8) {
                        [self.dataArr addObject:xiangmuModel.list[i]];
                    }
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

@end
