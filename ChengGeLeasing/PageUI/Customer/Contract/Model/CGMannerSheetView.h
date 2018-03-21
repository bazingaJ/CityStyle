//
//  CGMannerSheetView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/21.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGMannerSheetView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (strong, nonatomic) UIView *backView;
@property (assign, nonatomic) CGFloat yPosition;
@property (assign, nonatomic) NSInteger index;

- (void)show;
- (void)dismiss;
- (void)showAlert;

/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSString *manner_id,NSString *manner_name);

@end
