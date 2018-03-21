//
//  CGLevelUpCell.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/21.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGLevelUpCell.h"

@implementation CGLevelUpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.countLab.layer.borderColor = LINE_COLOR.CGColor;
    self.countLab.layer.borderWidth = 0.5f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
