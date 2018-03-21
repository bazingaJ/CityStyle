//
//  CGUMSocialSheetEx.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGUMSocialSheetEx.h"
#import "CGNetdiscEmailPopupView.h"

@implementation CGUMSocialSheetEx

//显示弹出层
- (void)show {
    [UIView animateWithDuration:.23 animations:^{
        CGRect frame = _backView.frame;
        frame.origin.y -= (self.yPosition+HOME_INDICATOR_HEIGHT);
        _backView.frame = frame;
    }];
}

//关闭弹出层
- (void)dismiss {
    [UIView animateWithDuration:.23 animations:^{
        CGRect frame = self.backView.frame;
        frame.origin.y += self.yPosition;
        self.backView.frame = frame;
        [self removeFromSuperview];
    } completion:^(BOOL complete){
        //分享
        [self UMSocialShareSheetPressed:self.index param:_param];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self topToDismiss];
}

- (id)initWithView:(UIViewController *)view param:(NSDictionary *)param {
    self = [super init];
    if (self) {
        _view = view;
        _param = param;
        
        _timeArr = [NSMutableArray array];
        
        //设置frame
        CGRect rect = [UIScreen mainScreen].bounds;
        self.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        self.yPosition = 115;
        
        //创建背景层
        CGRect frame = self.backView.frame;
        frame.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.yPosition);
        frame.origin = CGPointMake(0, self.frame.size.height);
        
        //创建“背景层”
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.userInteractionEnabled = YES;
        _backView.frame = frame;
        [self addSubview:_backView];
        
        if(iPhoneX) {
            UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-HOME_INDICATOR_HEIGHT, self.frame.size.width, HOME_INDICATOR_HEIGHT)];
            [itemView setBackgroundColor:[UIColor whiteColor]];
            [self addSubview:itemView];
        }
        
        [self creat];
    }
    return self;
}

- (void)creat {
    
    NSMutableArray *titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"netdisc_share_weixin",@"微信好友"]];
    [titleArr addObject:@[@"netdisc_share_qq",@"QQ好友"]];
    [titleArr addObject:@[@"netdisc_share_email",@"发送至邮箱"]];
    
    NSInteger titleNum = [titleArr count];
    CGFloat tWidth = self.frame.size.width/titleNum;
    for(int i=0;i<titleNum;i++) {
        NSArray *itemArr = [titleArr objectAtIndex:i];
        
        //创建"背景层"
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(tWidth*i, 0, tWidth, 115)];
        [_backView addSubview:backView];
        
        //创建“图标”
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake((tWidth-45)/2, 25, 45, 45)];
        [btnFunc setTag:i];
        [btnFunc setImage:[UIImage imageNamed:itemArr[0]] forState:UIControlStateNormal];
        [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btnFunc];
        
        //创建描述
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, tWidth, 20)];
        [lbMsg setText:itemArr[1]];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setFont:[UIFont systemFontOfSize:13.0]];
        [backView addSubview:lbMsg];
    }
    
    //弹出分享层
    [self showAlert];
}

/**
 *  分享按钮点击事件
 */
- (void)btnFuncClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    self.index = (NSInteger)btn.tag;
    [self dismiss];
}

- (void)showAlert {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

- (void)topToDismiss {
    self.index = -1;
    [self dismiss];
}

//直接分享
- (id)initWithParam:(UIViewController *)view index:(NSInteger)index param:(NSDictionary *)param {
    self = [super init];
    if(self) {
        _view = view;
        [self UMSocialShareSheetPressed:index param:param];
    }
    return self;
}

//分享
- (void)UMSocialShareSheetPressed:(NSInteger)index param:(NSDictionary *)param {
    //参数
    NSString *cover_url = [param objectForKey:@"cover_url"];
    NSString *share_url = [param objectForKey:@"share_url"];
    NSString *title = [param objectForKey:@"title"];
    NSString *content = [param objectForKey:@"content"];
    NSString *idStr = [param objectForKey:@"id"];
    
//    NSString *imageURL = @"";
//    if(!IsStringEmpty(cover_url)) {
//        imageURL = cover_url;
//    }
//    UIImage *imgData =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
    UIImage *image = [UIImage imageNamed:cover_url];
    UIImage *imgData =[UIImage imageWithData:UIImagePNGRepresentation(image)];
    NSInteger UMSocialPlatformType = -2;
    if (!_isHasCollect && index > 2) index++;
    switch (index) {
        case 0: {
            //微信好友
            NSLog(@"微信好友");
            UMSocialPlatformType = UMSocialPlatformType_WechatSession;
            break;
        }
        case 1: {
            //朋友圈
            NSLog(@"QQ好友");
            UMSocialPlatformType = UMSocialPlatformType_QQ;
            break;
        }
        case 2: {
            //发送至邮箱
            CGNetdiscEmailPopupView *popupView = [[CGNetdiscEmailPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-280)/2, 0, 280, 200)];
            popupView.callBack = ^(NSInteger tIndex, NSString *emailStr) {
                NSLog(@"您点击了:%zd-%@",tIndex,emailStr);
                if(tIndex==0) {
                    [self.popup dismiss:YES];
                }else {
                    //ID验证
                    if(IsStringEmpty(idStr)) {
                        [MBProgressHUD showError:@"网盘资源ID不能为空" toView:nil];
                        return ;
                    }
                    NSMutableDictionary *param = [NSMutableDictionary dictionary];
                    [param setValue:@"home" forKey:@"app"];
                    [param setValue:@"shareSkyDrive" forKey:@"act"];
                    [param setValue:idStr forKey:@"id"];
                    [param setValue:emailStr forKey:@"email"];
                    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                        [self.popup dismiss:YES];
                        NSString *msg = [json objectForKey:@"msg"];
                        NSString *code = [json objectForKey:@"code"];
                        if([code isEqualToString:SUCCESS]) {
                            [MBProgressHUD showSuccess:@"提交成功" toView:nil];
                        }else{
                            [MBProgressHUD showError:msg toView:nil];
                        }
                    } failure:^(NSError *error) {
                        NSLog(@"%@",[error description]);
                        [self.popup dismiss:YES];
                    }];
                }
                
            };
            self.popup = [KLCPopup popupWithContentView:popupView
                                               showType:KLCPopupShowTypeGrowIn
                                            dismissType:KLCPopupDismissTypeGrowOut
                                               maskType:KLCPopupMaskTypeDimmed
                               dismissOnBackgroundTouch:NO
                                  dismissOnContentTouch:NO];
            [self.popup show];
            
            break;
        }
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:imgData];
    shareObject.webpageUrl = share_url;
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            [MBProgressHUD showError:@"分享失败" toView:_view.view];
            
            //回调
            if(self.callSuccBack) {
                self.callSuccBack(NO);
            }
        }else{
            [MBProgressHUD showSuccess:@"分享成功" toView:_view.view];
            
            //回调
            if(self.callSuccBack) {
                self.callSuccBack(YES);
            }
            
        }
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
