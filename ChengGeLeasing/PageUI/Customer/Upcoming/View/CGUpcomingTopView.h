//
//  CGUpcomingTopView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CGUpcomingTopViewDelegate <NSObject>

- (void)CGUpcomingTopViewClick:(NSInteger)tIndex;

@end

@interface CGUpcomingTopView : UIView

@property (assign) id<CGUpcomingTopViewDelegate> delegate;

@end
