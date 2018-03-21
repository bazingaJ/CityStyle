//
//  CGQuotationSheetView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGQuotationSheetView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) UIView *backView;
@property (assign, nonatomic) CGFloat yPosition;
@property (assign, nonatomic) NSInteger index;

- (void)show;
- (void)dismiss;
- (void)showAlert;

/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSString *unit_id, NSString *unit_name);

@end
