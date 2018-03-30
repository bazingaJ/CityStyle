//
//  CGXuFeiView.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/30.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGXuFeiView.h"

static NSString *const cancelText = @"取消";

static NSString *const buyText = @"去续费";

@implementation CGXuFeiView

// 275 345
- (instancetype)initWithFrame:(CGRect)frame contentStr:(NSString *)contentStr
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = CLEAR_COLOR;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(width-30, 0, 30, 30);
        [closeBtn setImage:[UIImage imageNamed:@"window_close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnCilck) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
        UIView *coverView = [[UIView alloc] init];
        coverView.frame = CGRectMake(0, 40, width, height - 40);
        coverView.backgroundColor = WHITE_COLOR;
        coverView.layer.masksToBounds = YES;
        coverView.layer.cornerRadius = 5;
        [self addSubview:coverView];
        
        UILabel *contentLab = [[UILabel alloc] init];
        contentLab.frame = CGRectMake(0, 60, width, 110);
        contentLab.text = contentStr;
        contentLab.textColor = COLOR3;
        contentLab.font = FONT20;
        contentLab.numberOfLines = 0;
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 10;// 字体的行间距
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:contentStr];
        [AttributedStr addAttribute:NSParagraphStyleAttributeName
                              value:paragraphStyle
                              range:NSMakeRange(0, contentStr.length)];
        contentLab.attributedText = AttributedStr;
        [self addSubview:contentLab];
        
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, height - 45, width, 45);
        view.backgroundColor = MAIN_COLOR;
        [self addSubview:view];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, height - 44, width * 0.5, 44);
        [cancelBtn setTitle:cancelText forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:WHITE_COLOR];
        [cancelBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        buyBtn.frame = CGRectMake(width * 0.5, height - 44, width * 0.5, 44);
        [buyBtn setTitle:buyText forState:UIControlStateNormal];
        [buyBtn setBackgroundColor:MAIN_COLOR];
        [buyBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buyBtn];
        
    }
    return self;
}

- (void)closeBtnCilck
{
    if(self.clickCallBack) {
        self.clickCallBack(0);
    }
}

- (void)cancelBtnClick
{
    if(self.clickCallBack) {
        self.clickCallBack(1);
    }
}

- (void)buyBtnClick
{
    if(self.clickCallBack) {
        self.clickCallBack(2);
    }
}

@end
