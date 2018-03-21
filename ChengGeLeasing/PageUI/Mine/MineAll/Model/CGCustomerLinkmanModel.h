//
//  CGCustomerLinkmanModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/19.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  客户联系人-模型
 */
@interface CGCustomerLinkmanModel : NSObject

/**
 *  联系人姓名
 */
@property (nonatomic, strong) NSString *linkman_name;
/**
 *  联系人电话
 */
@property (nonatomic, strong) NSString *linkman_mobile;

@end
