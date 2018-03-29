//
//  CGOrderListModel.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/29.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGOrderListModel : NSObject


/**
 订单标题
 */
@property (nonatomic, strong) NSString *order_title;

/**
 订单号
 */
@property (nonatomic, strong) NSString *order_number;

/**
 订单内容
 */
@property (nonatomic, strong) NSString *order_content;

/**
 订单金额
 */
@property (nonatomic, strong) NSString *order_amount;

@end
