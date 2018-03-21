//
//  CGOperatingDynamicDetailsCell.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGOperatingDynamicDetailsCell.h"

@implementation CGOperatingDynamicDetailsCell

-(void)setModel:(CGOperationDynamicPositionModel *)model
{

    //创建"背景"
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 66, 66)];
    bgView.layer.cornerRadius = 5;
    bgView.clipsToBounds =YES;
    [self.contentView addSubview:bgView];
    
    if ([model.operate_status isEqualToString:@"1"])
    {
         bgView.backgroundColor = UIColorFromRGBWith16HEX(0xBBCDE8);
    }
    else
    {
         bgView.backgroundColor = UIColorFromRGBWith16HEX(0xB9B9B9);
    }
    
    //创建"商标"
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10.5, 5, 45, 35)];
    imageView.backgroundColor = [UIColor clearColor];
    
    if (![model.operate_status isEqualToString:@"1"])
    {
        if (model.cust_logo.length)
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.cust_logo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
             {
                 imageView.image = [self convertImageToGreyScale:imageView.image];
             }];
        }
        else
        {
            imageView.image = [UIImage avatarWithName:model.cust_first_letter];
        }
    }

    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds =YES;
    [bgView addSubview:imageView];
    
    //创建"商铺名";
    UILabel *lbMsg1 = [[UILabel alloc]initWithFrame:CGRectMake(2, 42, 66-4, 10)];
    lbMsg1.font = [UIFont systemFontOfSize:8];
    lbMsg1.textColor = [UIColor whiteColor];
    lbMsg1.textAlignment = NSTextAlignmentCenter;
    lbMsg1.text = model.name;
    [bgView addSubview:lbMsg1];
    
    //创建平方米;
    UILabel *lbMsg2 = [[UILabel alloc]initWithFrame:CGRectMake(2, 54, 66-4, 10)];
    lbMsg2.font = [UIFont systemFontOfSize:6];
    lbMsg2.textColor = [UIColor whiteColor];
    lbMsg2.textAlignment = NSTextAlignmentCenter;
    lbMsg2.text = [NSString stringWithFormat:@"%@㎡",model.area];
    [bgView addSubview:lbMsg2];
    
    //创建"角标"
     UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(66-15, 0, 15, 15)];
    if ([model.operate_status isEqualToString:@"3"])
    {
        imageView2.image =[UIImage imageNamed:@"home_puweiyudong_icon"];
    }
    else if ([model.operate_status isEqualToString:@"4"])
    {
         imageView2.image =[UIImage imageNamed:@"home_tuipu_icon"];
    }
    [bgView addSubview:imageView2];
    
    if ([model.operate_status isEqualToString:@"1"])
    {
        CGRect rect1 = lbMsg1.frame;
        CGRect rect2 = lbMsg2.frame;
        rect1.origin.y  =20;
        rect2.origin.y  =36;
        lbMsg1.frame = rect1;
        lbMsg2.frame = rect2;
    }
}

//图片黑白处理
- (UIImage*)convertImageToGreyScale:(UIImage*) image
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
