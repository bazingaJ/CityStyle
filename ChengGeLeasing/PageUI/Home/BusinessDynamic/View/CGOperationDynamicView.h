//
//  CGOperationDynamicView.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGOperationDynamicModel.h"
#import "JHRingChart.h"
@interface CGOperationDynamicView : UIView

@property (nonatomic ,strong) CGOperationDynamicModel *model;

@property (nonatomic ,strong) JHRingChart *ringChart;

@end
