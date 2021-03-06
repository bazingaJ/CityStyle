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


@interface CGMineTeamViewController ()

@end

@implementation CGMineTeamViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"项目及团队管理";
    
    CGMineTeamListViewController *teamView1 = [[CGMineTeamListViewController alloc] init];
    teamView1.endDateTime = self.endDataTime;
    teamView1.type = 1;
    teamView1.account_id = self.account_id;
    CGMineTeamListViewController *teamView2 = [[CGMineTeamListViewController alloc] init];
    teamView2.type = 2;
    teamView2.account_id = self.account_id;
    CGMineTeamListViewController *teamView3 = [[CGMineTeamListViewController alloc] init];
    teamView3.type = 3;
    teamView3.account_id = self.account_id;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
