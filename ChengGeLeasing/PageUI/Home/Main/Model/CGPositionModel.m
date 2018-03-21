//
//  CGPositionModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/15.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGPositionModel.h"

@implementation CGPositionModel

-(void)setPos_list:(NSArray *)pos_list
{
    _pos_list =[CGHomePos_listModel mj_objectArrayWithKeyValuesArray:pos_list];
}

@end
