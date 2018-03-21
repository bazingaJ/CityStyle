//
//  CGNetdiscEmailPopupView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/20.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGNetdiscEmailPopupView : UIView

//回调函数
@property (nonatomic, copy) void(^callBack)(NSInteger tIndex, NSString *emailStr);

@end
