//
//  CGChubeiCustomerTopView.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGChubeiCustomerTopView.h"

@implementation CGChubeiCustomerTopView

/**
 *  搜索视图
 */
- (CGSearchBarView *)searchView {
    if(!_searchView) {
        _searchView = [[CGSearchBarView alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, 45)];
        [_searchView setDelegate:self];
        [self addSubview:_searchView];
    }
    return _searchView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = BACK_COLOR;
        
        //创建“搜索视图”
        [self searchView];
        
        WS(weakSelf);
        
        //创建“筛选框”
        NSMutableArray *titleArr = [NSMutableArray array];
        [titleArr addObject:@[@"业态",@"301"]];
        [titleArr addObject:@[@"A-Z",@"1000"]];
        self.dropDownMenu = [[CGDropDownMenu alloc] initWithFrame:CGRectMake(0, 65, self.frame.size.width, 45) titleArr:titleArr];
        [self.dropDownMenu setTopH:85];
        self.dropDownMenu.callAZBack = ^(NSString *letter) {
            NSLog(@"字母回调成功：%@",letter);
            
            NSString *pinyinStr = @"";
            
            //拼音 【所有】传 all , 【0-9】传 num
            if([letter isEqualToString:@"ALL"]) {
                pinyinStr = @"all";
            }else if([letter isEqualToString:@"0-9"]) {
                pinyinStr = @"num";
            }else{
                pinyinStr = letter;
            }
            
            if([weakSelf.delegate respondsToSelector:@selector(CGCustomerTopViewAZSelectClick:)]) {
                [weakSelf.delegate CGCustomerTopViewAZSelectClick:pinyinStr];
            }
            
        };
        self.dropDownMenu.callFormatBack = ^(NSString *cate_id, NSString *cate_name) {
            NSLog(@"业态回调成功：%@-%@",cate_id,cate_name);
            
            if([weakSelf.delegate respondsToSelector:@selector(CGCustomerTopViewFormatSelectClick:)]) {
                [weakSelf.delegate CGCustomerTopViewFormatSelectClick:cate_id];
            }
            
        };
        [self addSubview:self.dropDownMenu];
        
    }
    return self;
}

/**
 *  搜索委托代理
 */
- (void)CGSearchBarViewClick:(NSString *)searchStr {
    NSLog(@"搜索委托代理");
    if([self.delegate respondsToSelector:@selector(CGCustomerTopViewSearchBarViewClick:)]) {
        [self.delegate CGCustomerTopViewSearchBarViewClick:searchStr];
    }
}

/**
 *  隐藏
 */
- (void)dismiss {
    [self.dropDownMenu dismiss];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
