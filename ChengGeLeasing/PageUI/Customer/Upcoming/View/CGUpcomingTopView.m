//
//  CGUpcomingTopView.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGUpcomingTopView.h"

@implementation CGUpcomingTopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        NSMutableArray *titleArr = [NSMutableArray array];
        [titleArr addObject:@[@"upcoming_yes_finished",@"未完成",@"2"]];
        [titleArr addObject:@[@"upcoming_no_finished",@"已完成",@"1"]];
        
        CGFloat tWidth = SCREEN_WIDTH/[titleArr count];
        for (int i=0; i<[titleArr count]; i++) {
            NSArray *itemArr = [titleArr objectAtIndex:i];
            
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(tWidth*i, 0, tWidth, 35)];
            [btnFunc setTitle:itemArr[1] forState:UIControlStateNormal];
            if(i==1) {
                [btnFunc setTitleColor:NAV_COLOR forState:UIControlStateNormal];
            }else if(i==0) {
                [btnFunc setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            }
            [btnFunc.titleLabel setFont:FONT16];
            [btnFunc setImage:[UIImage imageNamed:itemArr[0]] forState:UIControlStateNormal];
            [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            [btnFunc setTag:[itemArr[2] integerValue]];
            [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnFunc];
            
            //创建“分割线”
            if(i==1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(tWidth-0.5, 5, 0.5, 25)];
                [lineView setBackgroundColor:LINE_COLOR];
                [self addSubview:lineView];
            }
            
        }
        
    }
    return self;
}

/**
 *  筛选按钮点击事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"筛选按钮点击事件");
    
    for (UIView *view in btnSender.superview.subviews) {
        if([view isKindOfClass:[UIButton class]]) {
            UIButton *btnFunc = (UIButton *)view;
            [btnFunc setTitleColor:NAV_COLOR forState:UIControlStateNormal];
            [btnFunc setImage:[UIImage imageNamed:@"upcoming_no_finished"] forState:UIControlStateNormal];
        }
    }
    
    [btnSender setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [btnSender setImage:[UIImage imageNamed:@"upcoming_yes_finished"] forState:UIControlStateNormal];
    
    if([self.delegate respondsToSelector:@selector(CGUpcomingTopViewClick:)]) {
        [self.delegate CGUpcomingTopViewClick:btnSender.tag];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
