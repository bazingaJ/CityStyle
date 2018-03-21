//
//  CGMineTransferCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTransferCell.h"

@implementation CGMineTransferCell

- (void)setCustomerModel:(CGTeamMemberModel *)model {
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
    [self.contentView addSubview:lbMsg];
    
    //创建“选择”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-35, 25, 25, 25)];
    if(model.is_selected) {
        [btnFunc setImage:[UIImage imageNamed:@"mine_icon_selected"] forState:UIControlStateNormal];
    }else{
        [btnFunc setImage:[UIImage imageNamed:@"mine_icon_normal"] forState:UIControlStateNormal];
    }
    [btnFunc addTouch:^{
        NSLog(@"选择");
        if([self.delegate respondsToSelector:@selector(CGMineTransferCellClick:)]) {
            [self.delegate CGMineTransferCellClick:model];
        }
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
