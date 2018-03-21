//
//  CGCustomerFunnelCell.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGCustomerFunnelCell.h"

@implementation CGCustomerFunnelCell


-(void)setModel:(CGHasSignedCustomerListModel *)model
{
    //创建"头像"
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 50, 50)];
    if (!IsStringEmpty(model.logo))
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    }
    else
    {
        imageView.image = [UIImage avatarWithName:model.first_letter];
    }
    
    imageView.backgroundColor = UIColorFromRGBWith16HEX(0xBCCDE8);
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
    if (size.width>SCREEN_WIDTH-80)
    {
        rect.size.width =SCREEN_WIDTH-80;
    }
    lbMsg.frame = rect;
    
    //创建"时间"
    UILabel *lbMsg2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -100, 15, 90, 20)];
    lbMsg2.font = FONT14;
    lbMsg2.textColor = COLOR9;
    lbMsg2.text = model.sing_date;
    lbMsg2.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:lbMsg2];
    
    //创建"意向区域"
    UILabel *lbMsg3 = [[UILabel alloc]initWithFrame:CGRectMake(lbMsg.left, lbMsg.bottom +2, SCREEN_WIDTH-140, 20)];
    lbMsg3.font = FONT14;
    lbMsg3.textColor = COLOR9;
    NSString * sign_group_name;
    if (IsStringEmpty(model.sign_group_name))
    {
        sign_group_name = @"暂无";
    }
    else
    {
        sign_group_name = model.sign_group_name;
    }
    lbMsg3.text =[NSString stringWithFormat:@"意向区域:%@",sign_group_name];
    [self.contentView addSubview:lbMsg3];
    
    //创建"意向度"
    UILabel *lbMsg5 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-130, lbMsg3.top, 120, 20)];
    lbMsg5.font = FONT14;
    lbMsg5.textColor = COLOR9;
    lbMsg5.textAlignment = NSTextAlignmentRight;
    lbMsg5.text = [NSString stringWithFormat:@"意向度:%@%%",model.intent];
    [self.contentView addSubview:lbMsg5];
    
    //创建"分类"
    UILabel *lbMsg4 =[[UILabel alloc]initWithFrame:CGRectMake(imageView.right +15, lbMsg3.bottom +2, lbMsg3.width, 20)];
    lbMsg4.font = FONT14;
    lbMsg4.textColor = COLOR9;
    lbMsg4.text = model.cate_name;
    [self.contentView addSubview:lbMsg4];
    
    //创建"联系人"
    UILabel *lbMsg6 =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -130, lbMsg4.top, 120, 20)];
    lbMsg6.font = FONT14;
    lbMsg6.textAlignment = NSTextAlignmentRight;
    lbMsg6.textColor = COLOR9;
    lbMsg6.text = model.linkman_name;
    [self.contentView addSubview:lbMsg6];
    
    //创建"线"
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 10)];
    lineView.backgroundColor = GRAY_COLOR;
    [self.contentView addSubview:lineView];
}

@end
