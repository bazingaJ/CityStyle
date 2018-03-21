//
//  CGTeamBunkCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGBunkModel.h"

@protocol CGTeamBunkCellDelegate <NSObject>

- (void)CGTeamBunkCellClick:(CGBunkModel *)model tIndex:(NSInteger)tIndex indexPath:(NSIndexPath *)indexPath;

@end

@interface CGTeamBunkCell : UITableViewCell

@property (assign) id<CGTeamBunkCellDelegate> delegate;
- (void)setBunkModel:(CGBunkModel *)model indexPath:(NSIndexPath *)indexPath;

@end
