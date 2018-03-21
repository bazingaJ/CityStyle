//
//  CGWorkBriefingModel.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGWorkBriefingModel : NSObject

/**
 * ICON
 */
@property (nonatomic, strong) NSString *icon;
/**
 * 数量
 */
@property (nonatomic, strong) NSString *count;
/**
 * 类型名字
 */
@property (nonatomic, strong) NSString *name;
/**
 * 类型 1新增客户数 2新增联系人 3新签约客户 4新增事项 5拜访客户数 6意向编号客户
 */
@property (nonatomic, strong) NSString *type;
/**
 *
 */
@property (nonatomic, strong) NSString *old_num;
/**
 *  排名(如：2/11)
 */
@property (nonatomic, strong) NSString *rank;
/**
 *  排名对比(1不变 2上升 3下降)
 */
@property (nonatomic, strong) NSString *ratio;
/**
 *  是否选择了时间
 */
@property (nonatomic, assign) BOOL isTime;
/**
 *  是否选择了业务员
 */
@property (nonatomic, assign) BOOL isMem;
/**
 *  是不是我的
 */
@property (nonatomic, assign) BOOL isMine;

@end
