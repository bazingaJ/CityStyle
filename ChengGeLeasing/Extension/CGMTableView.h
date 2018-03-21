//
//  CGMTableView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/25.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGMTableView;

@protocol JXMovableCellTableViewDataSource <UITableViewDataSource>

@required
/**
 *  获取tableView的数据源数组
 */
- (NSArray *)dataSourceArrayInTableView:(CGMTableView *)tableView;
/**
 *  返回移动之后调换后的数据源
 */
- (void)tableView:(CGMTableView *)tableView newDataSourceArrayAfterMove:(NSArray *)newDataSourceArray;

@end

@protocol JXMovableCellTableViewDelegate <UITableViewDelegate>
@optional
/**
 *  将要开始移动indexPath位置的cell
 */
- (void)tableView:(CGMTableView *)tableView willMoveCellAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  完成一次从fromIndexPath cell到toIndexPath cell的移动
 */
- (void)tableView:(CGMTableView *)tableView didMoveCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;
/**
 *  结束移动cell在indexPath
 */
- (void)tableView:(CGMTableView *)tableView endMoveCellAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CGMTableView : UITableView

@property (nonatomic, weak) id<JXMovableCellTableViewDataSource> dataSource;
@property (nonatomic, weak) id<JXMovableCellTableViewDelegate> delegate;
/**
 *  长按手势最小触发时间，默认1.0，最小0.2
 */
@property (nonatomic, assign) CGFloat gestureMinimumPressDuration;
/**
 *  自定义可移动cell的截图样式
 */
@property (nonatomic, copy) void(^drawMovalbeCellBlock)(UIView *movableCell);
/**
 *  是否允许拖动到屏幕边缘后，开启边缘滚动，默认YES
 */
@property (nonatomic, assign) BOOL canEdgeScroll;
/**
 *  边缘滚动触发范围，默认150，越靠近边缘速度越快
 */
@property (nonatomic, assign) CGFloat edgeScrollRange;

@end
