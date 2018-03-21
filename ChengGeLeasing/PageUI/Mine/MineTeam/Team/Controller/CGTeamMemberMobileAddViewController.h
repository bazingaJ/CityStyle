//
//  CGTeamMemberMobileAddViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMineSearchBarView.h"
#import "CGMineTeamMemberMobileCell.h"
#import <MessageUI/MessageUI.h>

@interface CGTeamMemberMobileAddViewController : BaseTableViewController<CGMineSearchBarViewDelegate,CGMineTeamMemberMobileCellDelegate,MFMessageComposeViewControllerDelegate>

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSMutableArray *memberArr);
/**
 *  是否新建项目
 */
@property (nonatomic, assign) BOOL isAdd;
/**
 *  已选择数组
 */
@property (nonatomic, strong) NSMutableArray *selecteArr;

@end
