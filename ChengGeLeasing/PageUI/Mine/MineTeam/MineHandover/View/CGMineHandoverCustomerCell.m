//
//  CGMineHandoverCustomerCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineHandoverCustomerCell.h"

@implementation CGMineHandoverCustomerCell

- (void)setCustomerModel:(CGCustomerModel *)model {
    if(!model) return;

    //创建“首字母”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 55, 55)];
    [lbMsg.layer setCornerRadius:4];
    [lbMsg.layer setMasksToBounds:YES];
    [lbMsg setBackgroundColor:MAIN_COLOR];
    [lbMsg setText:model.first_letter];
    [lbMsg setTextColor:[UIColor whiteColor]];
    [lbMsg setTextAlignment:NSTextAlignmentCenter];
    [lbMsg setFont:FONT24];
    [self.contentView addSubview:lbMsg];
    
    //创建“客户名称”
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, SCREEN_WIDTH-120, 20)];
    [lbMsg3 setText:model.name];
    [lbMsg3 setTextColor:COLOR3];
    [lbMsg3 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg3 setFont:FONT16];
    [self.contentView addSubview:lbMsg3];
    
    //创建“业态名称”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(75, 45, SCREEN_WIDTH-120, 20)];
    [lbMsg2 setText:model.cate_name];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT14];
    [self.contentView addSubview:lbMsg2];
    
    //创建“选择”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-35, 25, 25, 25)];
    if(model.is_selected) {
        [btnFunc setImage:[UIImage imageNamed:@"mine_icon_selected"] forState:UIControlStateNormal];
        [btnFunc setSelected:YES];
    }else{
        [btnFunc setImage:[UIImage imageNamed:@"mine_icon_normal"] forState:UIControlStateNormal];
        [btnFunc setSelected:NO];
    }
    [btnFunc addTouch:^{
        NSLog(@"选择按钮事件");
        
        btnFunc.selected = !btnFunc.selected;
        [btnFunc setSelected:btnFunc.selected];
        if(btnFunc.isSelected) {
            [btnFunc setImage:[UIImage imageNamed:@"mine_icon_selected"] forState:UIControlStateNormal];
            model.is_selected = YES;
        }else{
            [btnFunc setImage:[UIImage imageNamed:@"mine_icon_normal"] forState:UIControlStateNormal];
            model.is_selected = NO;
        }
        
    }];
    [self.contentView addSubview:btnFunc];
    
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
