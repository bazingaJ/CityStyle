//
//  CGMineHandoverViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMineHandoverCell.h"

@interface CGMineHandoverViewController : BaseTableViewController<CGMineHandoverCellDelegate>

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;

@end
