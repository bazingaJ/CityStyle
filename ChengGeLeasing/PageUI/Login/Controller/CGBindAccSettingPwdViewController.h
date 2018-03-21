//
//  CGBindAccSettingPwdViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGBindAccSettingPwdViewController : BaseTableViewController<UITextFieldDelegate>

@property (nonatomic, strong) NSString *mobileStr;
@property (nonatomic, strong) NSString *codeStr;
@property (nonatomic, strong) NSString *typeStr;
@property (nonatomic, strong) NSString *union_id;

@end
