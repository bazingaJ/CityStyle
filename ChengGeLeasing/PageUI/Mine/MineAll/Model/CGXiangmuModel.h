//
//  CGXiangmuModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  项目-模型
 */
@interface CGXiangmuModel : NSObject

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;
/**
 *  项目名称
 */
@property (nonatomic, strong) NSString *pro_name;
/**
 *  项目首字母
 */
@property (nonatomic, strong) NSString *initials;
/**
 *  业态列表
 */
@property (nonatomic, strong) NSMutableArray *cate_list;

@end
