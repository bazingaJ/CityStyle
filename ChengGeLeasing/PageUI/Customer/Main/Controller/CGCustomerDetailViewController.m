//
//  CGCustomerDetailViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGCustomerDetailViewController.h"
#import "RCSegmentView.h"
#import "CGLeaseMattersViewController.h"
#import "CGBusinessMattersViewController.h"
#import "CGContractViewController.h"
#import "CGUpcomingViewController.h"
#import "CGLinkmanViewController.h"
#include "CGCustomerInfoExViewController.h"

@interface CGCustomerDetailViewController ()

//招租事项
@property (nonatomic, strong) CGLeaseMattersViewController *leaseMattersView;
//经营事项
@property (nonatomic, strong) CGBusinessMattersViewController *businessMattersView;
//合同
@property (nonatomic, strong) CGContractViewController *contractView;
//待办
@property (nonatomic, strong) CGUpcomingViewController *upcomingView;
//联系人
@property (nonatomic, strong) CGLinkmanViewController *linkmanView;

@end

@implementation CGCustomerDetailViewController

/**
 *  招租事项
 */
- (CGLeaseMattersViewController *)leaseMattersView {
    if(!_leaseMattersView) {
        _leaseMattersView = [[CGLeaseMattersViewController alloc] init];
        _leaseMattersView.cust_id = self.cust_id;
        _leaseMattersView.isMine = self.isMine;
        _leaseMattersView.cust_name = self.title;
        _leaseMattersView.isAllCust = self.isAllCust;
    }
    return _leaseMattersView;
}

/**
 *  经营事项
 */
- (CGBusinessMattersViewController *)businessMattersView {
    if(!_businessMattersView) {
        _businessMattersView = [[CGBusinessMattersViewController alloc] init];
        _businessMattersView.cust_id = self.cust_id;
        _businessMattersView.isSign = self.isSign;
        _businessMattersView.isMine = self.isMine;
        _businessMattersView.cust_name = self.title;
        _businessMattersView.cust_cover = self.cust_cover;
        _businessMattersView.isAllCust = self.isAllCust;
    }
    return _businessMattersView;
}

/**
 *  合同
 */
- (CGContractViewController *)contractView {
    if(!_contractView) {
        _contractView = [[CGContractViewController alloc] init];
        _contractView.cust_id = self.cust_id;
        _contractView.isSign = self.isSign;
        _contractView.isMine = self.isMine;
        _contractView.cust_name = self.title;
        _contractView.isAllCust = self.isAllCust;
    }
    return _contractView;
}

/**
 *  待办
 */
- (CGUpcomingViewController *)upcomingView {
    if(!_upcomingView) {
        _upcomingView = [[CGUpcomingViewController alloc] init];
        _upcomingView.cust_id = self.cust_id;
        _upcomingView.isMine = self.isMine;
        _upcomingView.cust_name = self.title;
        _upcomingView.isAllCust = self.isAllCust;
    }
    return _upcomingView;
}

/**
 *  联系人
 */
- (CGLinkmanViewController *)linkmanView {
    if(!_linkmanView) {
        _linkmanView = [[CGLinkmanViewController alloc] init];
        _linkmanView.cust_id = self.cust_id;
        _linkmanView.isMine = self.isMine;
        _linkmanView.isAllCust = self.isAllCust;
    }
    return _linkmanView;
}

- (void)viewDidLoad {
    [self setRightButtonItemImageName:@"customer_icon_card"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *controllers;
    NSArray *titleArr;
    NSInteger index;
    if (self.type ==1)
    {
        controllers = @[[self leaseMattersView],[self upcomingView],[self linkmanView]];
        
        titleArr =@[@"招租事项",@"待办",@"联系人"];
        self.leaseMattersView.type = 4;
        self.linkmanView.type = 4;
        index =0;
    }
    else if (self.type ==2)
    {
        controllers = @[[self leaseMattersView],[self businessMattersView],[self contractView],[self upcomingView],[self linkmanView]];
        titleArr =@[@"招租事项",@"经营事项",@"合同",@"待办",@"联系人"];
        index =1;
    }
    else
    {
        controllers = @[[self leaseMattersView],[self businessMattersView],[self contractView],[self upcomingView],[self linkmanView]];
        titleArr =@[@"招租事项",@"经营事项",@"合同",@"待办",@"联系人"];
        index =0;
    }
    
    RCSegmentView *segmentView = [[RCSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT) controllers:controllers titleArray:titleArr ParentController:self with:index];
    segmentView.segmentScrollV.scrollEnabled = NO;
    segmentView.callBack = ^(NSInteger tIndex) {
        NSLog(@"当前索引:%zd",tIndex);
    };
    [self.view addSubview:segmentView];
}

/**
 *  客户名片
 */
- (void)rightButtonItemClick {
    NSLog(@"客户名片");
    
    CGCustomerInfoExViewController *infoView = [[CGCustomerInfoExViewController alloc] init];
    infoView.title = self.title;
    infoView.cust_id = self.cust_id;
    infoView.isMine = self.isMine;
    [self.navigationController pushViewController:infoView animated:YES];
    
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
