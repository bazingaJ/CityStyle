//
//  CGBusinessMattersCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGBusinessMattersCell.h"

@implementation CGBusinessMattersCell

- (void)setBusinessMattersModel:(CGBusinessMattersModel *)model {
    if(!model) return;
    
    //创建“客户名称”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
    [lbMsg setText:model.cust_name];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [lbMsg sizeToFit];
    [lbMsg setCenterY:20];
    [self.contentView addSubview:lbMsg];
    
    //创建“状态”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-110, 10, 100, 20)];
    [lbMsg2 setText:model.status_name];
    [lbMsg2 setTextColor:MAIN_COLOR];
    [lbMsg2 setTextAlignment:NSTextAlignmentRight];
    [lbMsg2 setFont:FONT15];
    [self.contentView addSubview:lbMsg2];
    
    //创建“联系人”
    UILabel *lbMsg4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH/2, 25)];
    if (IsStringEmpty(model.linkman_name))
    {
        [lbMsg4 setText:[NSString stringWithFormat:@"联系人：%@",@"暂无"]];
    }
    else
    {
        [lbMsg4 setText:[NSString stringWithFormat:@"联系人：%@",model.linkman_name]];
    }
    [lbMsg4 setTextColor:COLOR9];
    [lbMsg4 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg4 setFont:FONT14];
    [self.contentView addSubview:lbMsg4];
    
    //创建“业务员”
    UILabel *lbMsg5 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, 30, 140, 25)];
    [lbMsg5 setText:model.add_time];
    [lbMsg5 setTextColor:COLOR9];
    [lbMsg5 setTextAlignment:NSTextAlignmentRight];
    [lbMsg5 setFont:FONT13];
    [self.contentView addSubview:lbMsg5];
    
    //创建“描述”
    NSString *introStr = model.intro;
    UILabel *lbMsg6 = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, SCREEN_WIDTH-20, 40)];
    [lbMsg6 setTextColor:COLOR9];
    [lbMsg6 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg6 setFont:FONT12];
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

@end
