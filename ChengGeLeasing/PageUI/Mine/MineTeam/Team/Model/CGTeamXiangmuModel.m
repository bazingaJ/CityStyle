//
//  CGTeamXiangmuModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGTeamXiangmuModel.h"
#import "CGTeamMemberModel.h"

@implementation CGTeamXiangmuModel

/**
 *  团队成员列表
 */
- (void)setList:(NSMutableArray *)list {
    _list = [CGTeamMemberModel mj_objectArrayWithKeyValuesArray:list];
}

@end
