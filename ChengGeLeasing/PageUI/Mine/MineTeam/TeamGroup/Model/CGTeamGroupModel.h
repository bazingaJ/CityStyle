//
//  CGTeamGroupModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGTeamMemberModel.h"

/**
 *  团队分组-模型
 */
@interface CGTeamGroupModel : NSObject

/**
 *  分组ID
 */
@property (nonatomic, strong) NSString *id;
/**
 *  分组名称
 */
@property (nonatomic, strong) NSString *name;
/**
 *  分组成员列表
 */
@property (nonatomic, strong) NSMutableArray *memberList;

@end
