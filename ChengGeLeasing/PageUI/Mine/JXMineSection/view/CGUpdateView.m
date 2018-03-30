//
//  CGUpdateView.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGUpdateView.h"

static NSString *const nowVersionText = @"您目前的版本是个人免费版";

static NSString *const knowMoreText = @"了解更多VIP企业版特权";

static NSString *const vipText = @"升级VIP";

@implementation CGUpdateView
// 275 345
- (instancetype)initWithFrame:(CGRect)frame contentStr:(NSString *)contentStr
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = CLEAR_COLOR;
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(width-30, 40, 30, 30);
        [closeBtn setImage:[UIImage imageNamed:@"window_close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnCilck) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
        UIImageView *coverImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rocket"]];
        coverImage.frame = self.bounds;
        [self addSubview:coverImage];
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.frame = CGRectMake(0, 90, width, 30);
        titleLab.text = nowVersionText;
        titleLab.textColor = WHITE_COLOR;
        titleLab.font = [UIFont systemFontOfSize:19];
        titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLab];
        
        UILabel *subTitleLab = [[UILabel alloc] init];
        subTitleLab.frame = CGRectMake(0, 150, width, 40);
        subTitleLab.text = vipText;
        subTitleLab.textColor = MAIN_COLOR;
        subTitleLab.font = [UIFont systemFontOfSize:35];
        subTitleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:subTitleLab];
        
        UILabel *contentLab = [[UILabel alloc] init];
        contentLab.frame = CGRectMake(0, 210, width, 60);
        contentLab.text = contentStr;
        contentLab.textColor = COLOR3;
        contentLab.font = FONT20;
        contentLab.numberOfLines = 2;
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];    
        paragraphStyle.lineSpacing = 10;// 字体的行间距
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:contentStr];
        [AttributedStr addAttribute:NSParagraphStyleAttributeName
                              value:paragraphStyle
                              range:NSMakeRange(0, contentStr.length)];
        contentLab.attributedText = AttributedStr;
        [self addSubview:contentLab];

        UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bottomBtn.frame = CGRectMake(15, height - 55, width - 30, 45);
        [bottomBtn setTitle:knowMoreText forState:UIControlStateNormal];
        [bottomBtn setBackgroundColor:MAIN_COLOR];
        bottomBtn.layer.masksToBounds = YES;
        bottomBtn.layer.cornerRadius = 5;
        [bottomBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bottomBtn];
    }
    return self;
}

- (void)closeBtnCilck
{
    if(self.clickCallBack) {
        self.clickCallBack(0);
    }
}

- (void)bottomBtnClick
{
    if(self.clickCallBack) {
        self.clickCallBack(1);
    }
}


@end
