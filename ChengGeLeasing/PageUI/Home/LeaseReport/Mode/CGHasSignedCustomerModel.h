//
//  CGHasSignedCustomerModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGHasSignedCustomerListModel.h"
@interface CGHasSignedCustomerModel : NSObject
/**
 * 客户数
 */
@property (nonatomic, strong) NSString *count;
/**
 * 列表
 */
@property (nonatomic ,strong) NSArray *list;
@end
