//
//  CGPayOrderCell.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGPayOrderCell.h"

@implementation CGPayOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CGOrderListModel *)model
{
    
    self.titleLab.text = model.title;
    self.orderNumLab.text = model.order_num;
    self.orderContentLab.text = [NSString stringWithFormat:@"购买%@席位%@个月",model.member_num,model.vip_time];
    self.orderAmount.text = [NSString stringWithFormat:@"￥%@",model.total_price];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
