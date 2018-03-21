//
//  CGMineTeamMemberMobileCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/16.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGTeamMemberModel.h"

@protocol CGMineTeamMemberMobileCellDelegate <NSObject>

- (void)CGMineTeamMemberMobileCellClick:(UIButton *)btnFunc model:(CGTeamMemberModel *)model;

@end

@interface CGMineTeamMemberMobileCell : UITableViewCell

@property (nonatomic, assign) BOOL isAdd;
@property (assign) id<CGMineTeamMemberMobileCellDelegate> delegate;
- (void)setTeamMemberModel:(CGTeamMemberModel *)model pro_id:(NSString *)pro_id;


@end
