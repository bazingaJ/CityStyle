//
//  XTTabBarViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XTTabBarViewController.h"
#import "CGHomeViewController.h"
#import "CGCustomerViewController.h"
#import "CGFindViewController.h"
#import "CGMineViewController.h"
#import "XTTabBar.h"
#import "XTPopupFullView.h"
#import <zhPopupController/zhPopupController.h>
#import "CGContractAddViewController.h"
#import "CGLeaseMattersAddViewController.h"
#import "CGBusinessMattersAddViewController.h"
#import "CGEditNotifyBacklogViewController.h"
@interface XTTabBarViewController () {
    XTTabBar *tabBar;
}

@property (nonatomic, strong) BaseNavigationController *navigationController;

@end

@implementation XTTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.backgroundColor = WHITE_COLOR;
    self.tabBar.barTintColor = WHITE_COLOR;
    
    //首页
    CGHomeViewController *homeView = [[CGHomeViewController alloc] init];
    homeView.tabBarItem.tag = 1;
    [self addChildController:homeView title:@"项目" imageName:@"tabbar_xiangmu_normal" selectedImageName:@"tabbar_xiangmu_selected"];
    
    //客户
    CGCustomerViewController *newsView = [[CGCustomerViewController alloc] init];
    newsView.tabBarItem.tag = 2;
    [self addChildController:newsView title:@"客户" imageName:@"tabbar_customer_normal" selectedImageName:@"tabbar_customer_selected"];
    
    //找资源
    CGFindViewController *quanziView = [[CGFindViewController alloc] init];
    quanziView.tabBarItem.tag = 3;
    [self addChildController:quanziView title:@"找资源" imageName:@"tabbar_find_normal" selectedImageName:@"tabbar_find_selected"];
    
    //我的
    CGMineViewController *mineView = [[CGMineViewController alloc] init];
    mineView.tabBarItem.tag = 4;
    [self addChildController:mineView title:@"我的" imageName:@"tabbar_mine_normal" selectedImageName:@"tabbar_mine_selected"];
    
    //设置自定义的tabbar
    [self setXTTabBar];
    
    //获取第一个控制器
    self.navigationController = (BaseNavigationController *)self.childViewControllers[0];
    
}

//设置定义按钮
- (void)setXTTabBar{
    tabBar = [[XTTabBar alloc]init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    [tabBar.btnCenter addTarget:self action:@selector(tabBarClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addChildController:(UIViewController *)vc title:(NSString *)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName {
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置一下选中tabbar文字颜色
    [vc.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : COLOR9 }forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : MAIN_COLOR } forState:UIControlStateSelected];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}

+ (void)initialize
{
    //设置未选中的TabBarItem的字体颜色、大小
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    //设置选中了的TabBarItem的字体颜色、大小
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:153.0/255.0 green:93.0/255.0 blue:176.0/255.0 alpha:1];
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"点击的item:%ld title:%@", item.tag, item.title);
    
    //获取当前控制器
    self.navigationController = (BaseNavigationController *)self.childViewControllers[item.tag-1];
}

- (void)tabBarClick:(UIButton *)btnSender {
    NSLog(@"点击了中间大按钮");
    
    WS(weakSelf);
    XTPopupFullView *full = [self fullView];
    full.didClickFullView = ^(XTPopupFullView * _Nonnull fullView) {
        [self.zh_popupController dismiss];
    };
    
    full.didClickItems = ^(XTPopupFullView *fullView, NSInteger index) {
        NSLog(@"您点击了:索引：%zd,%@",index,fullView.items[index].textLabel.text);
        self.zh_popupController.didDismiss = ^(zhPopupController * _Nonnull popupController) {
            
            //登录验证
            if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
            
            switch (index) {
                case 0: {
                    //招租事项
                    
                    CGLeaseMattersAddViewController *addView = [[CGLeaseMattersAddViewController alloc] init];
                    [weakSelf.navigationController pushViewController:addView animated:YES];
                    
                    break;
                }
                case 1: {
                    //新签合同
                    
                    CGContractAddViewController *addView = [[CGContractAddViewController alloc] init];
                    [weakSelf.navigationController pushViewController:addView animated:YES];
                    
                    break;
                }
                case 2: {
                    //经营事项
                    
                    CGBusinessMattersAddViewController *addView = [[CGBusinessMattersAddViewController alloc] init];
                    [weakSelf.navigationController pushViewController:addView animated:YES];
                    
                    break;
                }
                case 3: {
                    //添加提醒
                    CGEditNotifyBacklogViewController *addView =[[CGEditNotifyBacklogViewController alloc]init];
                    addView.title = @"添加提醒";
                    [weakSelf.navigationController pushViewController:addView animated:YES];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
        };
        
        [fullView endAnimationsCompletion:^(XTPopupFullView *fullView) {
            [self.zh_popupController dismiss];
        }];
    };
    
    self.zh_popupController = [zhPopupController popupControllerWithMaskType:zhPopupMaskTypeWhiteBlur];
    self.zh_popupController.allowPan = YES;
    [self.zh_popupController presentContentView:full];
    
}

- (XTPopupFullView *)fullView {
    
    XTPopupFullView *fullView = [[XTPopupFullView alloc] initWithFrame:self.view.frame];
    NSMutableArray *titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"tabbar_icon_lease",@"招租事项"]];
    [titleArr addObject:@[@"tabbar_icon_contact",@"新签合同"]];
    [titleArr addObject:@[@"tabbar_icon_business",@"经营事项"]];
    [titleArr addObject:@[@"tabbar_icon_tixing",@"添加提醒"]];
    
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:titleArr.count];
    for (int i=0; i<[titleArr count]; i++) {
        NSArray *itemArr = [titleArr objectAtIndex:i];
        zhIconLabelModel *item = [zhIconLabelModel new];
        item.icon = [UIImage imageNamed:itemArr[0]];
        item.text = itemArr[1];
        [models addObject:item];
    }
    fullView.models = models;
    return fullView;
}

@end
