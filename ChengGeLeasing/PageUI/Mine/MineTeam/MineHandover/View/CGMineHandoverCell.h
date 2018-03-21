//
//  CGMineHandoverCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGTeamMemberModel.h"

@protocol CGMineHandoverCellDelegate <NSObject>

- (void)CGMineHandoverCellClick:(CGTeamMemberModel *)model;

@end

@interface CGMineHandoverCell : UITableViewCell

@property (assign) id<CGMineHandoverCellDelegate> delegate;
- (void)setTeamMemberModel:(CGTeamMemberModel *)model;

@end
