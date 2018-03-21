//
//  CGTeamBunkCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGTeamBunkCell.h"

@implementation CGTeamBunkCell

- (void)setBunkModel:(CGBunkModel *)model indexPath:(NSIndexPath *)indexPath {
    if(!model) return;
    
    //创建“铺位号”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-140, 20)];
    [lbMsg setText:model.pos_name];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    
    //创建“面积”
    CGFloat areaV = 0;
    if(!IsStringEmpty(model.pos_area)) {
        areaV = [model.pos_area floatValue];
    }
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH-140, 20)];
    [lbMsg2 setText:[NSString stringWithFormat:@"%.2fm²",areaV]];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT12];
    [self.contentView addSubview:lbMsg2];
    
    //创建“功能按钮”
    for (int i=0; i<2; i++) {
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-130+65*i, 17.5, 55, 25)];
        if(i==0) {
            [btnFunc setTitle:@"编辑" forState:UIControlStateNormal];
        }else if(i==1) {
            [btnFunc setTitle:@"删除" forState:UIControlStateNormal];
        }
        [btnFunc setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT13];
        [btnFunc.layer setCornerRadius:3.0];
        [btnFunc.layer setBorderWidth:1];
        [btnFunc.layer setBorderColor:MAIN_COLOR.CGColor];
        [btnFunc addTouch:^{
            if([self.delegate respondsToSelector:@selector(CGTeamBunkCellClick:tIndex:indexPath:)]) {
                [self.delegate CGTeamBunkCellClick:model tIndex:i indexPath:indexPath];
            }
        }];
        [self.contentView addSubview:btnFunc];
    }
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, SCREEN_WIDTH, 0.5)];
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
