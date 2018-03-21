//
//  CGCustomerExTopView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGSearchBarView.h"
#import "CGDropDownMenu.h"

@protocol CGCustomerTopViewDelegate <NSObject>

- (void)CGCustomerTopViewSearchBarViewClick:(NSString *)searchStr;
- (void)CGCustomerTopViewAZSelectClick:(NSString *)letterStr;
- (void)CGCustomerTopViewIntentionSelectClick:(NSString *)intentionStr;
- (void)CGCustomerTopViewFormatSelectClick:(NSString *)formatId;
- (void)CGCustomerTopViewTeamMemberSelectClick:(NSString *)member_id;

@end

@interface CGCustomerExTopView : UIView<CGSearchBarViewDelegate>

@property (assign) id<CGCustomerTopViewDelegate> delegate;
@property (nonatomic, strong) CGSearchBarView *searchView;

/**
 *  筛选控件
 */
@property (nonatomic, strong) CGDropDownMenu *dropDownMenu;
/**
 *  客户资源数
 */
@property (nonatomic, strong) NSString *customerNum;
/**
 *  我的客户数
 */
@property (nonatomic, strong) NSString *mineNum;
/**
 *  隐藏
 */
- (void)dismiss;

@end
