//
//  CGMineAuthMemberModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineAuthMemberModel.h"

@implementation CGMineAuthMemberModel

/**
 *  已有权限ID集合
 */
- (NSMutableArray *)authArr {
    if(!IsStringEmpty(self.auth)) {
        NSMutableArray *itemArr = [[self.auth componentsSeparatedByString:@","] mutableCopy];
        return itemArr;
    }
    return [NSMutableArray array];
}

@end
