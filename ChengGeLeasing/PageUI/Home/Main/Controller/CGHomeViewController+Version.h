//
//  CGHomeViewController+Version.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGHomeViewController.h"
#import "CGVersionPopupView.h"

@interface CGHomeViewController (Version)<CGVersionPopupViewDelegate>

/**
 *  版本检测
 */
@property (nonatomic, copy) KLCPopup *popup;
/**
 *  苹果应用下载地址
 */
@property (nonatomic, copy) NSString *trackViewUrl;

/**
 * 检测系统版本
 */
- (void)checkSystemVersion;

@end
