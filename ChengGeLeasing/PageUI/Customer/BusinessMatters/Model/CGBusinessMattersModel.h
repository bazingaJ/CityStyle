//
//  CGBusinessMattersModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGBusinessMattersModel : NSObject

/**
 *  经营事项-模型
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
 *  客户LOGO
 */
@property (nonatomic, strong) NSString *cust_logo;
/**
 *  客户首字母
 */
@property (nonatomic, strong) NSString *first_letter;
/**
 *  客户首字母(第二种写法)
 */
@property (nonatomic, strong) NSString *cust_first_letter;
/**
 *  联系人ID
 */
@property (nonatomic, strong) NSString *linkman_id;
/**
 *  联系人名称
 */
@property (nonatomic, strong) NSString *linkman_name;
/**
 *  经营状态：1空置 2稳赢 3预动 4退铺
 */
@property (nonatomic, strong) NSString *status;
/**
 *  经营状态名称
 */
@property (nonatomic, strong) NSString *status_name;
/**
 *  详情
 */
@property (nonatomic, strong) NSString *intro;
/**
 *  添加时间
 */
@property (nonatomic, strong) NSString *add_time;
/**
 *  添加时间(第二种写法)
 */
@property (nonatomic, strong) NSString *add_date;
/**
 * 已选择铺位ID
 */
@property (nonatomic, strong) NSString *pos_id;
/**
 *  签约铺位名称
 */
@property (nonatomic, strong) NSString *pos_name;
/**
 *  签约铺位ID(多个逗分隔)
 */
@property (nonatomic, strong) NSString *pos_ids;
/**
 *  已选择铺位列表
 */
@property (nonatomic, strong) NSArray *pos_list;
/**
 *  附件
 */
@property (nonatomic, strong) NSMutableArray *images;
/**
 *  行高
 */
@property (nonatomic, assign) CGFloat cellH;

@end
