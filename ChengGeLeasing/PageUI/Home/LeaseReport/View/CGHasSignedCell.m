//
//  CGHasSignedCell.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGHasSignedCell.h"

@implementation CGHasSignedCell

-(void)setModel:(CGHasSignedCustomerListModel *)model
{
    //创建"头像"
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 50, 50)];
     imageView.backgroundColor = UIColorFromRGBWith16HEX(0xBCCDE8);
    if (!IsStringEmpty(model.logo))
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage avatarWithName:model.first_letter]];
    }
    else
    {
        imageView.image = [UIImage avatarWithName:model.first_letter];
    }
    imageView.layer.cornerRadius = 5;
    imageView.clipsToBounds =YES;
    [self.contentView addSubview:imageView];
    
    //创建"商铺名"
    UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(imageView.right+15, 15, 10, 20)];
    lbMsg.font = FONT16;
    lbMsg.textColor =COLOR3;
    lbMsg.text = model.name;
    [self.contentView addSubview:lbMsg];
    CGSize size =[lbMsg sizeThatFits:CGSizeMake(SCREEN_WIDTH-80, 20)];
    CGRect rect = lbMsg.frame;
    rect.size.width = size.width;
    lbMsg.frame = rect;
    
    //创建"小标题"
    UILabel *lbMsg1 =[[UILabel alloc]initWithFrame:CGRectMake(lbMsg.right +5, 15, 100, 20)];
    lbMsg1.font = FONT14;
    lbMsg1.textColor = COLOR9;
    lbMsg1.text = model.cate_name;
    [self.contentView addSubview:lbMsg1];
    
    //创建"时间"
    UILabel *lbMsg2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -100, 15, 90, 20)];
    lbMsg2.font = FONT14;
    lbMsg2.textColor = COLOR9;
    lbMsg2.text = model.sing_date;
    lbMsg2.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:lbMsg2];
    
    //创建"签约区域"
    UILabel *lbMsg3 = [[UILabel alloc]initWithFrame:CGRectMake(lbMsg.left, lbMsg.bottom +2, SCREEN_WIDTH-100, 20)];
    lbMsg3.font = FONT14;
    lbMsg3.textColor = COLOR9;
    lbMsg3.text = [NSString stringWithFormat:@"签约区域:%@",model.sign_group_name];
    [self.contentView addSubview:lbMsg3];
    
    //创建"铺位号"
    UILabel *lbMsg4 =[[UILabel alloc]initWithFrame:CGRectMake(imageView.right +15, lbMsg3.bottom +2, lbMsg3.width, 20)];
    lbMsg4.font = FONT14;
    lbMsg4.textColor = COLOR9;
    lbMsg4.text = [NSString stringWithFormat:@"铺位号:%@",model.pos_name];
    [self.contentView addSubview:lbMsg4];
    
    //创建"线"
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 10)];
    lineView.backgroundColor = GRAY_COLOR;
    [self.contentView addSubview:lineView];
}

@end
