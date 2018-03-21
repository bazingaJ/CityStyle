//
//  CGLeaseIntent_InfoListModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGLeaseIntent_InfoListModel : NSObject
/**
 * 客户名称
 */
@property (nonatomic, strong) NSString *cust_name;
/**
 * 业态名称
 */
@property (nonatomic, strong) NSString *cate_name;
/**
 * 铺位名称
 */
@property (nonatomic, strong) NSString *pos_name;
/**
 * 联系人名称
 */
@property (nonatomic, strong) NSString *linkman_name;
/**
 * 意向度
 */
@property (nonatomic, strong) NSString *intent;
/**
 * 详情
 */
@property (nonatomic, strong) NSString *intro;
/**
 * 时间
 */
@property (nonatomic, strong) NSString *time;
/**
 * cell高度
 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
