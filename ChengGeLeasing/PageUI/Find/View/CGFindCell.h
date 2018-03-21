//
//  CGFindCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGFindModel.h"
#import "SWTableViewCell.h"

@interface CGFindCell : SWTableViewCell

- (void)setFindModel:(CGFindModel *)model indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, assign) NSIndexPath *indexPath;

@end
