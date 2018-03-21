//
//  BaseViewController.m
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import "BaseViewController.h"
#import "XTBarButtonItem.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.backgroundColor = [UIColor whiteColor];
    if(!self.leftButtonItemHidden) {
        XTBarButtonItem *leftButtonItem = [XTBarButtonItem itemWithTitle:_leftButtonItemTitle
                                                                   image:_leftButtonItemImageName
                                                                   Style:SNNavItemStyleLeft
                                                                  target:self
                                                                  action:@selector(leftButtonItemClick)];
        self.navigationItem.leftBarButtonItem = leftButtonItem;
    }
    
    if(self.rightButtonItemShow || _rightButtonItemTitle || _rightButtonItemImageName) {
        XTBarButtonItem *rightButtonItem = [XTBarButtonItem itemWithTitle:_rightButtonItemTitle
                                                                    image:_rightButtonItemImageName
                                                                    Style:SNNavItemStyleRight
                                                                   target:self
                                                                   action:@selector(rightButtonItemClick)];
        self.navigationItem.rightBarButtonItem = rightButtonItem;
    }

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if(IOS_VERSION>=7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.navigationController.navigationBar.translucent = NO;
        [UIApplication sharedApplication].statusBarHidden = NO;
    }

}

/**
 *  点击左侧按钮
 */
- (void)leftButtonItemClick {
    NSLog(@"您点击了左侧按钮");
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  点击右侧按钮
 */
- (void)rightButtonItemClick {
    NSLog(@"您点击了右侧按钮");
}

/**
 *  存储本地用户信息
 */
- (void)setUserDefaultInfo:(NSDictionary *)userDic {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setValue:[userDic objectForKey:@"token"] forKey:@"token"];
    [userInfo setValue:[userDic objectForKey:@"user_id"] forKey:@"user_id"];
    [userInfo setValue:[userDic objectForKey:@"mobile"] forKey:@"mobile"];
    [userInfo setValue:[userDic objectForKey:@"nickname"] forKey:@"nickname"];
    [userInfo setValue:[userDic objectForKey:@"avatar"] forKey:@"avatar"];
    [userInfo setValue:[userDic objectForKey:@"gender"] forKey:@"gender"];
    [userInfo setValue:[userDic objectForKey:@"gender_name"] forKey:@"gender_name"];
    [userInfo setValue:[userDic objectForKey:@"email"] forKey:@"email"];
    [userDefault setObject:userInfo forKey:@"userInfo"];
    [userDefault synchronize];
}

/**
 *  设置当前选择的项目ID
 */
- (void)setXiangmuID:(NSString *)proId proName:(NSString *)proName {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:proId forKey:@"proId"];
    [userDefault setObject:proName forKey:@"proName"];
    [userDefault synchronize];
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
