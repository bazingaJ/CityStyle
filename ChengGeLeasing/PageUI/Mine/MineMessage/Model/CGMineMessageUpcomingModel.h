//
//  CGMineMessageUpcomingModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  待办-模型
 */
@interface CGMineMessageUpcomingModel : NSObject

/**
 *  待办ID
 */
@property (nonatomic, strong) NSString *id;
/**
 *  是否已办:1是 2否
 */
@property (nonatomic, strong) NSString *is_do;
/**
 *  内容
 */
@property (nonatomic, strong) NSString *content;
/**
 *  联系人姓名
 */
@property (nonatomic, strong) NSString *linkman_name;
/**
 *  客户姓名
 */
@property (nonatomic, strong) NSString *cust_name;
/**
 *  时间
 */
@property (nonatomic, strong) NSString *time;

@end
