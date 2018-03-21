//
//  CGSelectingReminderTimeViewController.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/21.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGSelectingReminderTimeViewController : BaseTableViewController

@property (nonatomic, strong) void(^callBack) (NSDictionary *dataDic);

@end
