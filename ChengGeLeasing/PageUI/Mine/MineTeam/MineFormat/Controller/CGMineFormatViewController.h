//
//  CGMineFormatViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMineFormatCell.h"
#import "CGMineFormatEditPopupView.h"

@interface CGMineFormatViewController : BaseTableViewController<CGMineFormatCellDelegate>

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;

@property (strong, nonatomic) KLCPopup *popup;

@end
