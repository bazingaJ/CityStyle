//
//  CGMineTeamNameEditViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGTeamXiangmuModel.h"

@interface CGMineTeamNameEditViewController : BaseTableViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;
/**
 *  项目对象
 */
@property (nonatomic, strong) CGTeamXiangmuModel *xiangmuModel;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(CGTeamXiangmuModel *model);

@end
