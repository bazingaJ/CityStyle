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
    self.name.text = model.member_name;
    self.updateTimeLab.text = model.member_updateTime;
    self.positionLab.text = model.member_position;
}

- (void)setRemove_model:(CGMemberModel *)remove_model
{
//    self.headImg
    self.memberName.text = remove_model.member_name;
    self.memberTel.text = remove_model.member_mobeil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
