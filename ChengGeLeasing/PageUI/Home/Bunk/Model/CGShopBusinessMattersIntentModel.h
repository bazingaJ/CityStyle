//
//  CGShopBusinessMattersIntentModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/19.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGShopBusinessMattersIntentModel : NSObject

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
 * 对该铺位的意向度
 */
@property (nonatomic, strong) NSString *intent;
/**
 * 是否是自己
 */
@property (nonatomic, strong) NSString *is_own;


@end
