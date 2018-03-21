//
//  CGXiangmuModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGXiangmuModel.h"
#import "CGFormatModel.h"

@implementation CGXiangmuModel

/**
 *  业态列表
 */
- (void)setCate_list:(NSMutableArray *)cate_list {
    _cate_list = [CGFormatModel mj_objectArrayWithKeyValuesArray:cate_list];
}

@end
