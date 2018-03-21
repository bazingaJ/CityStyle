//
//  CGLocalVideoModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/27.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGLocalVideoModel : NSObject

@property (nonatomic, strong) NSString *video_name;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) NSURL *video_url;
@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, strong) NSString *video_time;
@property (nonatomic, assign) CGFloat video_size;

//计算文件大小
- (NSString *)fileSize:(CGFloat)size;

@end
