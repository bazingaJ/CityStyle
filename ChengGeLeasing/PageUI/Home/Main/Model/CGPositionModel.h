//
//  CGPositionModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/15.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGHomePos_listModel.h"
@interface CGPositionModel : NSObject

/**
 * 区域ID
 */
@property (nonatomic ,strong) NSString *id;
/**
 * 区域名称
 */
@property (nonatomic ,strong) NSString *name;
/**
 * 本区域出租率
 */
@property (nonatomic ,strong) NSString *letting_rate;
/**
 * 本区域签约数量
 */
@property (nonatomic ,strong) NSString *sign_num;
/**
 * 本区域总数量
 */
@property (nonatomic ,strong) NSString *total_num;
/**
 * 本区域签约面积
 */
@property (nonatomic ,strong) NSString *sign_area;
/**
 * 本区域总面积
 */
@property (nonatomic ,strong) NSString *total_area;
/**
 * 区域内铺位列表
 */
@property (nonatomic ,strong) NSArray *pos_list;


@property (nonatomic ,strong) CGHomePos_listModel *homePos_listModel;
@end
