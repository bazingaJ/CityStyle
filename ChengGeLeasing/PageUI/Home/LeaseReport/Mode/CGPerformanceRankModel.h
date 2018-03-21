//
//  CGPerformanceRankModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/19.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGPerformanceRankModel : NSObject
/**
 * 总面积
 */
@property (nonatomic, strong) NSString *totalArea;
/**
 * totalNum
 */
@property (nonatomic, strong) NSString *totalNum;
/**
 * 列表
 */
@property (nonatomic, strong) NSArray *list;

@end

@interface CGPerformanceRankListModel : NSObject
/**
 * 名称
 */
@property (nonatomic, strong) NSString *name;
/**
 * 面积
 */
@property (nonatomic, strong) NSString *area;
/**
 * 数量
 */
@property (nonatomic, strong) NSString *num;
/**
 *  排名对比(1不变 2上升 3下降)
 */
@property (nonatomic, strong) NSString *ratio;

@end
