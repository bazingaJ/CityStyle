//
//  CGCustomerInfoEditExViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGCustomerModel.h"

@interface CGCustomerInfoEditExViewController : BaseTableViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

/**
 *  客户对象
 */
@property (nonatomic, strong) CGCustomerModel *customerModel;
/**
 *  回调函数
 */
@property (nonatomic, strong) void(^callBack)(CGCustomerModel *customerInfo);

@end
