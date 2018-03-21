//
//  CGMineXiangmuCustomerViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGCustomerTopView.h"
#import "CGXiangmuCustomerCell.h"

@interface CGMineXiangmuCustomerViewController : BaseTableViewController<CGCustomerTopViewDelegate,SWTableViewCellDelegate>

@property (nonatomic, strong) CGCustomerTopView *topView;

@end
