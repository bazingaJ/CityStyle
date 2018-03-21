//
//  CGFindBrandDetailViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/15.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGFindScrollViewCell.h"

@interface CGFindBrandDetailViewController : BaseTableViewController

/**
 *  资源客户ID
 */
@property (nonatomic, strong) NSString *find_id;
/**
 *  价格数组
 */
@property (nonatomic, strong) NSMutableArray *priceArr;
/**
 *  硬件数组
 */
@property (nonatomic, strong) NSMutableArray *hardwareArr;
/**
 *  竞争对手数组
 */
@property (nonatomic, strong) NSMutableArray *competeArr;
/**
 *  品牌数组
 */
@property (nonatomic, strong) NSMutableArray *brandArr;

@end
