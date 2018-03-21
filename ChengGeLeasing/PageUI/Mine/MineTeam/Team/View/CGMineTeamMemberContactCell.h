//
//  CGMineTeamMemberContactCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGContactModel.h"

@protocol CGMineTeamMemberContactCellDelegate <NSObject>

- (void)CGMineTeamMemberContactCellClick:(UIButton *)btnFunc model:(CGContactModel *)model;

@end

@interface CGMineTeamMemberContactCell : UITableViewCell

@property (nonatomic, assign) BOOL isAdd;
@property (assign) id<CGMineTeamMemberContactCellDelegate> delegate;
- (void)setContactModel:(CGContactModel *)model pro_id:(NSString *)pro_id;

@end
