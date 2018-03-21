//
//  CGShopLeaseItemCell.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGShopBusinessMattersModel.h"
@interface CGShopLeaseItemCell : UITableViewCell

@property (nonatomic ,strong)CGShopBusinessMattersModel *model;
@property (nonatomic ,strong)NSIndexPath *indexPath;
@property (nonatomic, strong) void(^callBackRelodData)(void);
@property (nonatomic, strong) void (^callCollectionBack)(CGShopBusinessMattersIntentModel *intentModel  ,CGShopBusinessMattersHistoryListModel *historyModel ,CGShopBusinessMattersModel *matterModel,NSInteger tag);
-(void)setModel:(CGShopBusinessMattersModel *)model withIndexPath:(NSIndexPath *)indexPath;

@end
