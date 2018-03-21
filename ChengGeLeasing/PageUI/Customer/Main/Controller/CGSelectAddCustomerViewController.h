//
//  CGSelectAddCustomerViewController.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/19.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGSelectAddCustomerModel.h"

@interface CGSelectAddCustomerViewController : BaseTableViewController

@property (nonatomic, strong) NSString *pos_id;//商铺铺位

@property (nonatomic, assign) NSInteger type;//1招租事项 2新签合同 3经营事项 4添加提醒

@property (nonatomic, strong) void (^callBack)(CGSelectAddCustomerModel *model);

@end
