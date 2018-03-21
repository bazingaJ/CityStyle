//
//  CGMineTeamGroupEditViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGTeamGroupModel.h"

@interface CGMineTeamGroupEditViewController : BaseTableViewController<UITextFieldDelegate>

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;
/**
 *  分组对象
 */
@property (nonatomic, strong) CGTeamGroupModel *groupModel;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)();

@end
