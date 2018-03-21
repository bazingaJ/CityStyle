//
//  CGCropImageExViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/2/7.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    CIRCULARCLIP   = 0,   //圆形裁剪
    SQUARECLIP            //方形裁剪
    
}ClipType;

@class CGCropImageExViewController;
@protocol CGCropImageDelegate <NSObject>

-(void)clipViewController:(CGCropImageExViewController *)viewC finishClipImage:(UIImage *)editImage;

@end

@interface CGCropImageExViewController : BaseViewController

@property (nonatomic, assign) ClipType clipType;  //裁剪的形状
@property (nonatomic, strong) id<CGCropImageDelegate>delegate;

@property (nonatomic, strong) UIImage *photoImg;
@property (nonatomic, assign) CGSize clipSize;

-(instancetype)initWithImage:(UIImage *)image; //默认方形裁剪框

-(instancetype)initWithImage:(UIImage *)image clipSize:(CGSize)clipSize;

//圆形裁剪
-(instancetype)initWithImage:(UIImage *)image radius:(CGFloat)radius;


@end
