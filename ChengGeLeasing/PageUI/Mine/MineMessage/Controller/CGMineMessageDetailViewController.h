//
//  CGMineMessageDetailViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMineMessageModel.h"

@interface CGMineMessageDetailViewController : BaseViewController<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) CGFloat webHeight;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) CGMineMessageModel *messageInfo;
@property (nonatomic, copy) void(^callBack)();

@end
