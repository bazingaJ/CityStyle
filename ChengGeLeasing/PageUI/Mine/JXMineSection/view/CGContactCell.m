//
//  CGContactCell.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/27.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGContactCell.h"

@implementation CGContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(CGContactModel *)model
{
    
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"contact_icon_avatar"]];
    self.nameLab.text = model.name;
    self.phoneLab.text = model.mobileStr;
}

- (void)setTeamMemberModel:(CGTeamMemberModel *)teamMemberModel
{
    
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:teamMemberModel.avatar] placeholderImage:[UIImage imageNamed:@"contact_icon_avatar"]];
    self.nameLab.text = teamMemberModel.name;
    self.phoneLab.text = teamMemberModel.mobile;
}

- (IBAction)invateBtnClick:(UIButton *)sender
{
 
    if ([self.delegate respondsToSelector:@selector(invateBtnClick:)])
    {
        [self.delegate invateBtnClick:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
}

@end
