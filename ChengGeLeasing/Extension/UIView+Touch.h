//
//  UIView+Touch.h
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Touch)

typedef void (^TouchBlock)();
-(void)addTouch:(TouchBlock)block;

@end
