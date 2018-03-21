//
//  CGHomeTrendsModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/15.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGHomeTrendsModel : NSObject
/**
 * 空置数量
 */
@property (nonatomic ,strong) NSString *empty;
/**
 * 稳赢数量
 */
@property (nonatomic ,strong) NSString *profitNum;
/**
 * 预动数量
 */
@property (nonatomic ,strong) NSString *togoNum;
/**
 * 退铺告警数量
 */
@property (nonatomic ,strong) NSString *outNum;
@end
