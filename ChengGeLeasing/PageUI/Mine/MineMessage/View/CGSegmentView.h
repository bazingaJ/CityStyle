//
//  CGSegmentView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CGSegmentViewDelegate <NSObject>

- (void)CGSegmentViewDidSelectAtIndexClick:(NSInteger)tIndex;

@end

@interface CGSegmentView : UIView

@property (assign)id<CGSegmentViewDelegate> delegate;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, assign) NSInteger selectedIndex;

@end
