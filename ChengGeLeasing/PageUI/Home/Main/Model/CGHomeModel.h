//
//  CGHomeModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/11/27.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGLetDataModel.h"
#import "CGPositionModel.h"
#import "CGHomePos_listModel.h"
#import "CGHomeTrendsModel.h"

@interface CGHomeModel : NSObject
/**
 * 项目封面图
 */
@property (nonatomic ,strong) NSString *cover_url;
/**
 * 项目id
 */
@property (nonatomic ,strong) NSString *id;
/**
 * 项目名字
 */
@property (nonatomic ,strong) NSString *name;
/**
 * 签约百分比
 */
@property (nonatomic ,strong) NSString *sign_percent;
/**
 * 已租面积
 */
@property (nonatomic ,strong) NSString *total_sign_area;
/**
 * 已租面积
 */
@property (nonatomic ,strong) NSString *total_area;
/**
 * 经营动态
 */
@property (nonatomic ,strong) NSDictionary *trends;
/**
 * 招租数据
 */
@property (nonatomic ,strong) NSDictionary *letData;
/**
 * 铺位租控
 */
@property (nonatomic ,strong) NSArray *position;

@property (nonatomic ,strong) CGHomeTrendsModel *trendsModel;
@property (nonatomic ,strong) CGLetDataModel *letDataModel;
@property (nonatomic ,strong) CGPositionModel *positionModel;

@end
