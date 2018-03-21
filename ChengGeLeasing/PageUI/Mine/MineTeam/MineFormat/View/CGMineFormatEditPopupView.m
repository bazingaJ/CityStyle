//
//  CGMineFormatEditPopupView.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineFormatEditPopupView.h"

@implementation CGMineFormatEditPopupView

- (id)initWithFrame:(CGRect)frame titleStr:(NSString *)titleStr contentStr:(NSString *)contentStr {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //创建“添加、编辑业态”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
        [lbMsg setText:titleStr];
        [lbMsg setTextColor:[UIColor whiteColor]];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setFont:FONT20];
        [lbMsg setBackgroundColor:NAV_COLOR];
        [self addSubview:lbMsg];
        
        //创建“输入面板”
        UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(15, 65, frame.size.width-30, 30)];
        [tbxContent setPlaceholder:@"请输入业态名称"];
        [tbxContent setText:contentStr];
        [tbxContent setTextAlignment:NSTextAlignmentLeft];
        [tbxContent setTextColor:COLOR3];
        [tbxContent setFont:FONT15];
        [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
        [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
        [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:tbxContent];
        
        //创建“下划线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 100, frame.size.width-30, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [self addSubview:lineView];

        //创建“底部面板”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-50, frame.size.width, 50)];
        [backView setBackgroundColor:GRAY_COLOR];
        [self addSubview:backView];
        
        //创建“取消”、“确定”
        CGFloat tWidth = frame.size.width-15*2-50;
        for (int i=0; i<2; i++) {
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(15+tWidth*i, 12.5, 50, 25)];
            if(i==0) {
                [btnFunc setTitle:@"取消" forState:UIControlStateNormal];
            }else if(i==1) {
                [btnFunc setTitle:@"确定" forState:UIControlStateNormal];
            }
            [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT12];
            [btnFunc setBackgroundColor:MAIN_COLOR];
            [btnFunc.layer setCornerRadius:4.0];
            [btnFunc setTag:i];
            [btnFunc addTouch:^{
                
                [self endEditing:YES];

                //输入文本验证
                NSString *contentStr = tbxContent.text;
                if(i==1 && IsStringEmpty(contentStr)) {
                    [MBProgressHUD showError:@"请输入业态名称" toView:nil];
                }else{
                    if(self.callBack) {
                        self.callBack(i, tbxContent.text);
                    }
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
