//
//  UIView+Touch.m
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import "UIView+Touch.h"

@implementation UIView (Touch)

static char touchKey;
-(void)actionTap{
    void (^block)(void) = objc_getAssociatedObject(self, &touchKey);
    if (block) block();
}
-(void)addTouch:(TouchBlock)block{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap)];
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &touchKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
