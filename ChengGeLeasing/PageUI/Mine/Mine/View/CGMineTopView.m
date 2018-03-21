//
//  CGMineTopView.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTopView.h"
#import "CGUpgradeVersionVC.h"

const CGFloat JXMineHeaderViewHeight = 230;

/**
 文字
 */
static NSString *const freeAccountSignText = @"免费版";
static NSString *const paidAccountSignText = @"VIP企业版";
static NSString *const countingText = @"剩余11天19小时";
/**
 图片
 */
// 免费版 升级
static NSString *const updatePhotoText = @"update";
// 企业版 倒计时
static NSString *const timingPhotoText = @"timing";

@interface CGMineTopView ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *lbNickName;
@property (nonatomic, strong) UILabel *lbMobile;

@end

@implementation CGMineTopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        //创建“背景层”
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, JXMineHeaderViewHeight)];
        [imgView setImage:[UIImage imageNamed:@"mine_icon_head"]];
        [imgView setUserInteractionEnabled:NO];
        [self addSubview:imgView];
        
        //创建“编辑”
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-35, 15, 20, 20)];
        [btnFunc setImage:[UIImage imageNamed:@"mine_icon_edit"] forState:UIControlStateNormal];
        [btnFunc addTouch:^{
            if([self.delegate respondsToSelector:@selector(CGMineTopViewEditInfoClick:)]) {
                [self.delegate CGMineTopViewEditInfoClick:0];
            }
        }];
        [self addSubview:btnFunc];
        
        //创建“头像”
        WS(weakSelf);
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-85)/2, 30, 85, 85)];
        [self.imgView setContentMode:UIViewContentModeScaleAspectFill];
        [self.imgView setClipsToBounds:YES];
        [self.imgView.layer setCornerRadius:42.5];
        [self.imgView.layer setBorderWidth:2];
        [self.imgView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
        [self.imgView setUserInteractionEnabled:YES];
        [self.imgView addTouch:^{
            if([weakSelf.delegate respondsToSelector:@selector(CGMineTopViewEditInfoClick:)]) {
                [weakSelf.delegate CGMineTopViewEditInfoClick:1];
            }
        }];
        [self addSubview:self.imgView];
        
        //创建“用户昵称”
        self.lbNickName = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, frame.size.width-20, 20)];
        [self.lbNickName setText:@"请登录"];
        [self.lbNickName setTextColor:[UIColor whiteColor]];
        [self.lbNickName setTextAlignment:NSTextAlignmentCenter];
        [self.lbNickName setFont:FONT17];
        [self.lbNickName setUserInteractionEnabled:YES];
        [self.lbNickName addTouch:^{
            if([weakSelf.delegate respondsToSelector:@selector(CGMineTopViewEditInfoClick:)]) {
                [weakSelf.delegate CGMineTopViewEditInfoClick:2];
            }
        }];
        [self addSubview:self.lbNickName];
        
        //创建“手机号码”
        self.lbMobile = [[UILabel alloc] initWithFrame:CGRectMake(10, 155, frame.size.width-20, 20)];
        [self.lbMobile setTextColor:[UIColor whiteColor]];
        [self.lbMobile setTextAlignment:NSTextAlignmentCenter];
        [self.lbMobile setFont:FONT16];
        [self addSubview:self.lbMobile];
        
        // 创建免费账户标志
        [self createFreeAccountSignButton];
        
        // 创建企业版账户标志
//        [self createEnterpriesSignButton];
    }
    return self;
}

#pragma mark - 创建免费版账户识别标志
- (void)createFreeAccountSignButton
{
    UILabel *signLab = [[UILabel alloc] init];
    signLab.font = FONT13;
    signLab.layer.cornerRadius = 5;
    signLab.textColor = WHITE_COLOR;
    signLab.layer.masksToBounds = YES;
    signLab.text = freeAccountSignText;
    signLab.backgroundColor = MAIN_COLOR;
    signLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:signLab];
    [signLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lbNickName).offset(60);
        make.centerX.mas_equalTo(self).offset(-20);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(22);
    }];
    
    UIImageView *freeSignImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:updatePhotoText]];
    [self addSubview:freeSignImageView];
    [freeSignImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(signLab.mas_right).offset(10);
        make.top.mas_equalTo(signLab.mas_top);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    // create a cover layer button
    UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [coverBtn setBackgroundColor:CLEAR_COLOR];
    [coverBtn setTitle:@"" forState:UIControlStateNormal];
    [coverBtn addTarget:self action:@selector(upgradeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:coverBtn];
    [coverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(signLab.mas_left);
        make.right.mas_equalTo(freeSignImageView.mas_right);
        make.top.mas_equalTo(signLab.mas_top).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}

#pragma mark - 创建企业版账户识别标志
- (void)createEnterpriesSignButton
{
    UILabel *signLab = [[UILabel alloc] init];
    signLab.font = FONT13;
    signLab.layer.cornerRadius = 5;
    signLab.textColor = WHITE_COLOR;
    signLab.layer.masksToBounds = YES;
    signLab.text = paidAccountSignText;
    signLab.backgroundColor = MAIN_COLOR;
    signLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:signLab];
    [signLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lbNickName).offset(50);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(22);
    }];
    
    UIImageView *timingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:timingPhotoText]];
    [self addSubview:timingImageView];
    [timingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(signLab).offset(-10);
        make.top.mas_equalTo(signLab.mas_bottom).offset(7);
        make.width.height.mas_equalTo(15);
    }];
    
    UILabel *timingLab = [[UILabel alloc] init];
    timingLab.font = FONT12;
    timingLab.text = countingText;
    timingLab.textColor = WHITE_COLOR;
    [self addSubview:timingLab];
    [timingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timingImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(timingImageView.mas_centerY);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    
}
- (void)setMineTopModel:(CGUserModel *)model {
    
    //设置用户头像
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
    
    //设置用户名
    [self.lbNickName setText:model.nickname];
    
    //设置手机号码
    [self.lbMobile setText:[HelperManager CreateInstance].mobile];
    
}

// cover button click method
- (void)upgradeBtnClick
{
    UIViewController *vc = [JXTool currentViewController];
    CGUpgradeVersionVC *updateVC = [CGUpgradeVersionVC new];
    [vc.navigationController pushViewController:updateVC animated:YES];
}

@end
