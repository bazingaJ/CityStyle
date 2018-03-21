//
//  CGSearchBarView.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGSearchBarView.h"

@implementation CGSearchBarView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, 10, frame.size.width-85, 25)];
        [backView.layer setCornerRadius:3.0];
        [backView.layer setMasksToBounds:YES];
        [backView setBackgroundColor:LINE_COLOR];
        [self addSubview:backView];
        
        //创建“输入框”
        self.tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-20, 25)];
        [self.tbxContent setPlaceholder:@"客户名称"];
        [self.tbxContent setTextAlignment:NSTextAlignmentLeft];
        [self.tbxContent setTextColor:COLOR3];
        [self.tbxContent setFont:FONT15];
        [self.tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
        [self.tbxContent setValue:FONT14 forKeyPath:@"_placeholderLabel.font"];
        [self.tbxContent setDelegate:self];
        [self.tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self.tbxContent setReturnKeyType:UIReturnKeySearch];
        [self.tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [backView addSubview:self.tbxContent];
        
        //创建“搜索”按钮
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-65, 10, 65, 25)];
        [btnFunc setTitle:@"搜索" forState:UIControlStateNormal];
        [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT15];
        [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnFunc];
        
    }
    return self;
}

- (void)textFieldDidChange:(UITextField *)textField {
    if([textField.text isEqualToString:@""]) {
        [self endEditing:YES];
        
        if([self.delegate respondsToSelector:@selector(CGSearchBarViewClick:)]) {
            [self.delegate CGSearchBarViewClick:@""];
        }
    }

}


- (BOOL)textFieldShouldClear:(UITextField *)textField {
    NSLog(@"清除");
    
    [self endEditing:YES];
    
    if([self.delegate respondsToSelector:@selector(CGSearchBarViewClick:)]) {
        [self.delegate CGSearchBarViewClick:@""];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"搜索结果：%@",textField.text);
    
    [self btnFuncClick:nil];
    
    return YES;
}

/**
 *  搜索按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"搜索");
    [self endEditing:YES];
    
    NSString *searchStr = self.tbxContent.text;
    if(IsStringEmpty(searchStr)) {
        [MBProgressHUD showError:@"请输入客户名称" toView:nil];
        return;
    }
    
    if([self.delegate respondsToSelector:@selector(CGSearchBarViewClick:)]) {
        [self.delegate CGSearchBarViewClick:searchStr];
    }
    
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
