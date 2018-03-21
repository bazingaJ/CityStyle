//
//  XTBarButtonItem.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SNNavItemStyle) {
    
    SNNavItemStyleLeft, //左侧按钮
    SNNavItemStyleRight, //右侧按钮
    SNNavItemStyleDone,
};

@interface XTBarButtonItem : UIBarButtonItem

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)imageName
                        Style:(SNNavItemStyle)style
                       target:(id)target
                       action:(SEL)action;

@end
