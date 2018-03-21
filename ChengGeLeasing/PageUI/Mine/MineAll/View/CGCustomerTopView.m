//
//  CGCustomerTopView.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGCustomerTopView.h"

@interface CGCustomerTopView ()

/**
 *  客户资源数
 */
@property (nonatomic, strong) UILabel *lblNum;

@end

@implementation CGCustomerTopView

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

- (id)initWithFrame:(CGRect)frame isXiangmu:(BOOL)isXiangmu {
    self = [super initWithFrame:frame];
    if(self) {
     
        self.backgroundColor = BACK_COLOR;
        
        //创建“搜索视图”
        [self searchView];
        
        WS(weakSelf);
        
        //创建“筛选框”
        NSMutableArray *titleArr = [NSMutableArray array];
        if(isXiangmu) {
            [titleArr addObject:@[@"项目",@"2000"]];
        }
        [titleArr addObject:@[@"业态",@"301"]];
        [titleArr addObject:@[@"A-Z",@"1000"]];
        self.dropDownMenu = [[CGDropDownMenu alloc] initWithFrame:CGRectMake(0, 65, self.frame.size.width, 45) titleArr:titleArr];
        [self.dropDownMenu setTopH:85];
        if(isXiangmu) {
                    [self.dropDownMenu setIsSP:YES];
        }
        self.dropDownMenu.callTeamXiangmuBack = ^(NSString *pro_id, NSString *pro_name) {
            NSLog(@"项目回调成功：%@-%@",pro_id,pro_name);
            
            if([weakSelf.delegate respondsToSelector:@selector(CGCustomerTopViewTeamXiangmuSelectClick:)]) {
                [weakSelf.delegate CGCustomerTopViewTeamXiangmuSelectClick:pro_id];
            }
            
        };
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
        
        //创建“客户资源数”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, self.frame.size.width, 30)];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:backView];
        
        //创建“竖线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        [lineView setBackgroundColor:MAIN_COLOR];
        [backView addSubview:lineView];
        
        //创建“数字”
        self.lblNum = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-20, 30)];
        [self.lblNum setText:@"客户资源数：0"];
        [self.lblNum setTextColor:COLOR3];
        [self.lblNum setTextAlignment:NSTextAlignmentLeft];
        [self.lblNum setFont:FONT14];
        [backView addSubview:self.lblNum];
        
    }
    return self;
}

/**
 *  设置客户资源数
 */
- (void)setCustomerNum:(NSString *)customerNum {
    _customerNum = customerNum;
    [self.lblNum setText:[NSString stringWithFormat:@"客户资源数：%@",customerNum]];
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
