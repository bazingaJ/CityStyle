//
//  CGCustomerXiangmuView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGCustomerXiangmuView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

- (id)initWithFrame:(CGRect)frame titleStr:(NSString *)titleStr;

@property (strong, nonatomic) UIView *backView;
@property (assign, nonatomic) CGFloat yPosition;
@property (assign, nonatomic) NSInteger index;

- (void)show;
- (void)dismiss;
- (void)showAlert;

/**
 *  获取项目数据源
 */
- (void)getXiangmuList;

/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSString *pro_id,NSString *pro_name);

@end
