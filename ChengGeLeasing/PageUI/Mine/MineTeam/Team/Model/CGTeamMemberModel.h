//
//  CGTeamMemberModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  团队成员-模型
 */
@interface CGTeamMemberModel : NSObject

/**
 *  成员ID
 */
@property (nonatomic, strong) NSString *id;
/**
 *  成员ID(第二种写法)
 */
@property (nonatomic, strong) NSString *user_id;
/**
 *  成员名称
 */
@property (nonatomic, strong) NSString *name;
/**
 *  成员名称(第二种写法)
 */
@property (nonatomic, strong) NSString *user_name;
/**
 *  成员电话
 */
@property (nonatomic, strong) NSString *mobile;
/**
 *  成员头像
 */
@property (nonatomic, strong) NSString *avatar;
/**
 *  是否已经加入该项目 1是2否
 */
@property (nonatomic, strong) NSString *isIn;
/**
 *  已点击添加(自定义)
 */
@property (nonatomic, assign) BOOL isAdd;
/**
 *  是否项目负责人:1是 2否
 */
@property (nonatomic, strong) NSString *isCharge;
/**
 *  是否已经加入该项目 1是2否
 */
@property (nonatomic, strong) NSString *isInTeam;
/**
 *  分组ID
 */
@property (nonatomic, strong) NSString *team_id;
/**
 *  分组名称
 */
@property (nonatomic, strong) NSString *team_name;
/**
 *  选中标识
 */
@property (nonatomic, assign) BOOL is_selected;

@end
