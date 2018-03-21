//
//  CGOperationDynamicViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGOperationDynamicViewController.h"
#import "CGOperatingDynamicDetailsViewController.h"
@interface CGOperationDynamicViewController ()

@property (nonatomic ,strong) CGOperatingDynamicDetailsViewController *operatingDynamicDetails1;

@property (nonatomic ,strong) CGOperatingDynamicDetailsViewController *operatingDynamicDetails2;

@property (nonatomic ,strong) CGOperatingDynamicDetailsViewController *operatingDynamicDetails3;

@property (nonatomic ,strong) CGOperatingDynamicDetailsViewController *operatingDynamicDetails4;

@property (nonatomic ,strong) UIViewController *currentVC;

@property (nonatomic ,strong) UIButton *cureenBtn;

@property (nonatomic ,strong) UIView *lineView;

@end

@implementation CGOperationDynamicViewController

//空置
-(CGOperatingDynamicDetailsViewController *)operatingDynamicDetails1
{
    
    if (!_operatingDynamicDetails1)
    {
        _operatingDynamicDetails1 = [[CGOperatingDynamicDetailsViewController alloc]init];
        _operatingDynamicDetails1.fromWhere =1;
        _operatingDynamicDetails1.view.frame = CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT-45-NAVIGATION_BAR_HEIGHT);
        [self addChildViewController:_operatingDynamicDetails1];
    }
    return _operatingDynamicDetails1;
}

//稳营
-(CGOperatingDynamicDetailsViewController *)operatingDynamicDetails2
{
    
    if (!_operatingDynamicDetails2)
    {
        _operatingDynamicDetails2 = [[CGOperatingDynamicDetailsViewController alloc]init];
        _operatingDynamicDetails2.fromWhere =2;
        _operatingDynamicDetails2.view.frame = CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT-45-NAVIGATION_BAR_HEIGHT);
        [self addChildViewController:_operatingDynamicDetails2];
    }
    return _operatingDynamicDetails2;
}

//预动
-(CGOperatingDynamicDetailsViewController *)operatingDynamicDetails3
{
    
    if (!_operatingDynamicDetails3)
    {
        _operatingDynamicDetails3 = [[CGOperatingDynamicDetailsViewController alloc]init];
         _operatingDynamicDetails3.fromWhere =3;
        _operatingDynamicDetails3.view.frame = CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT-45-NAVIGATION_BAR_HEIGHT);
        [self addChildViewController:_operatingDynamicDetails3];
    }
    return _operatingDynamicDetails3;
}

//退铺
-(CGOperatingDynamicDetailsViewController *)operatingDynamicDetails4
{
    
    if (!_operatingDynamicDetails4)
    {
        _operatingDynamicDetails4 = [[CGOperatingDynamicDetailsViewController alloc]init];
        _operatingDynamicDetails4.fromWhere =4;
        _operatingDynamicDetails4.view.frame = CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT-45-NAVIGATION_BAR_HEIGHT);
        [self addChildViewController:_operatingDynamicDetails4];
    }
    return _operatingDynamicDetails4;
}

//创建"顶部"选择
-(void)createTopView
{
    for (int i =0; i<4; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(SCREEN_WIDTH/4), 0, SCREEN_WIDTH/4, 45);
        [btn setTitle:@[@"空置",@"稳营",@"预动",@"退铺"][i] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT14;
        [btn setTitleColor:COLOR3 forState:UIControlStateNormal];
        btn.backgroundColor = WHITE_COLOR;
        [btn setTitleColor:UIColorFromRGBWith16HEX(0x789BD4) forState:UIControlStateSelected];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==self.fromWhere)
        {
            btn.selected =YES;
            _cureenBtn = btn;
        }
        [self.view addSubview:btn];
    }
    UIView *lineView1 =[[UIView alloc]initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, .5)];
    lineView1.backgroundColor = LINE_COLOR;
    [self.view addSubview:lineView1];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(self.fromWhere *(SCREEN_WIDTH/4), 43, SCREEN_WIDTH/4, 2)];
    self.lineView.backgroundColor = UIColorFromRGBWith16HEX(0x789BD4);
    [self.view addSubview:self.lineView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"经营动态";
    
    [self createTopView];
    
    //默认
    
    switch (self.fromWhere)
    {
        case 0:
        {
            self.currentVC = self.operatingDynamicDetails1;
            [self.view addSubview:self.operatingDynamicDetails1.view];
        }
            break;
        case 1:
        {
            self.currentVC = self.operatingDynamicDetails2;
            [self.view addSubview:self.operatingDynamicDetails2.view];
        }
            break;
        case 2:
        {
            self.currentVC = self.operatingDynamicDetails3;
            [self.view addSubview:self.operatingDynamicDetails3.view];
        }
            break;
        case 3:
        {
            self.currentVC = self.operatingDynamicDetails4;
            [self.view addSubview:self.operatingDynamicDetails4.view];
        }
            break;
            
        default:
            break;
    }
    
  
}

-(void)btnClick:(UIButton *)sender
{
    if (sender ==_cureenBtn) return;
    _cureenBtn.selected = NO;
    sender.selected = !sender.selected;
    _cureenBtn = sender;
    
    [UIView animateWithDuration:.25 animations:^{
        CGRect rect = self.lineView.frame;
        rect.origin.x = (sender.tag -10) *(SCREEN_WIDTH/4);
        self.lineView.frame = rect;
    }];
    switch (sender.tag)
    {
        case 10:
        {
            [self replaceController:self.currentVC newController:self.operatingDynamicDetails1];
            self.operatingDynamicDetails1.fromWhere = 1;
            [self.operatingDynamicDetails1 reloadDynamicList];
        }
            break;
        case 11:
        {
            [self replaceController:self.currentVC newController:self.operatingDynamicDetails2];
              self.operatingDynamicDetails2.fromWhere =2;
            [self.operatingDynamicDetails2 reloadDynamicList];
        }
            break;
        case 12:
        {
            [self replaceController:self.currentVC newController:self.operatingDynamicDetails3];
            [self.operatingDynamicDetails3 reloadDynamicList];
        }
            break;
        case 13:
        {
            [self replaceController:self.currentVC newController:self.operatingDynamicDetails4];
            [self.operatingDynamicDetails4 reloadDynamicList];
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

@end
