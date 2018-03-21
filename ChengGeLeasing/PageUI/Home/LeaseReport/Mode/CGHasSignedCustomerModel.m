//
//  CGHasSignedCustomerModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGHasSignedCustomerModel.h"

@implementation CGHasSignedCustomerModel

-(void)setList:(NSArray *)list
{
    _list = [CGHasSignedCustomerListModel mj_objectArrayWithKeyValuesArray:list];
}

@end
