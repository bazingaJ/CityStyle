//
//  CGLimitTextView.h
//  zteiwh
//
//  Created by 相约在冬季 on 2017/9/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGLimitTextView : UIView<UITextViewDelegate>

/**
 *  多行文本控件
 */
@property (nonatomic, strong) UITextView *textView;
/**
 *  字数限制
 */
@property (nonatomic, assign) NSInteger limitNum;
/**
 *  描述语
 */
@property (nonatomic, strong) NSString *placeHolder;

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end
