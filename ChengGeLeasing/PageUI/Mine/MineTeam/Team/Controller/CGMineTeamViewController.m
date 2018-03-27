//
//  CGMineTeamViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamViewController.h"
#import "RCSegmentView.h"
#import "CGMineTeamListViewController.h"
#import "CGMineTeamCustomerFormatViewController.h"
#import "CGUpdateView.h"

@interface CGMineTeamViewController ()

@end

@implementation CGMineTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"项目及团队管理";
    
    CGMineTeamListViewController *teamView1 = [[CGMineTeamListViewController alloc] init];
    teamView1.type = 1;
    CGMineTeamListViewController *teamView2 = [[CGMineTeamListViewController alloc] init];
    teamView2.type = 2;
    CGMineTeamListViewController *teamView3 = [[CGMineTeamListViewController alloc] init];
    teamView3.type = 3;
    CGMineTeamCustomerFormatViewController *chubeiView = [[CGMineTeamCustomerFormatViewController alloc] init];
    
    NSArray *controllers = @[teamView1,teamView2,teamView3,chubeiView];
    
    NSArray *titleArr =@[@"创建的项目",@"加入的项目",@"曾参与的项目",@"储备客户"];
    RCSegmentView *segmentView = [[RCSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT) controllers:controllers titleArray:titleArr ParentController:self with:0];
    segmentView.segmentScrollV.scrollEnabled = NO;
    segmentView.callBack = ^(NSInteger tIndex) {
        NSLog(@"索引值:%zd",tIndex);
        
        switch (tIndex) {
            case 0: {
                //创建的项目
                [teamView1 reloadXiangmuList];
                
                break;
            }
            case 1: {
                //加入的项目
                [teamView2 reloadXiangmuList];
                
                break;
            }
            case 2: {
                //曾参与的项目
                [teamView3 reloadXiangmuList];
                
                break;
            }
            case 3: {
                //储备客户
                [chubeiView reloadCustomerList];
                
                break;
            }
                
            default:
                break;
        }
        
    };
    [self.view addSubview:segmentView];
    if ([HelperManager CreateInstance].isFree)
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
    }
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
