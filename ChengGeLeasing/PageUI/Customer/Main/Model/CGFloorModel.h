//
//  CGFloorModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/25.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  楼层-模型
 */
@interface CGFloorModel : NSObject

/**
 *  楼层ID
 */
@property (nonatomic, strong) NSString *floor_id;
/**
 *  楼层名称
 */
@property (nonatomic, strong) NSString *floor_name;
/**
 *  选择状态
 */
@property (nonatomic, assign) BOOL is_selected;

@end
