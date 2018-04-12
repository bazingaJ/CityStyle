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
    _model = model;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"contact_icon_avatar"]];
    self.nameLab.text = model.name;
    self.phoneLab.text = model.mobile;
    // 判断是否已经加入项目
    if ([model.isIn isEqualToString:@"1"])
    {
        [self.invateBtn setTitle:@"添加" forState:UIControlStateNormal];
        [self.invateBtn setBackgroundColor:MAIN_COLOR];
        self.invateBtn.userInteractionEnabled = YES;
        self.invateBtn.tag = 222;
        if (model.isAdd == YES)
        {
            [self.invateBtn setTitle:@"已添加" forState:UIControlStateNormal];
            [self.invateBtn setBackgroundColor:COLOR6];
            self.invateBtn.userInteractionEnabled = NO;
            self.invateBtn.tag = 333;
        }
    }
    else
    {
        [self.invateBtn setTitle:@"邀请" forState:UIControlStateNormal];
        [self.invateBtn setBackgroundColor:MAIN_COLOR];
        self.invateBtn.userInteractionEnabled = YES;
        self.invateBtn.tag = 111;
    }
}

- (void)setTeamMemberModel:(CGTeamMemberModel *)teamMemberModel
{
    
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:teamMemberModel.avatar] placeholderImage:[UIImage imageNamed:@"contact_icon_avatar"]];
    self.nameLab.text = teamMemberModel.name;
    self.phoneLab.text = teamMemberModel.mobile;
    if ([teamMemberModel.isIn isEqualToString:@"1"])
    {
        [self.invateBtn setTitle:@"已添加" forState:UIControlStateNormal];
        [self.invateBtn setBackgroundColor:COLOR6];
        self.invateBtn.userInteractionEnabled = NO;
        
    }
    else if ([teamMemberModel.isIn isEqualToString:@"2"])
    {
        [self.invateBtn setTitle:@"添加" forState:UIControlStateNormal];
        [self.invateBtn setBackgroundColor:MAIN_COLOR];
        self.invateBtn.userInteractionEnabled = YES;
        
    }
}

- (IBAction)invateBtnClick:(UIButton *)sender
{
 
    if ([self.delegate respondsToSelector:@selector(invateBtnClick:model:)])
    {
        [self.delegate invateBtnClick:sender model:_model];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
}

@end
