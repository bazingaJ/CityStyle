//
//  CGHomeCollectionViewCell.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/8/7.
//  Copyright © 2017年 田浩渺. All rights reserved.
//

#import "CGHomeCollectionViewCell.h"

@implementation CGHomeCollectionViewCell

-(void)setModel:(CGHomePos_listModel *)model
{
    _model = model;
    //创建"背景"
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 66, 66)];

    if ([_model.pos_status isEqualToString:@"1"])
    {
        //无意向
        backView.backgroundColor = UIColorFromRGBWith16HEX(0xBBCDE8);
    }
    else if ([_model.pos_status isEqualToString:@"2"])
    {
        //有意向
        backView.backgroundColor = UIColorFromRGBWith16HEX(0x789BD4);
    }
    else if ([_model.pos_status isEqualToString:@"3"])
    {
        //已签约
        backView.backgroundColor = UIColorFromRGBWith16HEX(0xB9B9B9);
    }
    else if ([_model.pos_status isEqualToString:@"4"])
    {
        //已付款
        backView.backgroundColor = UIColorFromRGBWith16HEX(0xB9B9B9);
    }
    backView.layer.cornerRadius = 5;
    backView.clipsToBounds = YES;
    [self.contentView addSubview:backView];

    if ([_model.pos_status isEqualToString:@"3"] || [_model.pos_status isEqualToString:@"2"]|| [_model.pos_status isEqualToString:@"4"])
    {
        //创建"logo"
        if (!IsStringEmpty(_model.cust_logo))
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10.5, 5, 45, 35)];

            [imageView sd_setImageWithURL:[NSURL URLWithString:_model.cust_logo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
            {
                if(imageView.image)
                {
                    imageView.image =  [self convertImageToGreyScale:imageView.image];
                }
            }];
            [backView addSubview:imageView];
        }
        else
        {
            if (!IsStringEmpty(_model.cust_name))
            {
                UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, 56, 14)];
                lbMsg.textColor = [UIColor whiteColor];
                lbMsg.text =_model.cust_name;
                lbMsg.font = FONT9;
                lbMsg.textAlignment = NSTextAlignmentCenter;
                [backView addSubview:lbMsg];
            }
        }
    }

    //创建"警告标示"
    if (([_model.pos_operate_status isEqualToString:@"3"])||([_model.pos_operate_status isEqualToString:@"4"]) )
    {
        UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(66-15, 0, 15, 15)];
        if ([_model.pos_operate_status isEqualToString:@"3"])
        {
            imageView2.image = [UIImage imageNamed:@"home_puweiyudong_icon"];
        }
        else
        {
            imageView2.image = [UIImage imageNamed:@"home_tuipu_icon"];
        }
        [backView addSubview:imageView2];
    }

    //创建"f101";
    UILabel *lbMsg1 = [[UILabel alloc]initWithFrame:CGRectMake(2, 42, 66-4, 10)];
    lbMsg1.font = [UIFont systemFontOfSize:8];
    lbMsg1.textColor = [UIColor whiteColor];
    lbMsg1.textAlignment = NSTextAlignmentCenter;
    lbMsg1.text = _model.pos_name;
    [backView addSubview:lbMsg1];

    //创建"120㎡";
    UILabel *lbMsg2 = [[UILabel alloc]initWithFrame:CGRectMake(2, 54, 66-4, 10)];
    lbMsg2.font = [UIFont systemFontOfSize:6];
    lbMsg2.textColor = [UIColor whiteColor];
    lbMsg2.textAlignment = NSTextAlignmentCenter;
    lbMsg2.text = [NSString stringWithFormat:@"%@㎡",_model.pos_area];
    [backView addSubview:lbMsg2];
   
    if ([_model.pos_status isEqualToString:@"1"] ||[_model.pos_status isEqualToString:@"2"])
    {
        lbMsg1.frame =CGRectMake(2, 22, 66-4, 10);
        lbMsg2.frame =CGRectMake(2, 34, 66-4, 10);
    }
    else
    {
        lbMsg1.frame =CGRectMake(2, 42, 66-4, 10);
        lbMsg2.frame =CGRectMake(2, 54, 66-4, 10);
    }
}

//图片黑白处理
- (UIImage *)convertImageToGreyScale:(UIImage *)image
{
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    CGContextDrawImage(context, imageRect, [image CGImage]);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    return newImage;
}

@end
