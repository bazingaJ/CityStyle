//
//  CGFunnelCustomerModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGFunnelCustomerModel.h"

@implementation CGFunnelCustomerModel

-(void)setList:(NSArray *)list
{
    _list = [CGHasSignedCustomerListModel mj_objectArrayWithKeyValuesArray:list];
}
@end
