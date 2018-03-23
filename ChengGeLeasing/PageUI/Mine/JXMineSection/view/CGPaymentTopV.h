//
//  CGPaymentTopV.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGPaymentTopV : UIView

/**
 顶部视图的初始化

 @param frame 布局
 @param status 支付状态返回
 @return 返回视图实例
 */
- (instancetype)initWithFrame:(CGRect)frame payStatus:(BOOL)status;

@end
