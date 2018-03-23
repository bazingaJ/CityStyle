//
//  CGMemberRemoveV.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGMemberRemoveV.h"

@implementation CGMemberRemoveV

- (instancetype)initWithFrame:(CGRect)frame windowTitle:(NSString *)titleStr
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = WHITE_COLOR;
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(width-30, 0, 30, 30);
        [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnCilck) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
        UIImageView *tipsImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tips"]];
        tipsImg.frame =CGRectMake(width * 0.5 - 15, 25, 30, 30);
        [self addSubview:tipsImg];
        
        UILabel *contentLab = [[UILabel alloc] init];
        contentLab.frame = CGRectMake(0, 65, width, 30);
        contentLab.text = titleStr;
        contentLab.textColor = COLOR3;
        contentLab.font = FONT18;
        contentLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:contentLab];
        
        UIView *vi = [UIView new];
        vi.frame = CGRectMake(0, height - 50, width, 50);
        vi.backgroundColor = kRGB(240, 240, 240);
        [self addSubview:vi];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(15, vi.y+10, 80, 30);
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [leftBtn setBackgroundColor:MAIN_COLOR];
        leftBtn.layer.masksToBounds = YES;
        leftBtn.layer.cornerRadius = 5;
        [leftBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(width - 95, vi.y+10, 80, 30);
        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [rightBtn setBackgroundColor:MAIN_COLOR];
        rightBtn.layer.masksToBounds = YES;
        rightBtn.layer.cornerRadius = 5;
        [rightBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
    }
    return self;
}

- (void)closeBtnCilck
{
    if(self.clickCallBack) {
        self.clickCallBack(0);
    }
}

- (void)leftBtnClick
{
    if(self.clickCallBack) {
        self.clickCallBack(1);
    }
}

- (void)rightBtnClick
{
    if(self.clickCallBack) {
        self.clickCallBack(2);
    }
}




@end
