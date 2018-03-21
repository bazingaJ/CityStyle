//
//  CGBunkAreaModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/17.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGBunkAreaModel.h"
#import "CGBunkModel.h"

@implementation CGBunkAreaModel

/**
 *  区域内铺位列表
 */
- (void)setPos_list:(NSMutableArray *)pos_list {
    _pos_list = [CGBunkModel mj_objectArrayWithKeyValuesArray:pos_list];
}

@end
