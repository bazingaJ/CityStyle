//
//  CGHomeModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/11/27.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGHomeModel.h"

@implementation CGHomeModel

-(void)setLetData:(NSDictionary *)letData
{
    _letDataModel =[CGLetDataModel mj_objectWithKeyValues:letData];
}

-(void)setPosition:(NSArray *)position
{
    _position = [CGPositionModel mj_objectArrayWithKeyValuesArray:position];
}

-(void)setTrends:(NSDictionary *)trends
{
   _trendsModel = [CGHomeTrendsModel mj_objectWithKeyValues:trends];
}

@end
