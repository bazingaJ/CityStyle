//
//  CGMineFormatCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGFormatModel.h"

@protocol CGMineFormatCellDelegate <NSObject>

- (void)CGMineFormatCellClick:(CGFormatModel *)model tIndex:(NSInteger)tIndex indexPath:(NSIndexPath *)indexPath;

@end

@interface CGMineFormatCell : UITableViewCell

@property (assign) id<CGMineFormatCellDelegate> delegate;
- (void)setMineFormatModel:(CGFormatModel *)model indexPath:(NSIndexPath *)indexPath;

@end
