//
//  CGNetdiscNamePopupView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/2/2.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGNetdiscNamePopupView : UIView

/**
 初始化一个自定义弹窗

 @param frame 弹窗的frame
 @param titleStr 弹窗的标题
 @param placeholderStr 弹窗的文本输入的占位字符
 @param contentStr 弹窗初始化文本
 @return 返回弹窗本身
 */
- (instancetype)initWithFrame:(CGRect)frame
           titleStr:(NSString *)titleStr
     placeholderStr:(NSString *)placeholderStr
         contentStr:(NSString *)contentStr;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSInteger tIndex, NSString *content);

@end
