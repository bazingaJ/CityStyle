//
//  CGUpcomingCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGUpcomingCell.h"

@implementation CGUpcomingCell

- (void)setUpcomingModel:(CGMineMessageUpcomingModel *)model indexPath:(NSIndexPath *)indexPath{
    if(!model) return;
    
    self.indexPath = indexPath;
    
    //创建“消息内容”
    NSString *contentStr = model.content;
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 40)];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setFont:FONT15];
    [lbMsg setNumberOfLines:2];
    if(!IsStringEmpty(contentStr)) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:5.0f];
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
        [lbMsg setAttributedText:attStr];
    }
    [self.contentView addSubview:lbMsg];
    
    //创建“时间”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 150, 15)];
    [lbMsg2 setText:model.time];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT13];
    [self.contentView addSubview:lbMsg2];
    
    //创建“客户名称”
    NSString *linkStr = model.linkman_name;
    if(!IsStringEmpty(model.cust_name)) {
        linkStr = [NSString stringWithFormat:@"%@(%@)",linkStr,model.cust_name];
    }
    
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(160, 55, SCREEN_WIDTH-170, 15)];
    [lbMsg3 setText:linkStr];
    [lbMsg3 setTextColor:COLOR9];
    [lbMsg3 setTextAlignment:NSTextAlignmentRight];
    [lbMsg3 setFont:FONT13];
    [self.contentView addSubview:lbMsg3];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 79.5, SCREEN_WIDTH, 0.5)];
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
