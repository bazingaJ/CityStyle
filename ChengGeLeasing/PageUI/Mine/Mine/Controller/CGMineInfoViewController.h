//
//  CGMineInfoViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGUserModel.h"

@interface CGMineInfoViewController : BaseTableViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

/**
 *  用户对象
 */
@property (nonatomic, strong) CGUserModel *userInfo;

/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(CGUserModel *model);


@end
