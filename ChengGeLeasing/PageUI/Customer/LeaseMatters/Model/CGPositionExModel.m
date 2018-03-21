//
//  CGPositionExModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/21.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGPositionExModel.h"

@implementation CGPositionExModel

-(void)setPos_list:(NSArray *)pos_list
{
    _pos_list = [CGPositionPosListModel mj_objectArrayWithKeyValuesArray:pos_list];
}

@end


@implementation CGPositionPosListModel

@end
