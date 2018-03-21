//
//  CGNetdiscNamePopupView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/2/2.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGNetdiscNamePopupView : UIView

- (id)initWithFrame:(CGRect)frame contentStr:(NSString *)contentStr;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSInteger tIndex, NSString *content);

@end
