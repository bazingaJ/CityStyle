//
//  CGFindLinkmanModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/19.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGFindLinkmanModel.h"

@implementation CGFindLinkmanModel

/**
 *  性别:1男 2女 3未知
 */
- (NSString *)sex_name {
    if([self.sex isEqualToString:@"1"]) {
        return @"男";
    }else if([self.sex isEqualToString:@"2"]) {
        return @"女";
    }else {
        return @"未知";
    }
}

@end
