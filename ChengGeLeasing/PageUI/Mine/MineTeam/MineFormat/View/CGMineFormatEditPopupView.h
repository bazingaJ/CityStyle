//
//  CGMineFormatEditPopupView.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGMineFormatEditPopupView : UIView

- (id)initWithFrame:(CGRect)frame titleStr:(NSString *)titleStr contentStr:(NSString *)contentStr;

/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)(NSInteger tIndex, NSString *content);

@end
