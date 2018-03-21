//
//  CGLinkmanCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGLinkmanModel.h"

@protocol CGLinkmanCellDelegate <NSObject>

- (void)CGLinkmanCellEditClick:(CGLinkmanModel *)model indexPath:(NSIndexPath *)indexPath;

@end

@interface CGLinkmanCell : UITableViewCell

@property (assign) id<CGLinkmanCellDelegate> delegate;
- (void)setLinkmanModel:(CGLinkmanModel *)model indexPath:(NSIndexPath *)indexPath;

@end
