//
//  CGNetdiscCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/27.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGNetdiscModel.h"
#import "SWTableViewCell.h"

@interface CGNetdiscCell : SWTableViewCell

- (void)setNetdiscModel:(CGNetdiscModel *)model indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, assign) NSIndexPath *indexPath;

@end
