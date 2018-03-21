//
//  CGLinkmanModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLinkmanModel.h"

@implementation CGLinkmanModel

- (CGFloat)cellH {
    CGFloat rowH = 35*3+20;
    
    //职位
    if(!IsStringEmpty(self.job)) {
        rowH += 35;
    }
    
    //邮箱
    if(!IsStringEmpty(self.email)) {
        rowH += 35;
    }
    
    //地址
    if(!IsStringEmpty(self.address)) {
        rowH += 35;
    }
    
    return rowH;
}

@end
