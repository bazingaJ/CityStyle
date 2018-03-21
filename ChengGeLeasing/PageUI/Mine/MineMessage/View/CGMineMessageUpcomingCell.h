//
//  CGMineMessageUpcomingCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMineMessageUpcomingModel.h"
#import "SWTableViewCell.h"

@interface CGMineMessageUpcomingCell : SWTableViewCell

- (void)setMineMessageUpcomingModel:(CGMineMessageUpcomingModel *)model indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, assign) NSIndexPath *indexPath;

@end
