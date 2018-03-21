//
//  CGBunkAreaModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/17.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGBunkAreaModel : NSObject

/**
 *  区域ID
 */
@property (nonatomic, strong) NSString *id;
/**
 *  区域名称
 */
@property (nonatomic, strong) NSString *name;
/**
 *  区域内铺位列表
 */
@property (nonatomic, strong) NSMutableArray *pos_list;

@end
