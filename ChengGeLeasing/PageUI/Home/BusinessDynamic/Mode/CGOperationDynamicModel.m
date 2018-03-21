//
//  CGOperationDynamicModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGOperationDynamicModel.h"

@implementation CGOperationDynamicModel

-(void)setPosition:(NSArray *)position
{
    _position = [CGOperationDynamicPositionModel mj_objectArrayWithKeyValuesArray:position];
}
@end

@implementation CGOperationDynamicPositionModel

@end
