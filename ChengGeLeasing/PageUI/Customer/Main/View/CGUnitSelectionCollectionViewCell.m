//
//  CGUnitSelectionCollectionViewCell.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGUnitSelectionCollectionViewCell.h"

@implementation CGUnitSelectionCollectionViewCell

-(void)setModel:(CGPositionPosListModel *)model
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 66, 66)];
    backView.layer.cornerRadius = 5;
    backView.clipsToBounds = YES;
    backView.layer.borderColor = UIColorFromRGBWith16HEX(0xB9B9B9).CGColor;
    backView.layer.borderWidth = .5;
    [self.contentView addSubview:backView];
    
    //创建"f101";
    UILabel *lbMsg1 = [[UILabel alloc]initWithFrame:CGRectMake(2, 20, 66-4, 12)];
    lbMsg1.font = [UIFont systemFontOfSize:10];
    lbMsg1.textColor = COLOR9;
    lbMsg1.textAlignment = NSTextAlignmentCenter;
    lbMsg1.text = model.pos_name;
    [backView addSubview:lbMsg1];
    
    //创建"120㎡";
    UILabel *lbMsg2 = [[UILabel alloc]initWithFrame:CGRectMake(2, 35, 66-4, 10)];
    lbMsg2.font = [UIFont systemFontOfSize:8];
    lbMsg2.textColor = COLOR9;
    lbMsg2.textAlignment = NSTextAlignmentCenter;
    lbMsg2.text = [NSString stringWithFormat:@"%@㎡",model.pos_area];
    [backView addSubview:lbMsg2];

    //创建"选中标识"
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(66-15, -5, 15, 15)];
    
    if ([model.pos_status isEqualToString:@"3"] || [model.pos_status isEqualToString:@"4"])
    {
        imageView.image = [UIImage imageNamed:@"mine_icon_normal"];
    }
    else
    {
        if ([model.is_choose isEqualToString:@"1"])
        {
            imageView.image = [UIImage imageNamed:@"cust_daiban_selected"];
        }
        else
        {
            imageView.image = [UIImage imageNamed:@"cust_daiban_normal"];
        }
    }
    
    [self.contentView addSubview:imageView];
}

@end
