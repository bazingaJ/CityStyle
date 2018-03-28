//
//  CGMemberCell.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGMemberCell.h"

@implementation CGMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
}
- (void)setModel:(CGMemberModel *)model
{
    
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"contact_icon_avatar"]];
    self.name.text = model.name;
    self.updateTimeLab.text = [NSString stringWithFormat:@"升级时间：%@",model.add_date];
    self.positionLab.text = model.type_name;
}

- (void)setRemove_model:(CGMemberModel *)remove_model
{
    
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:remove_model.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"contact_icon_avatar"]];
    self.memberName.text = remove_model.name;
    self.memberTel.text = remove_model.mobile;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
