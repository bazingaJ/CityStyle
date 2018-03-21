//
//  CGRegionalDistributionHeadView.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHRingChart.h"
@interface CGRegionalDistributionHeadView : UIView

@property (nonatomic, weak) JHRingChart* ringChart;

@property (nonatomic, strong) NSDictionary *dataDic;

@end
