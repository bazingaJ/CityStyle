//
//  CGUnitLeaseItemCollectionViewCell.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGShopBusinessMattersModel.h"
#import "CGShopBusinessMattersIntentModel.h"
#import "CGShopBusinessMattersHistoryListModel.h"
@interface CGUnitLeaseItemCollectionViewCell : UICollectionViewCell
-(void)setModel:(NSInteger)tag withIntentMode:(CGShopBusinessMattersIntentModel *)intentModel withHistoryListModel:(CGShopBusinessMattersHistoryListModel *)historyModel model:(CGShopBusinessMattersModel *)model;
@end
