//
//  CGMineTopView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGUserModel.h"

// 我的-topViewHeight
extern const CGFloat JXMineHeaderViewHeight;

@protocol CGMineTopViewDelegate <NSObject>

- (void)CGMineTopViewEditInfoClick:(NSInteger)tIndex;

- (void)showXuFeiWindow;

- (void)showUpdateWindow;



@end

@interface CGMineTopView : UIView

@property (assign) id<CGMineTopViewDelegate> delegate;

@property (nonatomic, strong) UIView *freeView;
@property (nonatomic, strong) UIView *vipView;

- (void)setMineTopModel:(CGUserModel *)model;
- (void)createAccoutSign;
@end
