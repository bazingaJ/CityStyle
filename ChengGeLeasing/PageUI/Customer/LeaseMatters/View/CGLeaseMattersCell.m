//
//  CGLeaseMattersCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLeaseMattersCell.h"

@implementation CGLeaseMattersCell

- (void)setLeaseMattersModel:(CGLeaseMattersModel *)model {
    if(!model) return;
    
    //创建“联系人”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
    [lbMsg setText:model.linkman_name];
    [lbMsg setTextColor:MAIN_COLOR];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [lbMsg sizeToFit];
    [lbMsg setCenterY:20];
    [self.contentView addSubview:lbMsg];
    
    //创建“百分比”
    NSString *intentStr = @"0%";
    if(!IsStringEmpty(model.intent)) {
        intentStr = [[NSString stringWithFormat:@"%@",model.intent] stringByAppendingString:@"%"];
    }
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(lbMsg.right+10, 10, 60, 20)];
    [lbMsg2 setText:intentStr];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT14];
    [self.contentView addSubview:lbMsg2];
    
    //创建“时间”
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, 10, 140, 20)];
    [lbMsg3 setText:model.time];
    [lbMsg3 setTextColor:COLOR9];
    [lbMsg3 setTextAlignment:NSTextAlignmentRight];
    [lbMsg3 setFont:FONT13];
    [self.contentView addSubview:lbMsg3];
    
    //创建“意向铺位”
    UILabel *lbMsg4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH/2, 25)];
    [lbMsg4 setText:[NSString stringWithFormat:@"意向铺位：%@",model.pos_name]];
    [lbMsg4 setTextColor:COLOR9];
    [lbMsg4 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg4 setFont:FONT13];
    [self.contentView addSubview:lbMsg4];
    
    //创建“业务员”
    UILabel *lbMsg5 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, 30, 140, 25)];
    [lbMsg5 setText:[NSString stringWithFormat:@"业务员：%@",model.user_name]];
    [lbMsg5 setTextColor:COLOR9];
    [lbMsg5 setTextAlignment:NSTextAlignmentRight];
    [lbMsg5 setFont:FONT13];
    [self.contentView addSubview:lbMsg5];
    
    //创建“描述”
    NSString *introStr = model.intro;
    UILabel *lbMsg6 = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, SCREEN_WIDTH-20, 40)];
    [lbMsg6 setTextColor:COLOR3];
    [lbMsg6 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg6 setFont:FONT13];
    [lbMsg6 setNumberOfLines:2];
    if(!IsStringEmpty(introStr)) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:introStr];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:5.0f];
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, introStr.length)];
        [lbMsg6 setAttributedText:attStr];
    }
    [self.contentView addSubview:lbMsg6];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 99.5, SCREEN_WIDTH, 0.5)];
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
