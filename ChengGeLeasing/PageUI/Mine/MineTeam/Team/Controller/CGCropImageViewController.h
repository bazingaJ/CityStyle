//
//  CGCropImageViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/26.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGCropImageViewController : BaseViewController

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSInteger tIndex;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callImageBack)(UIImage *img);

@end
