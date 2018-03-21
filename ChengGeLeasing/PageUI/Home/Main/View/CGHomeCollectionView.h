//
//  CGHomeCollectionView.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/8/7.
//  Copyright © 2017年 田浩渺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGHomeCollectionViewCell.h"
#import "CGHomeModel.h"
@interface CGHomeCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *zoneArr;
@property (nonatomic, strong) CGHomeModel *model;
@property (nonatomic, copy) void (^callBack)(NSString *pos_id);
@property (nonatomic, copy) void (^callRegionalUnitState)(NSString *group_id, NSString *name);
//@property(nonatomic,strong)NSMutableArray *posArr;
@end
