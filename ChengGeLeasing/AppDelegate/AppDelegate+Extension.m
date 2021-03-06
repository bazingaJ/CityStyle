//
//  AppDelegate+Extension.m
//  Kivii
//
//  Created by 相约在冬季 on 2017/1/12.
//  Copyright © 2017年 Kivii. All rights reserved.
//

#import "AppDelegate+Extension.h"
#import "XTTabBarViewController.h"
#import <objc/runtime.h>
#import "HcdGuideView.h"
#import "AppDelegate+XHLaunchAd.h"

static const void *strLaunchSrcKey = &strLaunchSrcKey;

@implementation AppDelegate (Extension)

- (void)setLaunchSrc:(NSString *)launchSrc {
    objc_setAssociatedObject(self, & strLaunchSrcKey, launchSrc, OBJC_ASSOCIATION_COPY);
}

- (NSString *)launchSrc {
    return objc_getAssociatedObject(self, &strLaunchSrcKey);
}

/**
 *  设置Window和rootViewController
 */
- (void)setWindowAndRootViewController {
    
    //设置全局变量
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarTintColor:NAV_COLOR];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //[[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORM,NSForegroundColorAttributeName, nil]];
    //    NSDictionary *attributes = @{ NSFontAttributeName:FONT17,
    //                                  NSForegroundColorAttributeName:COLORM};
    //    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    //修改标题字体颜色及大小
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:FONT18, NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
    [WXApi registerApp:WetChatAppID];
    
    // 配置IQ键盘插件º
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable =YES;// 控制整个功能是否启用。
    manager.shouldResignOnTouchOutside =YES;//控制点击背景是否收起键盘
//    manager.shouldToolbarUsesTextFieldTintColor =YES;//控制键盘上的工具条文字颜色是否用户自定义
    manager.toolbarDoneBarButtonItemText =@"完成";//将右边Done改成完成
    manager.enableAutoToolbar =YES;// 控制是否显示键盘上的工具条
    manager.toolbarTintColor = NAV_COLOR;
    manager.toolbarManageBehaviour =IQAutoToolbarByTag;//最新版的设置键盘的returnKey的关键字 ,可以点击键盘上的next键，自动跳转到下一个输入框，最后一个输入框点击完成，自动收起键盘。
    
    //进入主界面
    [self enterMainVC];
    
    BOOL isShow = [HcdGuideView isShow];
    if(isShow) {
        //显示引导页
        NSMutableArray *imgArr = [NSMutableArray new];
        [imgArr addObject:[UIImage imageNamed:@"guide01"]];
        [imgArr addObject:[UIImage imageNamed:@"guide02"]];
        [imgArr addObject:[UIImage imageNamed:@"guide03"]];
        [imgArr addObject:[UIImage imageNamed:@"guide04"]];

        HcdGuideView *guideView = [HcdGuideView sharedInstance];
        guideView.window = self.window;
        [guideView showGuideViewWithImages:imgArr
                            andButtonTitle:@"立即体验"
                       andButtonTitleColor:[UIColor whiteColor]
                          andButtonBGColor:MAIN_COLOR
                      andButtonBorderColor:MAIN_COLOR];
    }else{
        //显示启动页
        //获取系统参数
        NSString *openSrc = [CGURLManager manager].open_img;
        [self setupXHLaunchAd:openSrc];
    }
    
}

//进入App主界面
- (void)enterMainVC {
    //进入主页入口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //创建“底部菜单”
    XTTabBarViewController *tabBarVC = [[XTTabBarViewController alloc] init];
//    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:tabBarVC];
//    nav.navigationBar.hidden = YES;
    self.window.rootViewController = tabBarVC;
    
    [self.window makeKeyAndVisible];
}

@end
