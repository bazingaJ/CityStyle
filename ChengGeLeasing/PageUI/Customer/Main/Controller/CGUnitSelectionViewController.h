//
//  CGUnitSelectionViewController.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGPositionExModel.h"
@interface CGUnitSelectionViewController : BaseViewController

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) void (^callBack)(NSString *pos_id, NSString *pos_name,NSString *pos_area);
@end
