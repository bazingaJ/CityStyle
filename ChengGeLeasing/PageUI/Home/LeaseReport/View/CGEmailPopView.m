//
//  CGEmailPopView.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGEmailPopView.h"

@implementation CGEmailPopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpView];
    }
    return self;
}

-(void)setUpView
{
    //创建"背景"
    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.backgroundColor = kRGB(239, 239, 239);
    [self addSubview:bgView];
    
    //创建"黑色头部"
    UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 50)];
    lbMsg.textAlignment =NSTextAlignmentCenter;
    lbMsg.textColor = WHITE_COLOR;
    lbMsg.font = FONT14;
    lbMsg.text = @"导出邮箱";
    lbMsg.backgroundColor = kRGB(34, 40, 62);
    [bgView addSubview:lbMsg];
    
    //创建"白色背景"
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 50, self.width, 55)];
    view.backgroundColor = WHITE_COLOR;
    [bgView addSubview:view];
    
    //创建"邮箱输入框"
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 60, self.width-30, 25)];
    self.textField.placeholder =@"请输入邮箱";
    self.textField.font =FONT13;
    [bgView addSubview:self.textField];
    
    //创建"黑色横线"
    UILabel *lineLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 95, self.width -30, .5)];
    lineLab.backgroundColor = LINE_COLOR;
    [bgView addSubview:lineLab];
    
//    创建"取消按钮"
    NSArray *titleArr =@[@"取消",@"确定"];
    for (int i =0; i<2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =CGRectMake(15, 125, 50, 20);
        if (i==1)
        {
            btn.frame = CGRectMake(self.width-65, 125, 50, 20);
        }
        btn.layer.cornerRadius =3;
        btn.clipsToBounds = YES;
        btn.titleLabel.font =FONT13;
        btn.backgroundColor = UIColorFromRGBWith16HEX(0x789BD4);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.tag =20+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
        
    }
}

-(void)btnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(cgEmailPopView:)])
    {
        [self.delegate cgEmailPopView:sender];
    }
}
@end
