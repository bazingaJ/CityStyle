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
    
    self.name.text = model.name;
    self.updateTimeLab.text = [NSString stringWithFormat:@"%@",model.add_date];
    self.positionLab.text = model.type_name;
}

- (void)setRemove_model:(CGMemberModel *)remove_model
{
    
//    self.headImg sd
    self.memberName.text = remove_model.name;
    self.memberTel.text = remove_model.mobile;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
