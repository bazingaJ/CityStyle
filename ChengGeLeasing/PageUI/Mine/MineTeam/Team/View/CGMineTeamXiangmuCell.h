//
//  CGMineTeamXiangmuCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGTeamXiangmuModel.h"
#import "SWTableViewCell.h"

@interface CGMineTeamXiangmuCell : SWTableViewCell

- (void)setTeamXiangmuModel:(CGTeamXiangmuModel *)model indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, assign) NSIndexPath *indexPath;

@end
