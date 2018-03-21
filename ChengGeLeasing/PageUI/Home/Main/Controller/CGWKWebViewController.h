//
//  CGWKWebViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface CGWKWebViewController : BaseViewController<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate,NSURLSessionDelegate,NSURLConnectionDelegate>

@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign, getter=isPresent) BOOL present;

@property (nonatomic, strong) WKWebView *webView;
//处理https认证
@property (nonatomic, strong) NSURLRequest *webRequest;
@property (nonatomic, assign) BOOL authenticated;
@property (nonatomic, strong) NSURLSession* httpsSession;
@property (nonatomic, strong) NSURLConnection *httpsUrlConnection;

@property (nonatomic, assign) CGFloat tabH;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) void (^callBack)();

- (void)doJavaScript:(NSString *)js;

@end
