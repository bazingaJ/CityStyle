//
//  CGMineSettingCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineSettingCell.h"

@implementation CGMineSettingCell

- (void)setMineSettingCell:(NSArray *)itemArr {

    //创建“图标”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10.5, 22, 24)];
    [imgView setImage:[UIImage imageNamed:itemArr[0]]];
    [imgView sizeToFit];
    imgView.centerY = 22.5;
    [self.contentView addSubview:imgView];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, SCREEN_WIDTH-60, 25)];
    [lbMsg setText:itemArr[1]];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [lbMsg sizeToFit];
    [lbMsg setCenterY:22.5];
    [self.contentView addSubview:lbMsg];
    
    //创建“右侧尖头”
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
    [imgView2 setImage:[UIImage imageNamed:@"mine_arrow_right"]];
    [self.contentView addSubview:imgView2];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
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
