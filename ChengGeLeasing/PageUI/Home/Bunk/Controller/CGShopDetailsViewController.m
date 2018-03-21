//
//  CGShopDetailsViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGShopDetailsViewController.h"
#import "CGShopBusinessMattersViewController.h"
#import "CGShopLeaseItemViewController.h"
#import "CGShopPropertyConditionViewController.h"
#import "CGTeamBunkEditViewController.h"
//#import "CGEditUnitViewController.h"

@interface CGShopDetailsViewController ()

@property (nonatomic ,strong) CGShopBusinessMattersViewController *shopBusinessMattersView;

@property (nonatomic ,strong) CGShopLeaseItemViewController *shopLeaseItemView;

@property (nonatomic ,strong) CGShopPropertyConditionViewController *shopPropertyConditionView;

@property (nonatomic ,strong) UIViewController *currentVC;

@property (nonatomic ,strong) UIButton *cureenBtn;

@property (nonatomic ,strong) UIView *lineView;

@property (nonatomic ,strong) UIButton *edtiBtn;

@end

@implementation CGShopDetailsViewController

//经营事项
-(CGShopBusinessMattersViewController *)shopBusinessMattersView
{
    if (!_shopBusinessMattersView)
    {
        _shopBusinessMattersView = [[CGShopBusinessMattersViewController alloc]init];
        _shopBusinessMattersView.pos_id = self.pos_id;
        _shopBusinessMattersView.is_mine = self.is_mine;
        _shopBusinessMattersView.view.frame = CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addChildViewController:_shopBusinessMattersView];
    }
    return _shopBusinessMattersView;
}

//招租事项
-(CGShopLeaseItemViewController *)shopLeaseItemView
{
    if (!_shopLeaseItemView)
    {
        _shopLeaseItemView = [[CGShopLeaseItemViewController alloc]init];
        _shopLeaseItemView.pos_id = self.pos_id;
        _shopLeaseItemView.is_mine = self.is_mine;
        _shopLeaseItemView.view.frame = CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addChildViewController:_shopLeaseItemView];
    }
    return _shopLeaseItemView;
}

//铺位物业状态
-(CGShopPropertyConditionViewController *)shopPropertyConditionView
{
    if (!_shopPropertyConditionView)
    {
        _shopPropertyConditionView = [[CGShopPropertyConditionViewController alloc]init];
        _shopPropertyConditionView.pos_id = self.pos_id;
        _shopPropertyConditionView.view.frame = CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addChildViewController:_shopPropertyConditionView];
    }
    return _shopPropertyConditionView;
}

-(UIButton *)edtiBtn
{
    if (!_edtiBtn)
    {
        _edtiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _edtiBtn.frame =CGRectMake(0, 0, 30, 30);
        [_edtiBtn setTitle:@"编辑" forState:UIControlStateNormal];
        _edtiBtn.titleLabel.font = FONT16;
        [_edtiBtn addTarget:self action:@selector(edtiShopBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_edtiBtn];
        self.navigationItem.rightBarButtonItem = leftBarButtonItem;
        _edtiBtn.hidden =YES;
    }
    return _edtiBtn;
}

-(void)leftButtonItemClick
{
    [super leftButtonItemClick];
    if (self.callBackData)
    {
        self.callBackData();
    }
}

//创建"顶部"选择
-(void)createTopView
{
    NSArray *titleArr;
    if (self.type ==1)
    {
        titleArr =@[@"经营事项",@"招租事项",@"铺位物业条件"];
    }
    else if (self.type ==2)
    {
        titleArr =@[@"招租事项",@"经营事项",@"铺位物业条件"];
    }
    
    for (int i =0; i<3; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(SCREEN_WIDTH/3), 0, SCREEN_WIDTH/3, 45);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT14;
        [btn setTitleColor:COLOR9 forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:COLOR3 forState:UIControlStateSelected];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0)
        {
            btn.selected =YES;
            _cureenBtn = btn;
        }
        [self.view addSubview:btn];
        
        //创建"线"
        UIView  *lineView1 =[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3-.5, 0, .5, 45)];
        lineView1.backgroundColor = LINE_COLOR;
        [btn addSubview:lineView1];
    }
    
    UIView *lineView12 = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH,0.5)];
    lineView12.backgroundColor = LINE_COLOR;
    [self.view addSubview:lineView12];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH/3, 3)];
    self.lineView.backgroundColor = UIColorFromRGBWith16HEX(0x789BD4);
    [self.view addSubview:self.lineView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"铺位详情";
    
    [self createTopView];
    
    //默认
    
    if (self.type ==1)
    {
        self.currentVC = self.shopBusinessMattersView;
        [self.view addSubview:self.shopBusinessMattersView.view];
    }
    else if (self.type ==2)
    {
        self.currentVC = self.shopLeaseItemView;
        [self.view addSubview:self.shopLeaseItemView.view];
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
        rect.origin.x = (sender.tag -10) *(SCREEN_WIDTH/3);
        self.lineView.frame = rect;
    }];
     self.edtiBtn.hidden =YES;
    switch (sender.tag)
    {
        case 10:
        {
            if (self.type ==1)
            {
                [self replaceController:self.currentVC newController:self.shopBusinessMattersView];
            }
            else
            {
                [self replaceController:self.currentVC newController:self.shopLeaseItemView];
            }
           
        }
            break;
        case 11:
        {
            if (self.type ==2)
            {
                [self replaceController:self.currentVC newController:self.shopBusinessMattersView];
            }
            else
            {
                [self replaceController:self.currentVC newController:self.shopLeaseItemView];
            }
        }
            break;
        case 12:
        {
            [self replaceController:self.currentVC newController:self.shopPropertyConditionView];
             self.edtiBtn.hidden =NO;
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
-(void)edtiShopBtnClick
{
   
    CGTeamBunkEditViewController *editView = [[CGTeamBunkEditViewController alloc] init];
    editView.pro_id = [HelperManager CreateInstance].proId;
    editView.pos_id = self.pos_id;
    [self.navigationController pushViewController:editView animated:YES];
}
@end
