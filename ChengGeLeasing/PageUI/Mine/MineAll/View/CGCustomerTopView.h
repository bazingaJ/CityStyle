//
//  CGCustomerTopView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGSearchBarView.h"
#import "CGDropDownMenu.h"

@protocol CGCustomerTopViewDelegate <NSObject>

- (void)CGCustomerTopViewSearchBarViewClick:(NSString *)searchStr;
- (void)CGCustomerTopViewAZSelectClick:(NSString *)letterStr;
- (void)CGCustomerTopViewFormatSelectClick:(NSString *)formatId;
- (void)CGCustomerTopViewTeamXiangmuSelectClick:(NSString *)pro_id;

@end

@interface CGCustomerTopView : UIView<CGSearchBarViewDelegate>

@property (assign) id<CGCustomerTopViewDelegate> delegate;
@property (nonatomic, strong) CGSearchBarView *searchView;

- (id)initWithFrame:(CGRect)frame isXiangmu:(BOOL)isXiangmu;

/**
 *  筛选控件
 */
@property (nonatomic, strong) CGDropDownMenu *dropDownMenu;
/**
 *  客户资源数
 */
@property (nonatomic, strong) NSString *customerNum;
/**
 *  隐藏
 */
- (void)dismiss;

@end
