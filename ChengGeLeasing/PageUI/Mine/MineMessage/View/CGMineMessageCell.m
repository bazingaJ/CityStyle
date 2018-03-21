//
//  CGMineMessageCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineMessageCell.h"

@implementation CGMineMessageCell

- (void)setMineMessageModel:(CGMineMessageModel *)model indexPath:(NSIndexPath *)indexPath {
    if(!model) return;
    
    self.indexPath = indexPath;
    
    //创建“消息图标”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [imgView setImage:[UIImage imageNamed:@"mine_notice_message"]];
    [self.contentView addSubview:imgView];
    
    //创建“未读标记”
    if([model.is_read isEqualToString:@"2"]) {
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(42, -3, 10, 10)];
        [lineView2 setBackgroundColor:RED_COLOR];
        [lineView2.layer setCornerRadius:5];
        [lineView2.layer setMasksToBounds:YES];
        [imgView addSubview:lineView2];
    }
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, SCREEN_WIDTH-230, 20)];
    [lbMsg setText:model.title];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    
    //创建“时间”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, 10, 120, 20)];
    [lbMsg2 setText:model.date];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentRight];
    [lbMsg2 setFont:FONT11];
    [self.contentView addSubview:lbMsg2];
    
    //创建“内容”
    NSString *contentStr = model.content;
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, SCREEN_WIDTH-100, 40)];
    [lbMsg3 setText:contentStr];
    [lbMsg3 setTextColor:COLOR9];
    [lbMsg3 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg3 setFont:FONT13];
    [lbMsg3 setNumberOfLines:0];
    if(!IsStringEmpty(contentStr)) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:2.0f];
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
        [lbMsg3 setAttributedText:attStr];
    }
    [self.contentView addSubview:lbMsg3];
    
    //创建“右侧尖头”
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 30, 5.5, 10)];
    [imgView2 setImage:[UIImage imageNamed:@"mine_arrow_right"]];
    [self.contentView addSubview:imgView2];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 69.5, SCREEN_WIDTH, 0.5)];
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
