//
//  CGChubeiCustomerTopView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGSearchBarView.h"
#import "CGDropDownMenu.h"

@protocol CGCustomerTopViewDelegate <NSObject>

- (void)CGCustomerTopViewSearchBarViewClick:(NSString *)searchStr;
- (void)CGCustomerTopViewAZSelectClick:(NSString *)letterStr;
- (void)CGCustomerTopViewFormatSelectClick:(NSString *)formatId;

@end

@interface CGChubeiCustomerTopView : UIView<CGSearchBarViewDelegate>

@property (assign) id<CGCustomerTopViewDelegate> delegate;
@property (nonatomic, strong) CGSearchBarView *searchView;

/**
 *  筛选控件
 */
@property (nonatomic, strong) CGDropDownMenu *dropDownMenu;
/**
 *  隐藏
 */
- (void)dismiss;

@end

