//
//  CGMineSearchBarView.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineSearchBarView.h"

@implementation CGMineSearchBarView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = NAV_COLOR;
        
        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width-20, 28)];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [backView.layer setCornerRadius:3.0];
        [self addSubview:backView];
        
        //创建“搜索框”
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(backView.frame), 28)];
        searchBar.placeholder = @"搜索";
//        searchBar.tintColor = COLOR9;
        searchBar.layer.masksToBounds = YES;
        searchBar.layer.cornerRadius = 5.0;
        //设置搜索框的背景颜色
        //searchBar.barTintColor = [UIColor redColor];
        //searchBar.alpha = 0.2;
        //添加背景图,可以去掉外边框的灰色部分
        [searchBar setBackgroundImage:[UIImage new]];
        //[searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"clearImage"] forState:UIControlStateNormal];
        searchBar.delegate = self;
        searchBar.showsCancelButton = NO;
        [searchBar setImage:[UIImage imageNamed:@"room_icon_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        [backView addSubview:searchBar];
        
        //设置输入框背景色
        UITextField *searchTextField = [searchBar valueForKey:@"_searchField"];
        [searchTextField setTextColor:COLOR3];
        [searchTextField setFont:FONT15];
        [searchTextField setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
        [searchTextField setValue:FONT14 forKeyPath:@"_placeholderLabel.font"];
        [searchTextField.layer setCornerRadius:20];
        [searchTextField.layer setMasksToBounds:YES];
        searchTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        
//        //创建“取消”按钮
//        UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
//        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
//        [cancleBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        
        self.searchBar = searchBar;
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchBar resignFirstResponder];
}

- (void)presentVCFirstBackClick:(UIButton *)sender
{
    
}


/** 点击取消 */
- (void)cancelDidClick
{
    [self.searchBar resignFirstResponder];
    
}

#pragma mark - UISearchBarDelegate -


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"搜索");
    [self.searchBar resignFirstResponder];
    
    NSString *searchStr = searchBar.text;
    if(IsStringEmpty(searchStr)) {
        [MBProgressHUD showError:@"请输入搜索内容" toView:nil];
        return;
    }
    
    if([self.delegate respondsToSelector:@selector(CGMineSearchBarViewClick:)]) {
        [self.delegate CGMineSearchBarViewClick:searchStr];
    }
    
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar.text == nil || [searchBar.text length] <= 0) {
        [self.searchBar resignFirstResponder];
        
        if([self.delegate respondsToSelector:@selector(CGMineSearchBarViewClick:)]) {
            [self.delegate CGMineSearchBarViewClick:searchText];
        }
    } else {
        
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
