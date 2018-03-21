//
//  CGHomeCell.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/11/27.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGHomeModel.h"
#import "JHRingChart.h"

@class CGHomeCell;
@protocol CGHomeCellDelegate <NSObject>

//经营状态代理方法
-(void)CGHomeCell:(CGHomeCell *)cell withGoToUnit:(UIButton *)sender;

//查看招租报表代理方法
-(void)CGHomeCell:(CGHomeCell *)cell showTable:(UIButton *)sender;

-(void)CGHomeCellProjectNetworkLocation;

@end
@interface CGHomeCell : UITableViewCell

@property (nonatomic ,strong) CGHomeModel *model;
@property (nonatomic ,strong) NSIndexPath *indexPath;

@property(nonatomic,assign)id <CGHomeCellDelegate>delegate;
@property(nonatomic,weak)JHRingChart* ringChart;

-(void)setModel:(CGHomeModel *)model withIndexPath:(NSIndexPath *)indexPath;

@end
