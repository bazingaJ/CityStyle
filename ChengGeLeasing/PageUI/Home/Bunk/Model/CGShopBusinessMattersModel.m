//
//  CGShopBusinessMattersModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGShopBusinessMattersModel.h"

@implementation CGShopBusinessMattersModel

-(void)setHistory_list:(NSArray *)history_list
{
    _history_list = [CGShopBusinessMattersHistoryListModel mj_objectArrayWithKeyValuesArray:history_list];
}

-(void)setOperate_list:(NSArray *)operate_list
{
    _operate_list = [CGShopBusinessMattersOperateListModel mj_objectArrayWithKeyValuesArray:operate_list];
}

-(void)setIntent_list:(NSArray *)intent_list
{
    _intent_list = [CGShopBusinessMattersIntentModel mj_objectArrayWithKeyValuesArray:intent_list];
}

@end
