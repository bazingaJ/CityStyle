//
//  CGVersionPopupView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGVersionPopupView;

@protocol CGVersionPopupViewDelegate <NSObject>

@optional

- (void)popupView:(CGVersionPopupView *)popupView withSender:(UIButton *)sender;
- (void)popupView:(CGVersionPopupView *)popupView dismissWithSender:(id)sender;

@end

@interface CGVersionPopupView : UIView

@property (assign) id<CGVersionPopupViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame param:(NSMutableDictionary *)param;

@end
