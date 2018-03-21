//
//  CGNetdiscModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/27.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGNetdiscModel : NSObject

/**
 * id
 */
@property (nonatomic, strong) NSString *id;
/**
 * 文件名
 */
@property (nonatomic, strong) NSString *name;
/**
 * 封面图片
 */
@property (nonatomic, strong) NSString *cover;
/**
 * 封面图片(本地)
 */
@property (nonatomic, strong) NSString *cover_icon;
/**
 * 又拍云文件路径
 */
@property (nonatomic, strong) NSString *path;
/**
 * URL地址
 */
@property (nonatomic, strong) NSString *url;
/**
 * 文件类型 1图片 2视频 3word 4excel 5 CAD 6 3DMAX 7 PDF 8其他
 */
@property (nonatomic, strong) NSString *type;
/**
 * 添加时间
 */
@property (nonatomic, strong) NSString *add_time;
/**
 *  是否有网盘权限(1有 2无)
 */
@property (nonatomic, strong) NSString *is_has_auth;

@end
