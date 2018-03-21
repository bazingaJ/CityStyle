//
//  CGLeaseRank_InfoModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGLeaseRank_InfoModel : NSObject
/**
 * 面积第一名
 */
@property (nonatomic, strong) NSDictionary *area;
/**
 * 数量第一名
 */
@property (nonatomic, strong) NSDictionary *num;
/**
 * 25%第一名
 */
@property (nonatomic, strong) NSDictionary *intent25;
/**
 * 40%第一名
 */
@property (nonatomic, strong) NSDictionary *intent40;
/**
 * 60%第一名
 */
@property (nonatomic, strong) NSDictionary *intent60;
@end
