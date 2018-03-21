//
//  CGContractTypeSheetView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGContractTypeSheetView : UIView<UITableViewDataSource,UITableViewDelegate>

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
@property (nonatomic, copy) void(^callBack)(NSString *type_id,NSString *type_name);


@end
