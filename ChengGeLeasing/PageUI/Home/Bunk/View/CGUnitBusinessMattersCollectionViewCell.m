//
//  CGUnitBusinessMattersCollectionViewCell.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGUnitBusinessMattersCollectionViewCell.h"

@implementation CGUnitBusinessMattersCollectionViewCell
- (void)setModel:(CGShopBusinessMattersHistoryListModel *)model
{
    
    //创建"背景"
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 66, 66)];
    backView.backgroundColor = UIColorFromRGBWith16HEX(0xB9B9B9);
    backView.layer.cornerRadius = 5;
    backView.clipsToBounds = YES;
    [self.contentView addSubview:backView];
    
 
    //创建"logo"

    if (!IsStringEmpty(model.logo))
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15.5, 45, 35)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.logo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if(image)
             {
                 imageView.image =  [self convertImageToGreyScale:imageView.image];
             }
             else
             {
                 imageView.image = [UIImage avatarWithName:model.first_letter];
             }
         }];
         [backView addSubview:imageView];
    }
    else
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15.5, 45, 35)];
        imageView.image = [UIImage avatarWithName:model.first_letter];
         [backView addSubview:imageView];
    }

   

    //创建"时间Lab"
    UILabel * lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(0, 66, 66, 30)];
    lbMsg.textColor =COLOR3;
    lbMsg.numberOfLines =2;
    lbMsg.font = FONT9;
    NSString *time = [NSString stringWithFormat:@"%@\n-%@",model.sing_start_time,model.sing_end_time];
    if (time.length)
    {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:time];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5.0];
        [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
        lbMsg.attributedText =str;
        lbMsg.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    lbMsg.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lbMsg];
    
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
