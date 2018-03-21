//
//  CGContractModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGPositionExModel.h"
/**
 *  合同-模型
 */
@interface CGContractModel : NSObject

/**
 *  合同ID
 */
@property (nonatomic, strong) NSString *id;
/**
 *  客户ID
 */
@property (nonatomic, strong) NSString *cust_id;
/**
 *  客户名称
 */
@property (nonatomic, strong) NSString *cust_name;
/**
 *  铺位ID
 */
@property (nonatomic, strong) NSString *pro_id;
/**
 *  铺位名称
 */
@property (nonatomic, strong) NSString *pro_name;
/**
 *  铺位ID(多个逗号分隔)
 */
@property (nonatomic, strong) NSString *pos_ids;
/**
 *  铺位名称
 */
@property (nonatomic, strong) NSString *pos_name;
/**
 *  签约面积
 */
@property (nonatomic, strong) NSString *area;
/**
 *  开始时间
 */
@property (nonatomic, strong) NSString *start_time;
/**
 *  结束时间
 */
@property (nonatomic, strong) NSString *end_time;
/**
 *  合作方式:1纯租金 2纯扣点 3保底租金+扣点取其高 4自营
 */
@property (nonatomic, strong) NSString *manner;
/**
 *  合作方式名称
 */
@property (nonatomic, strong) NSString *manner_name;
/**
 *  租金
 */
@property (nonatomic, strong) NSString *rental;
/**
 *  租金单位
 */
@property (nonatomic, strong) NSString *rental_unit;
/**
 *  租金单位名称
 */
@property (nonatomic, strong) NSString *rental_unit_name;
/**
 *  扣点
 */
@property (nonatomic, strong) NSString *deduct;
/**
 *  物业管理费
 */
@property (nonatomic, strong) NSString *expenses;
/**
 *  物业管理费单位
 */
@property (nonatomic, strong) NSString *expenses_unit;
/**
 *  物业管理费单位名称
 */
@property (nonatomic, strong) NSString *expenses_unit_name;
/**
 *  租金递增方式
 */
@property (nonatomic, strong) NSString *rent_increase;
/**
 *  备注信息
 */
@property (nonatomic, strong) NSString *note;
/**
 *  业务员ID
 */
@property (nonatomic, strong) NSString *user_id;
/**
 *  业务员名称
 */
@property (nonatomic, strong) NSString *user_name;

/**
 *  合同状态值: 1正常合同期 2到期终止 3提前终止
 */
@property (nonatomic, strong) NSString *status;
/**
 *  合同状态名称
 */
@property (nonatomic, strong) NSString *status_name;
/**
 *  附件
 */
@property (nonatomic, strong) NSMutableArray *images;
/**
 *  终止类型:1协商一直 2单方面终止
 */
@property (nonatomic, strong) NSString *destroy_type;
/**
 *  终止详情
 */
@property (nonatomic, strong) NSString *destroy_note;
/**
 *  终止时上传的附件 
 */
@property (nonatomic, strong) NSMutableArray *destroy_images;
/**
 *  单元格高度(递增方式)
 */
@property (nonatomic, assign) CGFloat cellH;
/**
 *  单元格高度(备注信息)
 */
@property (nonatomic, assign) CGFloat cellH2;
/**
 *  单元格高度(终止详情)
 */
@property (nonatomic, assign) CGFloat cellH3;
/**
 * 铺位数组
 */
@property (nonatomic, strong) NSArray *position;
/**
 * 选择的铺位数组
 */
@property (nonatomic, strong) NSArray *choose_pos_list;
/**
 * 递增信息(自定义)
 */
@property (nonatomic, strong) NSString *diZengXinXi;

@end
