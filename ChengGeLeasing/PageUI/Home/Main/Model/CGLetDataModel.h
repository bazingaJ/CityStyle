//
//  CGLetDataModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/15.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGLetDataModel : NSObject
/**
 * 铺位总数量
 */
@property (nonatomic ,strong) NSString *totalNum;
/**
 * 已租百分比
 */
@property (nonatomic ,strong) NSString *intentPercent;
/**
 * 待租无意向百分比
 */
@property (nonatomic ,strong) NSString *noIntentPercent;
/**
 * 已租百分比
 */
@property (nonatomic ,strong) NSString *signPercent;
/**
 * 已租数量
 */
@property (nonatomic ,strong) NSString *signNum;
/**
 * 已租面积
 */
@property (nonatomic ,strong) NSString *signArea;
/**
 * 待租有意向数量
 */
@property (nonatomic ,strong) NSString *intentNum;
/**
 * 待租有意向面积
 */
@property (nonatomic ,strong) NSString *intentArea;
/**
 * 待租无意向数量
 */
@property (nonatomic ,strong) NSString *noIntentNum;
/**
 * 待租无意向面积
 */
@property (nonatomic ,strong) NSString *noIntentArea;
@end
