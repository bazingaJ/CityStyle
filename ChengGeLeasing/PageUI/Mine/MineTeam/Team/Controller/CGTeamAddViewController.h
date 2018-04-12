//
//  CGTeamAddViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGTeamAddViewController : BaseTableViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)();

@property (nonatomic, strong) NSString *account_id;

@end
