//
//  CGMemberRemoveV.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGMemberRemoveV : UIView

- (instancetype)initWithFrame:(CGRect)frame windowTitle:(NSString *)titleStr;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^clickCallBack)(NSInteger tIndex);
@end
