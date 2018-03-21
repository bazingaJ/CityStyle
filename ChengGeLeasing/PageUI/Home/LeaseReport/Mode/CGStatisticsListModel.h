//
//  CGStatisticsListModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGStatisticsListModel : NSObject
/**
 * 业态id
 */
@property (nonatomic, strong) NSString *id;
/**
 * 业态名称
 */
@property (nonatomic, strong) NSString *name;
/**
 * 数量
 */
@property (nonatomic, strong) NSString *count;
/**
 * 百分比
 */
@property (nonatomic, strong) NSString *ratio;
@end
