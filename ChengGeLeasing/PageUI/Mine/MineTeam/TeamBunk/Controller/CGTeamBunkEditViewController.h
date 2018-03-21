//
//  CGTeamBunkEditViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGBunkModel.h"

@interface CGTeamBunkEditViewController : BaseTableViewController<UITextFieldDelegate>

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;
/**
 *  铺位ID
 */
@property (nonatomic, strong) NSString *pos_id;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)();

@end
