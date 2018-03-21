//
//  CGUpcomingCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMineMessageUpcomingModel.h"
#import "SWTableViewCell.h"

@interface CGUpcomingCell : SWTableViewCell

- (void)setUpcomingModel:(CGMineMessageUpcomingModel *)model indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, assign) NSIndexPath *indexPath;

@end
