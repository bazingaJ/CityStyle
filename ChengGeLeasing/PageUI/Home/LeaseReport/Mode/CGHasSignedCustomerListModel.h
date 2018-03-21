//
//  CGHasSignedCustomerListModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGHasSignedCustomerListModel : NSObject
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
 * 签约时间
 */
@property (nonatomic, strong) NSString *sing_date;
/**
 * 区域id
 */
@property (nonatomic, strong) NSString *group_id;
/**
 * 区域名称
 */
@property (nonatomic, strong) NSString *group_name;
/**
 * 区域名称(第二种写法)
 */
@property (nonatomic, strong) NSString *sign_group_name;
/**
 * 联系人名称
 */
@property (nonatomic, strong) NSString *linkman_name;
/**
 * 意向度
 */
@property (nonatomic, strong) NSString *intent;
/**
 * 铺位名字
 */
@property (nonatomic, strong) NSString *pos_name;
/**
 *  是否是我的客户：1是 2否
 */
@property (nonatomic, strong) NSString *is_own;

@end
