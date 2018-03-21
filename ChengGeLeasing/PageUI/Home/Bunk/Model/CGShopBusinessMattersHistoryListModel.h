//
//  CGShopBusinessMattersHistoryListModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/19.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGShopBusinessMattersHistoryListModel : NSObject
/**
 * 客户ID
 */
@property (nonatomic, strong) NSString *id;
/**
 * 客户名称
 */
@property (nonatomic, strong) NSString *name;
/**
 * 首字母
 */
@property (nonatomic, strong) NSString *first_letter;
/**
 * 业态ID
 */
@property (nonatomic, strong) NSString *cate_id;
/**
 * 业态名称
 */
@property (nonatomic, strong) NSString *cate_name;
/**
 * logo
 */
@property (nonatomic, strong) NSString *logo;
/**
 * 合同开始时间
 */
@property (nonatomic, strong) NSString *sing_start_time;
/**
 * 合同结束时间
 */
@property (nonatomic, strong) NSString *sing_end_time;
/**
 * 是否是自己
 */
@property (nonatomic, strong) NSString *is_own;
/**
 * 意向度
 */
@property (nonatomic, strong) NSString *intent;

@end
