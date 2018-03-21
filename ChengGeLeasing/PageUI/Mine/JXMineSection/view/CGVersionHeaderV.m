//
//  CGVersionHeaderV.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/21.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGVersionHeaderV.h"

static NSString *const introduceUpText = @"企 业 VIP 版";
static NSString *const introduceMidText = @"￥99 / 人 / 月";
static NSString *const introduceDownText = @"适用于各规模团队和企业";

@implementation CGVersionHeaderV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //创建“背景层”
        UIImageView *imgView = [[UIImageView alloc] init];
        [imgView setImage:[UIImage imageNamed:@"mine_icon_head"]];
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.mas_equalTo(self);
        }];
        
        UILabel *introduceLab = [[UILabel alloc] init];
        introduceLab.text = introduceMidText;
        introduceLab.textColor = WHITE_COLOR;
        introduceLab.font = [UIFont systemFontOfSize:30];
        introduceLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:introduceLab];
        [introduceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        UILabel *introduceLabUp = [[UILabel alloc] init];
        introduceLabUp.text = introduceUpText;
        introduceLabUp.textColor = WHITE_COLOR;
        introduceLabUp.font = [UIFont boldSystemFontOfSize:35];
        introduceLabUp.textAlignment = NSTextAlignmentCenter;
        [self addSubview:introduceLabUp];
        [introduceLabUp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(introduceLab);
            make.bottom.mas_equalTo(introduceLab.mas_top).offset(-15);
        }];
        
        UILabel *introduceLabDown = [[UILabel alloc] init];
        introduceLabDown.text = introduceDownText;
        introduceLabDown.textColor = WHITE_COLOR;
        introduceLabDown.font = [UIFont systemFontOfSize:17];
        introduceLabDown.textAlignment = NSTextAlignmentCenter;
        [self addSubview:introduceLabDown];
        [introduceLabDown mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(introduceLab);
            make.top.mas_equalTo(introduceLab.mas_bottom).offset(15);
        }];
    }
    return self;
}

@end
