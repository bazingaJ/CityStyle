//
//  CGTeamAreaModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  区域-模型
 */
@interface CGTeamAreaModel : NSObject

/**
 *  区域ID
 */
@property (nonatomic, strong) NSString *id;
/**
 *  区域名称
 */
@property (nonatomic, strong) NSString *name;
/**
 *  排序
 */
@property (nonatomic, strong) NSString *sort;

@end
