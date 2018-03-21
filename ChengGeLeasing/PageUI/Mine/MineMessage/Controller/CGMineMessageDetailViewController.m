//
//  CGMineMessageDetailViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineMessageDetailViewController.h"

@interface CGMineMessageDetailViewController ()

@end

@implementation CGMineMessageDetailViewController

/**
 *  创建webView
 */
- (UIWebView *)webView {
    if(_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT)];
        _webView.delegate = self;
        _webView.scrollView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        //[_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#21262F'"];
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息详情";
    
    [self webView];
    
    [self showInWebView];
    
    //更新消息
    [self updateMessage];
    
}

/**
 *  左侧按钮点击事件
 */
- (void)leftButtonItemClick {
    if(self.callBack) {
        self.callBack();
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 *  获取消息详情
 */
- (void)updateMessage {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"setMessageRead" forKey:@"act"];
    [param setValue:self.messageInfo.system_message_id forKey:@"system_message_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            //更新状态成功
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [MBProgressHUD showError:MESSAGE_ERROR toView:self.view];
    }];
    
}

- (void)showInWebView {
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"ChengGeLeasing.css" withExtension:nil]];
    [html appendString:@"</head>"];
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    [self.webView loadHTMLString:html baseURL:nil];
}
- (NSString *)touchBody {
    
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.messageInfo.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.messageInfo.date];
    
    if(!IsStringEmpty(self.messageInfo.content)) {
        [body appendString:self.messageInfo.content];
    }
    return body;
}

//将发出通知时调用
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"sx:src="];
    if (range.location != NSNotFound) {
        NSInteger begin = range.location + range.length;
        NSString *src = [url substringFromIndex:begin];
        [self savePictureToAlbum:src];
        return NO;
    }
    return YES;
}

//保存到相册方法
- (void)savePictureToAlbum:(NSString *)src {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要保存到相册吗？" preferredStyle: UIAlertControllerStyleActionSheet];
    //UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSURLCache *cache =[NSURLCache sharedURLCache];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:src]];
        NSData *imgData = [cache cachedResponseForRequest:request].data;
        UIImage *image = [UIImage imageWithData:imgData];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
        [MBProgressHUD showSuccess:@"保存成功" toView:self.view];
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 3)];
    _lineView.backgroundColor = MAIN_COLOR;
    [_webView addSubview:_lineView];
    [UIView animateWithDuration:0.8 animations:^{
        CGRect frame = _lineView.frame;
        frame.size.width = [UIScreen mainScreen].bounds.size.width * 0.7;
        _lineView.frame = frame;
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
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
