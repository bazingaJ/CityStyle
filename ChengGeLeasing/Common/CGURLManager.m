//
//  CGURLManager.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGURLManager.h"

@implementation CGURLManager

/**
 *  创建单例模式
 */
+ (instancetype)manager {
    //单例
    static CGURLManager *_manager = nil;
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch, ^{
        _manager = [[CGURLManager alloc] init];
    });
    return _manager;
}

@end
