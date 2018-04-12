//
//  CGAboutWebViewController.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/4/4.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGAboutWebViewController.h"

@interface CGAboutWebViewController ()
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation CGAboutWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于城格租赁";
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - NAVIGATION_BAR_HEIGHT)];

    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    UIImage *contentImg = [UIImage imageNamed:@"about_us"];
    
    NSString *str = [self htmlForJPGImage:contentImg];
    
    NSMutableString *content = [NSMutableString string];
    
    [content appendString : @"<html>" ];
    
    [content appendString : @"<head>" ];
    
    [content appendString : @"<meta charset=\"utf-8\">" ];
    
    [content appendString : @"<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\" />" ];
    
    [content appendString : @"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />" ];
    
    [content appendString : @"<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />" ];
    
    [content appendString : @"<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />" ];
    
    [content appendString : @"<style>img{width:100%;}</style>" ];
    
    [content appendString : @"<style>table{width:100%;}</style>" ];
    
    [content appendString:str];
    
    [self.webView loadHTMLString:content baseURL:nil];
}

- (NSString *)htmlForJPGImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image,1.f);
    
    NSString *imageSource = [NSString stringWithFormat:@"data:image/jpg;base64,%@",[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    
    return [NSString stringWithFormat:@"<div align=center><img src='%@' /></div>", imageSource];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
