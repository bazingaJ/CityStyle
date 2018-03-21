//
//  CGMineMessageViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineMessageViewController.h"
#import "CGMineMessageListViewController.h"
#import "CGMineMessageUpcomingViewController.h"
#import "RCSegmentExView.h"

@interface CGMineMessageViewController () {
    NSInteger pageIndex;
}

//@property (nonatomic, strong) CGMineMessageListViewController *messageView;
//@property (nonatomic, strong) CGMineMessageUpcomingViewController *upcomingView;
//@property (nonatomic ,strong) UIViewController *currentVC;
//
//@property (nonatomic, strong) UIView *lineView;

@end

@implementation CGMineMessageViewController

///**
// * 消息
// */
//- (CGMineMessageListViewController *)messageView {
//    if(!_messageView) {
//        _messageView = [[CGMineMessageListViewController alloc] init];
//        _messageView.view.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40);
//        [self addChildViewController:_messageView];
//    }
//    return _messageView;
//}
//
///**
// * 待办
// */
//- (CGMineMessageUpcomingViewController *)upcomingView {
//    if(!_upcomingView) {
//        _upcomingView = [[CGMineMessageUpcomingViewController alloc] init];
//        _upcomingView.view.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-40);
//        [self addChildViewController:_upcomingView];
//    }
//    return _upcomingView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"通知待办";
    
//    //创建“标题”
//    CGSegmentView *segmentView = [[CGSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    [segmentView setDelegate:self];
//    [segmentView setSelectedIndex:self.segmentIndex];
//    segmentView.titleArr = @[@"消息",@"待办"];
//    [self.view addSubview:segmentView];
//
//    pageIndex = 1;
//
//    //设置默认控制器
//    self.currentVC = self.messageView;
//    [self.view addSubview:self.messageView.view];
    
    //消息
    CGMineMessageListViewController *messageView = [[CGMineMessageListViewController alloc] init];
    //待办
    CGMineMessageUpcomingViewController *upcomingView = [[CGMineMessageUpcomingViewController alloc] init];
    
    NSArray *controllers = @[messageView,upcomingView];
    
    NSArray *titleArr =@[@"消息",@"待办"];
    RCSegmentExView *segmentView = [[RCSegmentExView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT) controllers:controllers titleArray:titleArr ParentController:self with:self.segmentIndex];
    segmentView.backgroundColor = [UIColor whiteColor];
    segmentView.callBack = ^(NSInteger tIndex) {
        NSLog(@"当前索引：%zd",tIndex);
    };
    segmentView.segmentScrollV.scrollEnabled = NO;
    [self.view addSubview:segmentView];
    
}

/**
 *  返回按钮事件
 */
- (void)leftButtonItemClick {
    if(self.isPush) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

///**
// *  顶部导航委托代理
// */
//- (void)CGSegmentViewDidSelectAtIndexClick:(NSInteger)tIndex {
//    NSLog(@"顶部导航委托代理:%zd",tIndex);
//
//    if(tIndex!=pageIndex) return;
//
//    if(pageIndex==0) {
//        //消息
//        self.segmentIndex = 0;
//        [self replaceController:self.currentVC newController:self.messageView];
//        pageIndex = 1;
//    }else if(pageIndex==1){
//        //待办
//        self.segmentIndex = 1;
//        [self replaceController:self.currentVC newController:self.upcomingView];
//        pageIndex = 0;
//    }
//
//}
//
////  切换各个标签内容
//- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
//{
//    /**
//     *            着重介绍一下它
//     *  transitionFromViewController:toViewController:duration:options:animations:completion:
//     *  fromViewController      当前显示在父视图控制器中的子视图控制器
//     *  toViewController        将要显示的姿势图控制器
//     *  duration                动画时间
//     *  options                 动画效果
//     *  animations              转换过程中得动画
//     *  completion              转换完成
//     */
//
//    [self addChildViewController:newController];
//    [self transitionFromViewController:oldController toViewController:newController duration:0.0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
//
//        if (finished) {
//
//            [newController didMoveToParentViewController:self];
//            [oldController willMoveToParentViewController:nil];
//            [oldController removeFromParentViewController];
//            self.currentVC = newController;
//
//        }else{
//
//            self.currentVC = oldController;
//
//        }
//    }];
//}


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
