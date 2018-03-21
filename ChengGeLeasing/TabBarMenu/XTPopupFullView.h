//
//  XTPopupFullView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zhIconLabel.h"

#define ROW_COUNT 4 // 每行显示4个
#define ROWS 1      // 每页显示2行
#define PAGES 1     // 共2页

@interface XTPopupFullView : UIView

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, strong) NSArray<zhIconLabelModel *> *models;
@property (nonatomic, strong, readonly) NSMutableArray<zhIconLabel *> *items;

@property (nonatomic, copy) void (^didClickFullView)(XTPopupFullView *fullView);
@property (nonatomic, copy) void (^didClickItems)(XTPopupFullView *fullView, NSInteger index);

- (void)endAnimationsCompletion:(void (^)(XTPopupFullView *fullView))completion; // 动画结束后执行block

@end
