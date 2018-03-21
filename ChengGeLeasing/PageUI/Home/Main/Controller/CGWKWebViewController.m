//
//  CGWKWebViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGWKWebViewController.h"

@interface CGWKWebViewController ()

@end

@implementation CGWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    //默认去掉头部高度
    if(!self.tabH) self.tabH = NAVIGATION_BAR_HEIGHT;
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-self.tabH)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    
    [self openWKURL:[NSURL URLWithString:_url]];
    
}

- (void)openWKURL:(NSURL *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
    [_webView loadRequest:request];
}

- (void)leftButtonItemClick
{
    if (self.callBack)
    {
        self.callBack();
    }
    if ([self.navigationController isEqual:kWindow.rootViewController])
    {
        self.navigationController.navigationBar.hidden = YES;
    }
    if(_present) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//#pragma mark - 加载本地文件
///// 模拟器调试加载mac本地文件
//- (void)loadLocalFile {
//    // 1.创建webview，并设置大小，"20"为状态栏高度
//    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
//    // 2.创建url  userName：电脑用户名
//    NSURL *url = [NSURL fileURLWithPath:@"/Users/userName/Desktop/bigIcon.png"];
//    // 3.加载文件
//    [webView loadFileURL:url allowingReadAccessToURL:url];
//    // 最后将webView添加到界面
//    [self.view addSubview:webView];
//}

///// 其它三个加载函数
//- (WKNavigation *)loadRequest:(NSURLRequest *)request;
//- (WKNavigation *)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL;
//- (WKNavigation *)loadData:(NSData *)data MIMEType:(NSString *)MIMEType characterEncodingName:(NSString *)characterEncodingName baseURL:(NSURL *)baseURL;

#pragma mark - WKNavigationDelegate
///// 接收到服务器跳转请求之后调用 (服务器端redirect)，不一定调用
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
//
//}
///// 3 在收到服务器的响应头，根据response相关信息，决定是否跳转。decisionHandler必须调用，来决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//
//}
/// 1 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURLRequest * request = navigationAction.request;
    
    //https  认证
    NSString* scheme = [[request URL] scheme];
    if ([scheme isEqualToString:@"https"]){
        if (!self.authenticated) {
            self.webRequest = request;
            if (IOS_VERSION < 9.0) {
                self.httpsUrlConnection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
                [self.httpsUrlConnection start];
                [webView stopLoading];
                
                decisionHandler(WKNavigationActionPolicyCancel);
            }
        }
    }
    // 不加载空白网址
    decisionHandler([request.URL.scheme isEqual:@"about"] ? WKNavigationActionPolicyCancel : WKNavigationActionPolicyAllow);
}

/// 2 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    _webView.hidden = NO;
    
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 3)];
    _lineView.backgroundColor = MAIN_COLOR;
    [self.view addSubview:_lineView];
    [UIView animateWithDuration:0.8 animations:^{
        CGRect frame = _lineView.frame;
        frame.size.width = [UIScreen mainScreen].bounds.size.width * 0.7;
        _lineView.frame = frame;
    }];
    
}
///// 4 开始获取到网页内容时返回
//- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
//
//}
/// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    webView.userInteractionEnabled = YES;
    //NSString *title = [_webView title];
    //if (title.length) self.title = title;
    
    [NSThread sleepForTimeInterval:0.5];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _lineView.frame;
        frame.size.width = [UIScreen mainScreen].bounds.size.width;
        _lineView.frame = frame;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_lineView removeFromSuperview];
    });
    
}
/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(nonnull NSError *)error{
    if (error.code == 101 || error.code == 102 || error.code == -999) return;
    
    _webView.hidden = YES;
    
    self.title = @"出错了";
    
    webView.userInteractionEnabled = NO;
}

//#pragma mark - WKScriptMessageHandler
///// message: 收到的脚本信息.
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//
//}
//
//#pragma mark - WKUIDelegate
///// 创建一个新的WebView
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
//
//    return webView;
//}
///// 输入框
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
//
//}
///// 确认框
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
//
//}
///// 警告框
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
//
//}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler {
    
    if ([challenge previousFailureCount] == 0) {
        self.authenticated = YES;
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    }else{
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
    
    [self.webView loadRequest:self.webRequest];
    [session invalidateAndCancel];
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    if (!error) return;
    NSLog(@"sessionDelegate --- %@", error);
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge previousFailureCount] == 0) {
        self.authenticated = YES;
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    }else{
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)pResponse {
    self.authenticated = YES;
    [connection cancel];
    [self.webView loadRequest:self.webRequest];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (!error) return;
    
    self.webView.hidden = YES;
    
    self.title = @"出错了";
}

#pragma mark - doJavascript
- (void)doJavaScript:(NSString *)js {
    [self.webView evaluateJavaScript:js completionHandler:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
