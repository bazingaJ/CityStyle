//
//  CGShopBusinessMattersCell.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGShopBusinessMattersModel.h"
@interface CGShopBusinessMattersCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) CGShopBusinessMattersModel *model;
@property (nonatomic, strong) void(^callBackRelodData)(void);
@property (nonatomic, strong) void(^callBackHistory) (CGShopBusinessMattersHistoryListModel *historyModel);
-(void)setModel:(CGShopBusinessMattersModel *)model withIndexPath:(NSIndexPath *)indexPath;

@end
