//
//  CGUnitLeaseItemCollectionViewCell.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGUnitLeaseItemCollectionViewCell.h"

@implementation CGUnitLeaseItemCollectionViewCell

-(void)setModel:(NSInteger)tag withIntentMode:(CGShopBusinessMattersIntentModel *)intentModel withHistoryListModel:(CGShopBusinessMattersHistoryListModel *)historyModel model:(CGShopBusinessMattersModel *)model;
{
    //创建"背景"
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 66, 66)];
    backView.layer.cornerRadius = 5;
    backView.clipsToBounds = YES;
    backView.layer.borderColor = LINE_COLOR.CGColor;
    backView.layer.borderWidth = .5;
    [self.contentView addSubview:backView];
    
    if (tag ==100)
    {
        //意向租户
        backView.backgroundColor = WHITE_COLOR;
        if (!IsStringEmpty(intentModel.logo))
        {
            //创建"logo"
            [backView addSubview:[self createPic:intentModel.logo withTag:100]];
        }
        else
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15.5, 45, 35)];
            imageView.image = [self avatarWithName:intentModel.first_letter];
            [backView addSubview:imageView];
        }
        
    }
    else if(tag==200)
    {
        //历史租户
        backView.backgroundColor = UIColorFromRGBWith16HEX(0xB9B9B9);
        
        if (!IsStringEmpty(historyModel.logo))
        {
            //创建"logo"
            [backView addSubview:[self createPic:historyModel.logo withTag:200]];
        }
        else
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15.5, 45, 35)];
            imageView.image = [UIImage avatarWithName:historyModel.first_letter];
            [backView addSubview:imageView];
        }
    }else if(tag==300) {
        //当前租户
        backView.backgroundColor = UIColorFromRGBWith16HEX(0xB9B9B9);
        
        if (!IsStringEmpty(model.sign_cust_logo))
        {
            //创建"logo"
            [backView addSubview:[self createPic:model.sign_cust_logo withTag:200]];
        }
        else
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15.5, 45, 35)];
            imageView.image = [UIImage avatarWithName:model.sign_cust_first_letter];
            [backView addSubview:imageView];
        }
    }
    
    //创建"时间Lab"
    UILabel * lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(0, 66, 66, 30)];
    lbMsg.textColor =COLOR3;
    lbMsg.numberOfLines =2;
    lbMsg.font = FONT9;
    if (tag ==100)
    {
        lbMsg.text = [NSString stringWithFormat:@"意向度: %@%%",intentModel.intent];
        lbMsg.textAlignment = NSTextAlignmentCenter;
    }
    else if(tag==200)
    {
        NSString *time = [NSString stringWithFormat:@"%@\n-%@",historyModel.sing_start_time,historyModel.sing_end_time];
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
    }else if(tag==300) {
        //当前租户
        lbMsg.text = [NSString stringWithFormat:@"意向度: %@%%",model.sign_cust_intent];
        lbMsg.textAlignment = NSTextAlignmentCenter;
    }
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

-(UIImageView *)createPic:(NSString *)str withTag:(NSInteger)tag
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15.5, 45, 35)];
    if (tag ==100)
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:str]];
    }
    else
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:str] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if(imageView.image)
             {
                 imageView.image =  [self convertImageToGreyScale:imageView.image];
             }
         }];
    }
    return imageView;
}


-(UIImage *)avatarWithName:(NSString *)name
{
    CGFloat width = 44*[UIScreen mainScreen].scale;
    UIGraphicsBeginImageContext(CGSizeMake(width, width));
    
    UIFont *font = [UIFont systemFontOfSize:25*[UIScreen mainScreen].scale];
    CGSize textSize = [name sizeWithAttributes:@{NSFontAttributeName: font,
                                                 NSForegroundColorAttributeName: UIColorFromRGBWith16HEX(0x789bd4)}];
    [name drawAtPoint:CGPointMake(width/2 - textSize.width/2, width/2 - textSize.height/2) withAttributes:@{NSFontAttributeName: font,
                                                                                                            NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
