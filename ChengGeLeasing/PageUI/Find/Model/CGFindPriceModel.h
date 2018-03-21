//
//  CGFindPriceModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/19.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  资源价格-模型
 */
@interface CGFindPriceModel : NSObject

/**
 *  品牌ID
 */
@property (nonatomic, strong) NSString *brand_id;
/**
 *  价格ID
 */
@property (nonatomic, strong) NSString *id;
/**
 *  最高价格
 */
@property (nonatomic, strong) NSString *max_price;
/**
 *  最低价格
 */
@property (nonatomic, strong) NSString *min_price;
/**
 *  名称
 */
@property (nonatomic, strong) NSString *name;

@end
