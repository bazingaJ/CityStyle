//
//  CGTeamXiangmuModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  项目-模型
 */
@interface CGTeamXiangmuModel : NSObject

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *id;
/**
 *  首字母
 */
@property (nonatomic, strong) NSString *initials;
/**
 *  项目名称
 */
@property (nonatomic, strong) NSString *name;
/**
 *  总面积(单位：m²)
 */
@property (nonatomic, strong) NSString *totalArea;
/**
 *  已租面积(单位：m²)
 */
@property (nonatomic, strong) NSString *totalSignArea;
/**
 *  已租数
 */
@property (nonatomic, strong) NSString *signNum;
/**
 *  稳赢数
 */
@property (nonatomic, strong) NSString *profitNum;
/**
 *  预动数
 */
@property (nonatomic, strong) NSString *togoNum;
/**
 *  退铺警告
 */
@property (nonatomic, strong) NSString *outNum;
/**
 *  排序
 */
@property (nonatomic, strong) NSString *sort;

/**
 *  业态数量
 */
@property (nonatomic, strong) NSString *cate_num;
/**
 *  封面地址
 */
@property (nonatomic, strong) NSString *cover_url;
/**
 *  区域数量
 */
@property (nonatomic, strong) NSString *group_num;
/**
 *  成员数量
 */
@property (nonatomic, strong) NSString *member_num;
/**
 *  铺位数量
 */
@property (nonatomic, strong) NSString *pos_num;
/**
 *  分组数量
 */
@property (nonatomic, strong) NSString *team_num;
/**
 *  团队成员列表
 */
@property (nonatomic, strong) NSMutableArray *list;
/**
 *  分类名称
 */
@property (nonatomic, strong) NSString *cate_name;
/**
 *  LOGO
 */
@property (nonatomic, strong) NSString *logo;
/**
 *  业务员名称
 */
@property (nonatomic, strong) NSString *user_name;
/**
 *  添加时间
 */
@property (nonatomic, strong) NSString *add_time;
/**
 *  是否本人客户:1是 2否
 */
@property (nonatomic, strong) NSString *is_mine;
/**
 *  联系人名称
 */
@property (nonatomic, strong) NSString *linkman_name;

@end
