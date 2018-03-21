//
//  CGTeamGroupModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGTeamGroupModel.h"

@implementation CGTeamGroupModel

/**
 *  分组成员列表
 */
- (void)setMemberList:(NSMutableArray *)memberList {
    _memberList = [CGTeamMemberModel mj_objectArrayWithKeyValuesArray:memberList];
}

@end
