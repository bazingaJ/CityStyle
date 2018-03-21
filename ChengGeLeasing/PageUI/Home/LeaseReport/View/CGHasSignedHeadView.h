//
//  CGHasSignedHeadView.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHRingChart.h"
@interface CGHasSignedHeadView : UIView

@property (nonatomic, weak) JHRingChart* ringChart;

@property (nonatomic, strong) NSArray *colorArr;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *temColoarr;
@end
