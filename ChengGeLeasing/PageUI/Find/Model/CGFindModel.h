//
//  CGFindModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  客户-模型
 */
@interface CGFindModel : NSObject

/**
 *  客户ID
 */
@property (nonatomic, strong) NSString *brand_id;
/**
 *  客户ID(第二种写法)
 */
@property (nonatomic, strong) NSString *id;
/**
 *  客户名称
 */
@property (nonatomic, strong) NSString *name;
/**
 *  首字母
 */
@property (nonatomic, strong) NSString *first_name;
/**
 *  LOGO地址
 */
@property (nonatomic, strong) NSString *img_url;
/**
 *  LOGO地址(第二种写法)
 */
@property (nonatomic, strong) NSString *logo;
/**
 *  类型
 */
@property (nonatomic, strong) NSString *type;
/**
 *  业态名称
 */
@property (nonatomic, strong) NSString *cate;
/**
 *  修改时间
 */
@property (nonatomic, strong) NSString *update_date;
/**
 *  成员数量
 */
@property (nonatomic, strong) NSString *member_num;
/**
 *  备注
 */
@property (nonatomic, strong) NSString *note;
/**
 *  品牌类型
 */
@property (nonatomic, strong) NSString *level;
/**
 *  消费者性别
 */
@property (nonatomic, strong) NSString *cust_sex;
/**
 *  消费者年龄构成
 */
@property (nonatomic, strong) NSString *cust_age;
/**
 *  单元格高度
 */
@property (nonatomic, assign) CGFloat cellH;

@end
