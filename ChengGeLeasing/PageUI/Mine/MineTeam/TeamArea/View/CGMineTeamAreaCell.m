//
//  CGMineTeamAreaCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamAreaCell.h"

@implementation CGMineTeamAreaCell

- (void)setTeamAreaModel:(CGTeamAreaModel *)model indexPath:(NSIndexPath *)indexPath {
    if(!model) return;
    
    //创建“用户名称”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-140, 25)];
    [btnFunc setTitle:model.name forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT16];
    [btnFunc setImage:[UIImage imageNamed:@"mine_icon_move"] forState:UIControlStateNormal];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.contentView addSubview:btnFunc];
    
    //创建“功能按钮”
    for (int i=0; i<2; i++) {
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-130+65*i, 10, 55, 25)];
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
            if([self.delegate respondsToSelector:@selector(CGMineTeamAreaCellClick:tIndex:indexPath:)]) {
                [self.delegate CGMineTeamAreaCellClick:model tIndex:i indexPath:indexPath];
            }
        }];
        [self.contentView addSubview:btnFunc];
    }
    
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
