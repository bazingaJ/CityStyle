//
//  CGMineReceiverCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGTeamMemberModel.h"

@protocol CGMineReceiverCellDelegate <NSObject>

- (void)CGMineReceiverCellClick:(CGTeamMemberModel *)model;

@end

@interface CGMineReceiverCell : UITableViewCell

@property (assign) id<CGMineReceiverCellDelegate> delegate;
- (void)setTeamMemberModel:(CGTeamMemberModel *)model;

@end
