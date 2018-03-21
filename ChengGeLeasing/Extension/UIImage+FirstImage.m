//
//  UIImage+FirstImage.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/4.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "UIImage+FirstImage.h"

@implementation UIImage (FirstImage)
+(UIImage *)avatarWithName:(NSString *)name
{
    CGFloat width = 44*[UIScreen mainScreen].scale;
    UIGraphicsBeginImageContext(CGSizeMake(width, width));
    
    UIFont *font = [UIFont systemFontOfSize:25*[UIScreen mainScreen].scale];
    CGSize textSize = [name sizeWithAttributes:@{NSFontAttributeName: font,
                                                 NSForegroundColorAttributeName: UIColorFromRGBWith16HEX(0x789bd4)}];
    [name drawAtPoint:CGPointMake(width/2 - textSize.width/2, width/2 - textSize.height/2) withAttributes:@{NSFontAttributeName: font,
                                                                                                            NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
