//
//  CGLoginViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGLoginViewController : BaseTableViewController<UITextFieldDelegate>

/**
 *  登录回调
 */
@property (nonatomic, copy) void(^callback)(BOOL isLogin);

@end
