//
//  CGSegmentView.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGSegmentView.h"

@interface CGSegmentView ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation CGSegmentView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //初始化参数
        self.selectedIndex = 0;
        
    }
    return self;
}

- (void)setTitleArr:(NSArray *)titleArr {
    _titleArr = titleArr;
    
    NSInteger titleNum = titleArr.count;
    for (int i=0; i<titleNum; i++) {
        
        //创建“标题”
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/titleNum*i, 0,SCREEN_WIDTH/titleNum, 40)];
        [btnFunc setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        [btnFunc setTitleColor:COLOR9 forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT16];
        [btnFunc setTag:i+100];
        [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnFunc];
        
        if(i==self.selectedIndex) {
            
            //设置选中字体颜色
            [btnFunc setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            
            //创建“下划线”
            self.lineView = [[UIView alloc] initWithFrame:CGRectMake((btnFunc.frame.size.width-50)/2, btnFunc.frame.size.height-2, 50, 2)];
            self.lineView.backgroundColor = MAIN_COLOR;
            [btnFunc addSubview:self.lineView];
        }
    }
    
    //创建“下划线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self addSubview:lineView];
    
}

/**
 *  标题点击事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"标题点击事件");
    
    if([self.delegate respondsToSelector:@selector(CGSegmentViewDidSelectAtIndexClick:)]) {
        [self.delegate CGSegmentViewDidSelectAtIndexClick:btnSender.tag-100];
    }
    
    NSInteger tagNum = [btnSender tag];
    UIButton *currentBtn = (UIButton *)[self viewWithTag:tagNum];
    for (int i=0; i<self.titleArr.count; i++) {
        if (i != tagNum) {
            UIButton *btn = (UIButton *)[self viewWithTag:i+100];
            [btn setTitleColor:COLOR9 forState:UIControlStateNormal];
        }
    }
    
    [UIView animateKeyframesWithDuration:0.1
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionLayoutSubviews
                              animations:^{
                                  self.lineView.center = CGPointMake(currentBtn.center.x, self.lineView.center.y);
                              }
                              completion:^(BOOL finished) {
                                  [currentBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
                              }];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
