//
//  CGMineTeamMemberListCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamMemberListCell.h"

@implementation CGMineTeamMemberListCell

- (void)setTeamMemberModel:(CGTeamMemberModel *)model indexPath:(NSIndexPath *)indexPath {
    if(!model) return;
    
    //创建“头像”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 55, 55)];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [imgView setClipsToBounds:YES];
    [imgView.layer setCornerRadius:4.0];
    [imgView.layer setMasksToBounds:YES];
    [imgView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"contact_icon_avatar"]];
    [self.contentView addSubview:imgView];
    
    //创建“成员名称”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, SCREEN_WIDTH-120, 20)];
    [lbMsg setText:model.name];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [lbMsg sizeToFit];
    [lbMsg setCenterY:20];
    [self.contentView addSubview:lbMsg];
    
    if (!IsStringEmpty(model.team_name))
    {
        //创建“分组”
        UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(lbMsg.right+10, 10, SCREEN_WIDTH-(lbMsg.right+10)-50, 20)];
        [lbMsg3 setText:[NSString stringWithFormat:@"(%@)",model.team_name]];
        [lbMsg3 setTextColor:COLOR9];
        [lbMsg3 setTextAlignment:NSTextAlignmentLeft];
        [lbMsg3 setFont:FONT16];
        [self.contentView addSubview:lbMsg3];
    }

    //创建“打电话”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 10, 30, 30)];
    [btnFunc setImage:[UIImage imageNamed:@"mine_icon_tel"] forState:UIControlStateNormal];
    [btnFunc addTouch:^{
        NSLog(@"电话");
        
        NSString *telStr = model.mobile;
        if(IsStringEmpty(telStr)) {
            [MBProgressHUD showError:@"暂无电话" toView:nil];
            return ;
        }
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel://%@",telStr];
        UIWebView *callWebView = [[UIWebView alloc] init];
        [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.contentView addSubview:callWebView];
        
    }];
    [self.contentView addSubview:btnFunc];
    
    //创建“手机号码”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(75, 45, SCREEN_WIDTH-120, 20)];
    [lbMsg2 setText:model.mobile];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT14];
    [self.contentView addSubview:lbMsg2];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 74.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
