//
//  CGSearchBarView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CGSearchBarViewDelegate <NSObject>

- (void)CGSearchBarViewClick:(NSString *)searchStr;

@end

@interface CGSearchBarView : UIView<UITextFieldDelegate>

@property (assign) id<CGSearchBarViewDelegate> delegate;
@property (nonatomic, strong) UITextField *tbxContent;

@end
