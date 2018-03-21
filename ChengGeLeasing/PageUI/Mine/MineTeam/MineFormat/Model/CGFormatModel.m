//
//  CGFormatModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGFormatModel.h"

@implementation CGFormatModel

- (void)setSecond_cate_list:(NSMutableArray *)second_cate_list {
    _second_cate_list = [CGFormatModel mj_objectArrayWithKeyValuesArray:second_cate_list];
}

- (void)setThird_cate_list:(NSMutableArray *)third_cate_list {
    _third_cate_list = [CGFormatModel mj_objectArrayWithKeyValuesArray:third_cate_list];
}

@end
