//
//  CGLeaseMattersModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGPositionExModel.h"
/**
 *  招租事项-模型
 */
@interface CGLeaseMattersModel : NSObject

/**
 *  招租事项ID
 */
@property (nonatomic, strong) NSString *id;
/**
 *  详情
 */
@property (nonatomic, strong) NSString *intro;
/**
 *  业务员名称
 */
@property (nonatomic, strong) NSString *user_name;
/**
 *  时间
 */
@property (nonatomic, strong) NSString *time;
/**
 *  行高
 */
@property (nonatomic, assign) CGFloat cellH;
/**
 *  客户ID
 */
@property (nonatomic, strong) NSString *cust_id;
/**
 *  客户名称
 */
@property (nonatomic, strong) NSString *cust_name;
/**
 * 是否可以重新选择铺位 1是2否 （签约之后不可修改已经选择的铺位）
 */
@property (nonatomic, strong) NSString *is_revise;
/**
 * 是否可以(仅仅可以)选择100% 1是2否 （仅仅90%的意向度才可以）
 */
@property (nonatomic, strong) NSString *is_can_hundred;
/**
 *  意向度名称
 */
@property (nonatomic, strong) NSString *intent_name;
/**
 *  已选择铺位列表
 */
@property (nonatomic, strong) NSArray *choose_pos_list;
/**
 *  已选择铺位id
 */
@property (nonatomic, strong) NSString *pos_id;
/**
 *  联系人ID
 */
@property (nonatomic, strong) NSString *linkman_id;
/**
 *  联系人名称
 */
@property (nonatomic, strong) NSString *linkman_name;
/**
 *  联系人电话
 */
@property (nonatomic, strong) NSString *linkman_mobile;
/**
 *  意向铺位ID(多个逗分隔)
 */
@property (nonatomic, strong) NSString *pos_ids;
/**
 *  意向铺位名称
 */
@property (nonatomic, strong) NSString *pos_name;
/**
 *  意向度
 */
@property (nonatomic, strong) NSString *intent;
/**
 *  铺位数组
 */
@property (nonatomic, strong) NSArray *position;
/**
 *  附件
 */
@property (nonatomic, strong) NSMutableArray *images;

@end
