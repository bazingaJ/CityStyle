//
//  CGPositionExModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/21.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGPositionExModel : NSObject
/**
 * 区域ID
 */
@property (nonatomic, strong) NSString *id;
/**
 * 区域名称
 */
@property (nonatomic, strong) NSString *name;
/**
 * 包含的铺位列表
 */
@property (nonatomic, strong) NSArray *pos_list;
@end

@interface CGPositionPosListModel : NSObject
/**
 * 铺位ID
 */
@property (nonatomic, strong) NSString *pos_id;
/**
 * 铺位名称
 */
@property (nonatomic, strong) NSString *pos_name;
/**
 * 铺位面积
 */
@property (nonatomic, strong) NSString *pos_area;
/**
 * 铺位状态 1无意向 2有意向 3已签约 4已付款
 */
@property (nonatomic, strong) NSString *pos_status;
/**
 * 是否已经选中
 */
@property (nonatomic, strong) NSString *is_choose;
@end
