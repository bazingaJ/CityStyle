//
//  CGLinkmanSelectionViewController.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGLinkmanModel.h"
@interface CGLinkmanSelectionViewController : BaseTableViewController

@property (nonatomic, strong) NSString *cust_id;

@property (nonatomic, strong) void(^callBack)(CGLinkmanModel *model);

@end
