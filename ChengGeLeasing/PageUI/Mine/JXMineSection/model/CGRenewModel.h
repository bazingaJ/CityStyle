//
//  CGRenewModel.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/29.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGRenewModel : NSObject


/**
 单价
 */
@property (nonatomic, strong) NSString *unit_price;

/**
 购买个数
 */
@property (nonatomic, strong) NSString *seats_number;

/**
 购买时长
 */
@property (nonatomic, strong) NSString *month;

/**
 总价
 */
@property (nonatomic, strong) NSString *total_prices;

/**
 付款方式 1.微信 2.支付宝
 */
@property (nonatomic, strong) NSString *payType;

/**
 是否阅读服务协议 1.已阅读 2.未阅读
 */
@property (nonatomic, strong) NSString *isRead;

@end
