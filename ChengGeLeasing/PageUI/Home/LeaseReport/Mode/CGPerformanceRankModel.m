//
//  CGPerformanceRankModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/19.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGPerformanceRankModel.h"

@implementation CGPerformanceRankModel

-(void)setList:(NSArray *)list
{
    _list = [CGPerformanceRankListModel mj_objectArrayWithKeyValuesArray:list];
}

@end

@implementation CGPerformanceRankListModel

@end
