//
//  CGMineTransferCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGTeamMemberModel.h"

@protocol CGMineTransferCellDelegate <NSObject>

- (void)CGMineTransferCellClick:(CGTeamMemberModel *)model;

@end

@interface CGMineTransferCell : UITableViewCell

@property (assign) id<CGMineTransferCellDelegate> delegate;
- (void)setCustomerModel:(CGTeamMemberModel *)model;

@end
