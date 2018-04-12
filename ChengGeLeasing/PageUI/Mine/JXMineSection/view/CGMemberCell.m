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
    self.choiceBtn.hidden = YES;
    self.updateTimeLab.text = [NSString stringWithFormat:@"升级时间：%@",model.add_date];
    self.positionLab.text = model.type_name;
}

- (void)setRemove_model:(CGMemberModel *)remove_model
{
    
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:remove_model.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"contact_icon_avatar"]];
    self.name.text = remove_model.name;
    self.updateTimeLab.text = [NSString stringWithFormat:@"升级时间：%@",remove_model.add_date];
    self.positionLab.text = remove_model.type_name;
}

- (void)setOperationModel:(CGMemberModel *)operationModel
{
 
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:operationModel.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"contact_icon_avatar"]];
    self.memberName.text = operationModel.name;
    self.memberTel.text = operationModel.mobile;
    if ([operationModel.isBefore isEqualToString:@"1"])
    {
        self.removeBtn.selected = YES;
    }
    else
    {
        self.removeBtn.selected = NO;
    }
    
    if ([operationModel.is_owner isEqualToString:@"1"])
    {
        self.removeBtn.hidden = YES;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
