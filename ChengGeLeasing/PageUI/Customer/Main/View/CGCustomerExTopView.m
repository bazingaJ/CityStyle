//
//  CGCustomerExTopView.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGCustomerExTopView.h"

@interface CGCustomerExTopView ()

/**
 *  客户资源数
 */
@property (nonatomic, strong) UILabel *lblNum;
/**
 *  客户资源数
 */
@property (nonatomic, strong) UILabel *lblMineNum;

@end

@implementation CGCustomerExTopView

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
        
        //创建“分类筛选条”
//        UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 65, self.frame.size.width, 45)];
//        [backView2 setBackgroundColor:[UIColor whiteColor]];
//        [self addSubview:backView2];
        
        WS(weakSelf);
        
        //创建“筛选框”
        NSMutableArray *titleArr = [NSMutableArray array];
        [titleArr addObject:@[@"业态",@"301"]];
        [titleArr addObject:@[@"意向度",@"10000"]];
        [titleArr addObject:@[@"业务员",@"200"]];
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
        self.dropDownMenu.callIntentionBack = ^(NSString *intentionStr) {
            NSLog(@"意向度回调成功：%@",intentionStr);
            
            if([weakSelf.delegate respondsToSelector:@selector(CGCustomerTopViewIntentionSelectClick:)]) {
                [weakSelf.delegate CGCustomerTopViewIntentionSelectClick:intentionStr];
            }
            
        };
        self.dropDownMenu.callFormatBack = ^(NSString *cate_id, NSString *cate_name) {
            NSLog(@"业态回调成功：%@-%@",cate_id,cate_name);
            
            if([weakSelf.delegate respondsToSelector:@selector(CGCustomerTopViewFormatSelectClick:)]) {
                [weakSelf.delegate CGCustomerTopViewFormatSelectClick:cate_id];
            }
            
        };
        self.dropDownMenu.callTeamMemberBack = ^(NSString *member_id, NSString *member_name) {
            NSLog(@"业务员回调成功:%@-%@",member_id,member_name);
            
            if([weakSelf.delegate respondsToSelector:@selector(CGCustomerTopViewTeamMemberSelectClick:)]) {
                [weakSelf.delegate CGCustomerTopViewTeamMemberSelectClick:member_id];
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
        
        //我的客户数
        self.lblMineNum = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, backView.frame.size.width-160, 30)];
        [self.lblMineNum setText:@"我的客户：0"];
        [self.lblMineNum setTextColor:COLOR3];
        [self.lblMineNum setTextAlignment:NSTextAlignmentRight];
        [self.lblMineNum setFont:FONT14];
        [backView addSubview:self.lblMineNum];
        
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

- (void)setMineNum:(NSString *)mineNum {
    _mineNum = mineNum;
    [self.lblMineNum setText:[NSString stringWithFormat:@"我的客户：%@",mineNum]];
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
