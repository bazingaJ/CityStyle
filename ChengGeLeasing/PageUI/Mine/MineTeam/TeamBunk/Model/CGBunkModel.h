//
//  CGBunkModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  铺位-模型
 */
@interface CGBunkModel : NSObject

/**
 *  铺位ID
 */
@property (nonatomic, strong) NSString *pos_id;
/**
 *  铺位名称
 */
@property (nonatomic, strong) NSString *pos_name;
/**
 *  铺位面积
 */
@property (nonatomic, strong) NSString *pos_area;
/**
 *  铺位面积(第二种写法)
 */
@property (nonatomic, strong) NSString *area;
/**
 *  区域ID
 */
@property (nonatomic, strong) NSString *group_id;
/**
 *  区域名称
 */
@property (nonatomic, strong) NSString *group_name;
/**
 *  业态名称
 */
@property (nonatomic, strong) NSString *name;
/**
 *  期望报价
 */
@property (nonatomic, strong) NSString *quotation;
/**
 *  期望报价单位：1:元/年 2:元/月 3:元/平米/年 4:元/平米/月
 */
@property (nonatomic, strong) NSString *quotation_unit;
/**
 *  期望报价单位名称
 */
@property (nonatomic, strong) NSString *quotation_unit_name;
/**
 *  期望业态ID（多个逗号分隔）
 */
@property (nonatomic, strong) NSString *want_cate_id;
/**
 *  期望业态ID数组集合（自定义）
 */
@property (nonatomic, strong) NSMutableArray *wantCateArr;
/**
 *  期望业态名称
 */
@property (nonatomic, strong) NSString *want_cate_name;
/**
 *  省份ID
 */
@property (nonatomic, strong) NSString *province_id;
/**
 *  城市ID
 */
@property (nonatomic, strong) NSString *city_id;
/**
 *  县区ID
 */
@property (nonatomic, strong) NSString *area_id;
/**
 *  省市区名称
 */
@property (nonatomic, strong) NSString *area_name;
/**
 *  详细地址
 */
@property (nonatomic, strong) NSString *address;
/**
 *  商圈
 */
@property (nonatomic, strong) NSString *business;
/**
 *  建筑面积
 */
@property (nonatomic, strong) NSString *covered_area;
/**
 *  使用面积
 */
@property (nonatomic, strong) NSString *net_area;
/**
 *  楼层
 */
@property (nonatomic, strong) NSString *floor;
/**
 *  宽度
 */
@property (nonatomic, strong) NSString *width;
/**
 *  深度
 */
@property (nonatomic, strong) NSString *depth;
/**
 *  层高
 */
@property (nonatomic, strong) NSString *height;
/**
 *  包含的物业条件 逗号分隔 1可明火 2天然气 3煤气罐 4、380伏 5上水 6下水 7烟管道 8排污管道 9停车位 10外摆区
 */
@property (nonatomic, strong) NSString *property;
/**
 *  包含的物业条件(自定义)
 */
@property (nonatomic, strong) NSMutableArray *propertyArr;
/**
 *  备注
 */
@property (nonatomic, strong) NSString *note;
/**
 *  单元格高度
 */
@property (nonatomic, assign) CGFloat cellH;

@end
