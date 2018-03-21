//
//  CGContractTerminateViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPhotoPickerBrowserViewController.h"

@interface CGContractTerminateViewController : BaseTableViewController<UIGestureRecognizerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate>

/**
 *  合同ID
 */
@property (nonatomic, strong) NSString *contract_id;

/**
 *  imagePicker队列
 */
@property (nonatomic, strong) NSMutableArray *imagePickerArray;
/**
 *  添加图片按钮
 */
@property (nonatomic, strong) UIButton *btnAdd;
/**
 *  源文件数组
 */
@property (nonatomic, strong) NSMutableArray *assetsArr;
/**
 *  图片数组集合
 */
@property (nonatomic, strong) NSMutableArray *photosArr;
/**
 *  多行输入控件
 */
@property (nonatomic, strong) CGLimitTextView *textView;

@end
