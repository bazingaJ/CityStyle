//
//  CGLocalVideoListViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/27.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGLocalVideoModel.h"

@interface CGLocalVideoListViewController : BaseTableViewController

/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(CGLocalVideoModel *model);

@end
