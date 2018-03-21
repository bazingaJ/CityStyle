//
//  CGMineTeamMemberListCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGTeamMemberModel.h"

@protocol CGMineTeamMemberListCellDelegate <NSObject>

- (void)CGMineTeamMemberTelClick:(NSString *)tel;

@end

@interface CGMineTeamMemberListCell : UITableViewCell

@property (assign) id<CGMineTeamMemberListCellDelegate> delegate;
- (void)setTeamMemberModel:(CGTeamMemberModel *)model indexPath:(NSIndexPath *)indexPath;

@end
