//
//  CGPaymentTopV.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGPaymentTopV.h"
#import "CGOrderDetailVC.h"

static NSString *const successPicText = @"pay_success";
static NSString *const successText = @"支付完成";

static NSString *const detailBtnText = @"订单详情";

static NSString *const failPicText = @"pay_fail";
static NSString *const failText = @"支付失败";


@implementation CGPaymentTopV

- (instancetype)initWithFrame:(CGRect)frame payStatus:(BOOL)status
{
    
    if (self = [super initWithFrame:frame])
    {
        
        self.backgroundColor = GRAY_COLOR;
        // payment status symbol picture
        UIImageView *signImageView = [[UIImageView alloc] init];
        signImageView.frame = CGRectMake(SCREEN_WIDTH * 0.5 -30, 70, 60, 60);
        signImageView.image = [UIImage imageNamed:failPicText];
        [self addSubview:signImageView];
        
        
        UILabel *signLab = [UILabel new];
        signLab.frame = CGRectMake((SCREEN_WIDTH - 200) * 0.5, 170, 200, 30);
        signLab.text = failText;
        signLab.textColor = COLOR3;
        signLab.font = [UIFont boldSystemFontOfSize:20];
        signLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:signLab];
        
        
        if (status == YES)
        {
            signImageView.image = [UIImage imageNamed:successPicText];
            signLab.text = successText;
            
            UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            signBtn.frame = CGRectMake((SCREEN_WIDTH - 150) * 0.5, 210, 150, 20);
            signBtn.titleLabel.font = FONT15;
            [signBtn setTitle:detailBtnText forState:UIControlStateNormal];
            [signBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [signBtn addTarget:self action:@selector(detailBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:signBtn];

        }
        
        
        
    }
    
    return self;
}

- (void)detailBtnClick
{
    UIViewController *currentVC = [JXTool currentViewController];
    CGOrderDetailVC *vc = [[CGOrderDetailVC alloc] init];
    vc.model = self.model;
    [currentVC.navigationController pushViewController:vc animated:YES];
}

@end
