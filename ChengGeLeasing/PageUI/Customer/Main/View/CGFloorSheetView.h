//
//  CGFloorSheetView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/25.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGFloorSheetView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *itemArr;

- (id)initWithFrame:(CGRect)frame titleStr:(NSString *)titleStr;

@property (strong, nonatomic) UIView *backView;
@property (assign, nonatomic) CGFloat yPosition;
@property (assign, nonatomic) NSInteger index;

- (void)show;
- (void)dismiss;
- (void)showAlert;

/**
 *  是否可以多选
 */
@property (nonatomic, assign) BOOL isMultiple;
/**
 *  获取数据源
 */
- (void)getFloorList;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSString *floorId, NSString *floorName);


@end
