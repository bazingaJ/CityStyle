//
//  CGLeaseReportViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLeaseReportViewController.h"
#import "CGLeaseReportMyViewController.h"
#import "CGLeaseReportGroupViewController.h"
#import "CGLeaseReportTeamViewController.h"
@interface CGLeaseReportViewController ()

@property (nonatomic ,strong) CGLeaseReportMyViewController *leaseReportMyView;

@property (nonatomic ,strong) CGLeaseReportGroupViewController *leaseReportGroupView;

@property (nonatomic ,strong) CGLeaseReportTeamViewController *leaseReportTeamView;

@property (nonatomic ,strong) UIViewController *currentVC;

@property (nonatomic ,strong) UIButton *cureenBtn;

@property (nonatomic ,strong) UIView *lineView;

@property (nonatomic ,assign) BOOL isGroup;
@property (nonatomic ,strong) NSString *groupStr;

@property (nonatomic ,assign) BOOL isTeam;

@end

@implementation CGLeaseReportViewController

//我的
-(CGLeaseReportMyViewController *)leaseReportMyView
{
    
    if (!_leaseReportMyView)
    {
        _leaseReportMyView = [[CGLeaseReportMyViewController alloc]init];
        _leaseReportMyView.view.frame = CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT-45-NAVIGATION_BAR_HEIGHT);
        [self addChildViewController:_leaseReportMyView];
    }
    return _leaseReportMyView;
}

//小组
-(CGLeaseReportGroupViewController *)leaseReportGroupView
{
    
    if (!_leaseReportGroupView)
    {
        _leaseReportGroupView = [[CGLeaseReportGroupViewController alloc]init];
        _leaseReportGroupView.view.frame = CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT-45-NAVIGATION_BAR_HEIGHT);
        [self addChildViewController:_leaseReportGroupView];
    }
    return _leaseReportGroupView;
}

//团队
-(CGLeaseReportTeamViewController *)leaseReportTeamView
{
    
    if (!_leaseReportTeamView)
    {
        _leaseReportTeamView = [[CGLeaseReportTeamViewController alloc]init];
        _leaseReportTeamView.view.frame = CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT-45-NAVIGATION_BAR_HEIGHT);
        [self addChildViewController:_leaseReportTeamView];
    }
    return _leaseReportTeamView;
}

//创建"顶部"选择
-(void)createTopView
{
    for (int i =0; i<3; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(SCREEN_WIDTH/3), 0, SCREEN_WIDTH/3, 45);
        [btn setTitle:@[@"我的",@"小组",@"团队"][i] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT14;
        [btn setTitleColor:UIColorFromRGBWith16HEX(0x989BA4) forState:UIControlStateNormal];
        btn.backgroundColor = UIColorFromRGBWith16HEX(0x2E374F);
        [btn setTitleColor:WHITE_COLOR forState:UIControlStateSelected];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0)
        {
            btn.selected =YES;
            _cureenBtn = btn;
        }
        [self.view addSubview:btn];
    }
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH/3, 3)];
    self.lineView.backgroundColor = UIColorFromRGBWith16HEX(0x789BD4);
    [self.view addSubview:self.lineView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"招租报表";
    
    [self createTopView];
    
    //默认
    self.currentVC = self.leaseReportMyView;
    [self.view addSubview:self.leaseReportMyView.view];
    
    [self getMyAuth];
}

-(void)btnClick:(UIButton *)sender
{
    if(sender.tag==11) {
        //小组
        if (!self.isGroup) {
            [MBProgressHUD showError:@"暂无权限查看小组" toView:self.view];
            return;
        }
//        if([self.groupStr isEqualToString:@"不在小组内"]) {
//            [MBProgressHUD showError:@"不在小组内" toView:self.view];
//            return;
//        }
    }else if(sender.tag==12) {
        //团队
        if (!self.isTeam) {
            [MBProgressHUD showError:@"暂无权限查看团队" toView:self.view];
            return;
        }
    }
    
    if (sender ==_cureenBtn) return;
    _cureenBtn.selected = NO;
    sender.selected = !sender.selected;
    _cureenBtn = sender;
    
    [UIView animateWithDuration:.25 animations:^{
        CGRect rect = self.lineView.frame;
        rect.origin.x = (sender.tag -10) *(SCREEN_WIDTH/3);
        self.lineView.frame = rect;
    }];
    switch (sender.tag)
    {
        case 10:
        {
            //我的
            [self replaceController:self.currentVC newController:self.leaseReportMyView];
        }
            break;
        case 11:
        {
            //小组
            
//            BOOL ischarge = [[HelperManager CreateInstance] userAuth:[HelperManager CreateInstance].proId completion:^(NSArray *authArr)
//            {
//                
//            }];
//            
//            if (!ischarge)
//            {
//                [MBProgressHUD showError:@"您没有权限查看小组报表" toView:self.view];
//                return;
//            }
//            if (!self.isGroup)
//            {
//                [MBProgressHUD showError:@"暂无权限查看小组" toView:self.view];
//                return;
//            }
         
            [self replaceController:self.currentVC newController:self.leaseReportGroupView];
        }
            break;
        case 12:
        {
            //团队
//            if (!self.isTeam)
//            {
//                [MBProgressHUD showError:@"暂无权限查看团队" toView:self.view];
//                return;
//            }
            [self replaceController:self.currentVC newController:self.leaseReportTeamView];
        }
            break;
        default:
            break;
    }
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *            着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间
     *  options                 动画效果
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished)
     {
         if (finished)
         {
             [newController didMoveToParentViewController:self];
             [oldController willMoveToParentViewController:nil];
             [oldController removeFromParentViewController];
             self.currentVC = newController;
         }
         else
         {
             self.currentVC = oldController;
         }
     }];
}

//获取我的权限
-(void)getMyAuth
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"getMyAuth" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
     {
         NSString *code = json[@"code"];
         if ([code isEqualToString:SUCCESS])
         {
             if ([json[@"data"][@"is_charge"] isEqualToString:@"1"])
             {
                 self.isTeam =YES;
                 self.isGroup = YES;
             }
             else
             {
                 //权限:1团队分组 2分配权限 3查看本组客户 4查看所有客户 5查看本组进度 6邀请成员 7客户交接 8删除团队成员 9查看团队进度 10网盘文件
                 NSArray *arr = [json[@"data"][@"authority"] componentsSeparatedByString:@","];
                 
                 //查看小组的权限
                 if([arr containsObject:@"3"]) {
                     self.isGroup = YES;
                 }
                 
                 //查看团队的权限
                 if([arr containsObject:@"4"]) {
                     self.isTeam = YES;
                 }
                 
//                 for (NSString *authority in arr)
//                 {
//                     if ([authority isEqualToString:@"3"])
//                     {
//                         self.isGroup = YES;
//                     }
//                     else
//                     {
//                         self.isGroup = NO;
//                     }
//                     if ([authority isEqualToString:@"9"])
//                     {
//                         self.isTeam = YES;
//                     }
//                     else
//                     {
//                         self.isTeam = NO;
//                     }
//                 }
             }
         }
         
     } failure:^(NSError *error) {
         
     }];
    
    NSMutableDictionary *param2 = [NSMutableDictionary dictionary];
    [param2 setValue:@"home" forKey:@"app"];
    [param2 setValue:@"getLetReport" forKey:@"act"];
    [param2 setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param2 setValue:@"2" forKey:@"type"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param2 success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if ([code isEqualToString:SUCCESS]) {
         
        }
        self.groupStr = msg;
     } failure:^(NSError *error) {
     }];
    
}

@end
