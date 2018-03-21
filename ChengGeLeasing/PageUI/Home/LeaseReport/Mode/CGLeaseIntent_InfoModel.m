//
//  CGLeaseIntent_InfoModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLeaseIntent_InfoModel.h"

@implementation CGLeaseIntent_InfoModel

-(void)setList:(NSArray *)list
{
    _list = [CGLeaseIntent_InfoListModel mj_objectArrayWithKeyValuesArray:list];
}
@end
