//
//  CGStatisticsModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGStatisticsModel.h"

@implementation CGStatisticsModel

-(void)setList:(NSArray *)list
{
    _list = [CGStatisticsListModel mj_objectArrayWithKeyValuesArray:list];
}

@end
