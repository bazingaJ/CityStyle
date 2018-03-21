//
//  CGLeaseSign_InfoModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGLeaseSign_InfoModel : NSObject
/**
 * 业态名字
 */
@property (nonatomic ,strong) NSString *cate_name;
/**
 * 客户名字
 */
@property (nonatomic ,strong) NSString *cust_name;
/**
 * 铺位名字
 */
@property (nonatomic ,strong) NSString *pos_name;
/**
 * 签约时间
 */
@property (nonatomic ,strong) NSString *sign_date;
/**
 * 签约总数
 */
@property (nonatomic ,strong) NSString *sign_num_total;
/**
 * 本周数
 */
@property (nonatomic ,strong) NSString *sign_num_week;
@end
