//
//  CGMineTeamAreaCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGTeamAreaModel.h"

@protocol CGMineTeamAreaCellDelegate <NSObject>

- (void)CGMineTeamAreaCellClick:(CGTeamAreaModel *)model tIndex:(NSInteger)tIndex indexPath:(NSIndexPath *)indexPath;

@end

@interface CGMineTeamAreaCell : UITableViewCell

@property (assign) id<CGMineTeamAreaCellDelegate>delegate;
- (void)setTeamAreaModel:(CGTeamAreaModel *)model indexPath:(NSIndexPath *)indexPath;

@end
