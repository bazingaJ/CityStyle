//
//  CGLocalVideoModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/27.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLocalVideoModel.h"

@implementation CGLocalVideoModel

- (NSString *)fileSize:(CGFloat)size {
    NSString *videoSize = @"";
    if (size >= pow(10, 9)) { // size >= 1GB
        videoSize = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
    } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
        videoSize = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
    } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
        videoSize = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
    } else { // 1KB > size
        videoSize = [NSString stringWithFormat:@"%zdB", size];
    }
    return videoSize;
}

@end
