//
//  CGNetdiscEmailPopupView.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/20.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGNetdiscEmailPopupView.h"

@implementation CGNetdiscEmailPopupView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //创建“导出邮箱”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
        [lbMsg setText:@"导出邮箱"];
        [lbMsg setTextColor:[UIColor whiteColor]];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setFont:FONT17];
        [lbMsg setBackgroundColor:UIColorFromRGBWith16HEX(0x2E374F)];
        [self addSubview:lbMsg];
        
        //创建“邮箱输入框”
        UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(15, 80, frame.size.width-30, 30)];
        [tbxContent setPlaceholder:@"请输入邮箱"];
        [tbxContent setTextAlignment:NSTextAlignmentLeft];
        [tbxContent setTextColor:COLOR3];
        [tbxContent setFont:FONT16];
        [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
        [tbxContent setValue:FONT16 forKeyPath:@"_placeholderLabel.font"];
        [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:tbxContent];
        
        //创建“下划线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 120, frame.size.width-30, 1)];
        [lineView setBackgroundColor:LINE_COLOR];
        [self addSubview:lineView];
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, frame.size.width, 50)];
        [backView setBackgroundColor:UIColorFromRGBWith16HEX(0xF2F2F2)];
        [self addSubview:backView];
        
        //创建“功能按钮”
        CGFloat tWidth = frame.size.width-15*2-50*2;
        for (int i=0; i<2; i++) {
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(15+(tWidth+50)*i, 12.5, 50, 25)];
            if(i==0) {
                [btnFunc setTitle:@"取消" forState:UIControlStateNormal];
            }else if(i==1) {
                [btnFunc setTitle:@"确定" forState:UIControlStateNormal];
            }
            [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT12];
            [btnFunc setBackgroundColor:MAIN_COLOR];
            [btnFunc.layer setCornerRadius:3.0];
            [btnFunc.layer setMasksToBounds:YES];
            [btnFunc addTouch:^{
                NSLog(@"点击了按钮");
                
                NSString *emailStr = tbxContent.text;
                if(i==1 && ![emailStr isEmail]) {
                    [MBProgressHUD showError:@"请输入正确的邮箱" toView:nil];
                    return;
                }
                
                if(self.callBack) {
                    self.callBack(i, emailStr);
                }
                
            }];
            [backView addSubview:btnFunc];
        }
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
