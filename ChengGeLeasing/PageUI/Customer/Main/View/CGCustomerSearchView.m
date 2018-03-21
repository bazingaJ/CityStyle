//
//  CGCustomerSearchView.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/8/1.
//  Copyright © 2017年 田浩渺. All rights reserved.
//

#import "CGCustomerSearchView.h"

@implementation CGCustomerSearchView

-(void)setUpSearchView
{
    //创建"背景"
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    backView.backgroundColor = [UIColor clearColor];
    [self addSubview:backView];
    
    //创建"输入框背景"
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH -20 -65, 25)];
    view.backgroundColor = kRGB(235, 235, 235);
    view.layer.cornerRadius =3;
    view.clipsToBounds = YES;
    [backView addSubview:view];
    
    //创建"搜索框"
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(12, 0, view.frame.size.width -30, 25)];
    self.textField .placeholder = @"客户名称";
    self.textField .font = FONT15;
    [view addSubview:self.textField ];
    
    //创建"搜索按钮"
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH-65, 0, 65, 45);
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn setTitleColor:self.btnTitleColor forState:UIControlStateNormal];
    btn.titleLabel.font = FONT15;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
}

-(void)btnClick:(UIButton *)sender
{
    if (self.callBack)
    {
       
        self.callBack(self.textField.text);
    }
}

@end
