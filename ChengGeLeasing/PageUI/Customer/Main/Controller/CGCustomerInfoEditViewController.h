//
//  CGCustomerInfoEditViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGCustomerModel.h"

@interface CGCustomerInfoEditViewController : BaseTableViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

/**
 *  客户对象
 */
@property (nonatomic, strong) CGCustomerModel *customerModel;
/**
 *  回调函数
 */
@property (nonatomic, strong) void(^callBack)(CGCustomerModel *customerInfo);

@end
