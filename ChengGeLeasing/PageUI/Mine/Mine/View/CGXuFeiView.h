//
//  CGXuFeiView.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/30.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGXuFeiView : UIView

- (instancetype)initWithFrame:(CGRect)frame contentStr:(NSString *)contentStr;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^clickCallBack)(NSInteger tIndex);

@end
