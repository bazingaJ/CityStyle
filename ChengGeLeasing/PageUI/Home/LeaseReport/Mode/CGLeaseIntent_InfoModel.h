//
//  CGLeaseIntent_InfoModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGLeaseIntent_InfoListModel.h"
@interface CGLeaseIntent_InfoModel : NSObject
/**
 * 总拜访数量
 */
@property (nonatomic, strong) NSString *intent_num_total;
/**
 * 本周数
 */
@property (nonatomic, strong) NSString *intent_num_week;
/**
 * 列表
 */
@property (nonatomic, strong) NSArray *list;
@end
