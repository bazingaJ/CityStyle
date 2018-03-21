//
//  CGLinkmanModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  联系人-模型
 */
@interface CGLinkmanModel : NSObject

/**
 *  联系人ID
 */
@property (nonatomic, strong) NSString *id;
/**
 *  联系人姓名
 */
@property (nonatomic, strong) NSString *name;
/**
 *  性别：1男 2女 3未知
 */
@property (nonatomic, strong) NSString *gender;
/**
 *  性别名称
 */
@property (nonatomic, strong) NSString *gender_name;
/**
 *  电话
 */
@property (nonatomic, strong) NSString *mobile;
/**
 *  职位
 */
@property (nonatomic, strong) NSString *job;
/**
 *  邮箱
 */
@property (nonatomic, strong) NSString *email;
/**
 *  省份ID
 */
@property (nonatomic, strong) NSString *province_id;
/**
 *  城市ID
 */
@property (nonatomic, strong) NSString *city_id;
/**
 *  区域ID
 */
@property (nonatomic, strong) NSString *area_id;
/**
 *  区域名称
 */
@property (nonatomic, strong) NSString *area_name;
/**
 *  详细地址
 */
@property (nonatomic, strong) NSString *address;
/**
 *  单元格行高
 */
@property (nonatomic, assign) CGFloat cellH;

@end
