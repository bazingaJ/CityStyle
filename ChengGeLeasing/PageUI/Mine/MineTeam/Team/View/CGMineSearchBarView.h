//
//  CGMineSearchBarView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CGMineSearchBarViewDelegate <NSObject>

- (void)CGMineSearchBarViewClick:(NSString *)searchStr;

@end

@interface CGMineSearchBarView : UIView<UISearchBarDelegate>

@property (assign) id<CGMineSearchBarViewDelegate> delegate;
@property (nonatomic, strong) UISearchBar *searchBar;

@end
