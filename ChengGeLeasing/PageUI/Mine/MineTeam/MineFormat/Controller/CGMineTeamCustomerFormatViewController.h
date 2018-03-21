//
//  CGMineTeamCustomerFormatViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMineFormatCell.h"
#import "CGMineFormatEditPopupView.h"

@interface CGMineTeamCustomerFormatViewController : BaseTableViewController<CGMineFormatCellDelegate>

@property (strong, nonatomic) KLCPopup *popup;

/**
 *  刷新客户列表
 */
- (void)reloadCustomerList;

@end
