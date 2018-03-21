//
//  CGFormatModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGFormatModel : NSObject

/**
 *  业态ID
 */
@property (nonatomic, strong) NSString *id;
/**
 *  业态名称
 */
@property (nonatomic, strong) NSString *name;
/**
 *  选择状态
 */
@property (nonatomic, assign) BOOL is_selected;
/**
 *  二级业态列表
 */
@property (nonatomic, strong) NSMutableArray *second_cate_list;
/**
 *  三级业态列表
 */
@property (nonatomic, strong) NSMutableArray *third_cate_list;

@end
