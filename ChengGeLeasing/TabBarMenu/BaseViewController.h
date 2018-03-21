//
//  BaseViewController.h
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (assign, nonatomic) BOOL leftButtonItemHidden;
@property (assign, nonatomic) BOOL rightButtonItemShow;
@property (strong, nonatomic) NSString *leftButtonItemTitle;
@property (strong, nonatomic) NSString *rightButtonItemTitle;
@property (strong, nonatomic) NSString *leftButtonItemImageName;
@property (strong, nonatomic) NSString *rightButtonItemImageName;

- (void)leftButtonItemClick;
- (void)rightButtonItemClick;

/**
 *  存储本地用户信息
 */
- (void)setUserDefaultInfo:(NSDictionary *)userDic;

/**
 *  设置当前选择的项目ID
 */
- (void)setXiangmuID:(NSString *)proId proName:(NSString *)proName;

@end
