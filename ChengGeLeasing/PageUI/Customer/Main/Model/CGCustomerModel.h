//
//  CGCustomerModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  客户-模型
 */
@interface CGCustomerModel : NSObject

/**
 *  客户ID
 */
@property (nonatomic, strong) NSString *cust_id;
/**
 *  客户ID(第二种写法)
 */
@property (nonatomic, strong) NSString *id;
/**
 *  首字母
 */
@property (nonatomic, strong) NSString *first_letter;
/**
 *  客户名称
 */
@property (nonatomic, strong) NSString *name;
/**
 *  业态ID
 */
@property (nonatomic, strong) NSString *cate_id;
/**
 *  业态名称
 */
@property (nonatomic, strong) NSString *cate_name;
/**
 *  LOGO
 */
@property (nonatomic, strong) NSString *logo;
/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;
/**
 *  项目名称
 */
@property (nonatomic, strong) NSString *pro_name;
/**
 *  添加时间
 */
@property (nonatomic, strong) NSString *add_time;
/**
 *  招租事项数量
 */
@property (nonatomic, strong) NSString *intent_count;
/**
 *  待办事项数量
 */
@property (nonatomic, strong) NSString *to_do_count;
/**
 *  是否为我的客户:1是 2否
 */
@property (nonatomic, strong) NSString *is_mine;
/**
 *  联系人姓名
 */
@property (nonatomic, strong) NSString *linkman_name;
/**
 *  联系人姓名
 */
@property (nonatomic, strong) NSString *linkman_count;
/**
 *  招租事项详情
 */
@property (nonatomic, strong) NSString *intro;
/**
 *  意向度
 */
@property (nonatomic, strong) NSString *intent;
/**
 *  官网
 */
@property (nonatomic, strong) NSString *website;
/**
 *  需求面积
 */
@property (nonatomic, strong) NSString *need_area;
/**
 *  需求年限
 */
@property (nonatomic, strong) NSString *years;
/**
 *  物业条件(多个逗号分隔)
 */
@property (nonatomic, strong) NSString *property;
/**
 *  物业条件(多个逗号分隔)(自定义)
 */
@property (nonatomic, strong) NSMutableArray *propertyArr;
/**
 *  选中状态(自定义)
 */
@property (nonatomic, assign) BOOL is_selected;
/**
 *  业务员名字
 */
@property (nonatomic, strong) NSString *user_name;
/**
 *  城市要求
 */
@property (nonatomic, strong) NSString *city;
/**
 *  商圈要求
 */
@property (nonatomic, strong) NSString *business;
/**
 *  楼层要求
 */
@property (nonatomic, strong) NSString *floor;
/**
 *  宽度要求
 */
@property (nonatomic, strong) NSString *width;
/**
 *  深度要求
 */
@property (nonatomic, strong) NSString *depth;
/**
 *  面积要求(最大最小值英文逗号分隔)
 */
@property (nonatomic, strong) NSString *area;
/**
 *  面积要求(最大最小值英文逗号分隔)
 */
@property (nonatomic, strong) NSString *min_area;
/**
 *  面积要求(最大最小值英文逗号分隔)
 */
@property (nonatomic, strong) NSString *max_area;
/**
 *  喜号业态
 */
@property (nonatomic, strong) NSString *like_cate_id;
/**
 *  喜号业态名称
 */
@property (nonatomic, strong) NSString *like_cate_name;
/**
 *  层高要求
 */
@property (nonatomic, strong) NSString *height;
/**
 *  厨房承重
 */
@property (nonatomic, strong) NSString *support_kitchen;
/**
 *  其他区域承重
 */
@property (nonatomic, strong) NSString *support_other;
/**
 *  承重备注
 */
@property (nonatomic, strong) NSString *support_note;
/**
 *  供电要求
 */
@property (nonatomic, strong) NSMutableArray *electric;
/**
 *  供电备注
 */
@property (nonatomic, strong) NSString *electric_note;
/**
 *  供水管径
 */
@property (nonatomic, strong) NSString *water_diameter;
/**
 *  供水压力
 */
@property (nonatomic, strong) NSString *water_pressure;
/**
 *  供水备注
 */
@property (nonatomic, strong) NSString *water_note;
/**
 *  排水厨房DN
 */
@property (nonatomic, strong) NSString *drain_diameter;
/**
 *  排水卫生间DN
 */
@property (nonatomic, strong) NSString *drain_pressure;
/**
 *  隔油层
 */
@property (nonatomic, strong) NSString *drain_pool;
/**
 *  燃气要求(数组)
 */
@property (nonatomic, strong) NSMutableArray *gas;
/**
 *  供暖面积段(英文逗号分隔)
 */
@property (nonatomic, strong) NSString *warming_area;
/**
 *  供暖面积段(最小值)
 */
@property (nonatomic, strong) NSString *warming_min_area;
/**
 *  供暖面积段(最大值)
 */
@property (nonatomic, strong) NSString *warming_max_area;
/**
 *  预留面积
 */
@property (nonatomic, strong) NSString *warming_has_area;
/**
 *  消防
 */
@property (nonatomic, strong) NSString *fire;
/**
 *  环评
 */
@property (nonatomic, strong) NSString *environment;
/**
 *  消防备注
 */
@property (nonatomic, strong) NSString *fire_note;
/**
 *  排烟通道(1需要 2不需要)
 */
@property (nonatomic, strong) NSString *piping;
/**
 *  住距
 */
@property (nonatomic, strong) NSString *range;
/**
 *  独立电梯(1需要 2不需要)
 */
@property (nonatomic, strong) NSString *elevator;

@end
