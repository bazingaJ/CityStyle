//
//  CGHomeViewController+Version.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGHomeViewController+Version.h"

static const void *trackViewUrlKey = &trackViewUrlKey;
static const void *popupKey = &popupKey;

@implementation CGHomeViewController (Version)

- (void)setTrackViewUrl:(NSString *)trackViewUrl {
    objc_setAssociatedObject(self, &trackViewUrlKey, trackViewUrl, OBJC_ASSOCIATION_COPY);
}

- (NSString *)trackViewUrl {
    return objc_getAssociatedObject(self, &trackViewUrlKey);
}

- (void)setPopup:(KLCPopup *)popup {
    objc_setAssociatedObject(self, &popupKey, popup, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (KLCPopup *)popup {
    return objc_getAssociatedObject(self, &popupKey);
}

/**
 * 检测系统版本
 */
- (void)checkSystemVersion {
    NSLog(@"检测系统版本");
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"getUpdateVersion" forKey:@"act"];
    [param setValue:APP_Version forKey:@"cur_version"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json){
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(![dataDic isKindOfClass:[NSDictionary class]]) return ;
            
            //获取升级版本信息
            NSString *version = [dataDic objectForKey:@"version"];
            self.trackViewUrl = [dataDic objectForKey:@"down_url"];
            NSString *is_force = [dataDic objectForKey:@"is_force"];
            
            //是否可以更新
            NSString *is_update = [dataDic objectForKey:@"is_update"];
            BOOL isUpdate = [is_update isEqualToString:@"1"] ? YES : NO;
            
            //提示时间间隔
            NSString *time_interval = [dataDic objectForKey:@"time_interval"];
            NSInteger timeInterval = 0;
            if(!IsStringEmpty(time_interval)) {
                timeInterval = [time_interval integerValue];
            }
            
            //字符串验证
            if(IsStringEmpty(version)) return;
            
            //获取本地版本
            NSString *locStr = [HelperManager CreateInstance].getAppVersion;
            NSInteger locV = [[locStr stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
            
            //线上版本
            NSInteger serV = [[version stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
            
            //版本比对是否需要弹出提示
            BOOL isDown = NO;
            if(serV>locV) {
                isDown = YES;
            }
            
            if(isUpdate && isDown) {
                
                //检测上次弹窗时间
                NSUserDefaults *timeDefaults = [NSUserDefaults standardUserDefaults];
                NSDate *last_time = [timeDefaults objectForKey:@"alert_time"];
                int showTime = [self compareCurrentTime:last_time];
                if(showTime==0 || showTime>timeInterval) {
                    NSString *updateIntro = [dataDic objectForKey:@"intro"];
                    
                    //弹出版本检测提示框
                    NSMutableDictionary *param = [NSMutableDictionary dictionary];
                    [param setValue:updateIntro forKey:@"content"];
                    [param setValue:version forKey:@"version"];
                    [param setValue:is_force forKey:@"is_force"];
                    CGVersionPopupView *popupView = [[CGVersionPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-280)/2, 0, 280, 450) param:param];
                    popupView.delegate = self;
                    self.popup = [KLCPopup popupWithContentView:popupView
                                                       showType:KLCPopupShowTypeBounceInFromTop
                                                    dismissType:KLCPopupDismissTypeGrowOut
                                                       maskType:KLCPopupMaskTypeDimmed
                                       dismissOnBackgroundTouch:NO
                                          dismissOnContentTouch:NO];
                    self.popup.layer.cornerRadius = 10.0;
                    [self.popup show];
                }
            }
        }else{
            [MBProgressHUD showError:json[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
}

- (void)popupView:(CGVersionPopupView *)popupView withSender:(UIButton *)sender {
    [self.popup dismiss:YES];
    switch (sender.tag) {
        case 0: {
            //立即升级
            NSLog(@"立即升级");
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.trackViewUrl]];
            
            break;
        }
        case 1: {
            //暂不更新
            NSLog(@"暂不更新");
            
            //设置提示时间间隔
            NSDate *localDate = [NSDate date];
            NSUserDefaults *timeDefaults = [NSUserDefaults standardUserDefaults];
            [timeDefaults setObject:localDate forKey:@"alert_time"];
            [timeDefaults synchronize];
            
            break;
        }
        case 2: {
            //关闭
            NSLog(@"关闭");
            [self.popup dismiss:YES];
            
            break;
        }
            
        default:
            break;
    }
}

//关闭窗体
- (void)popupView:(CGVersionPopupView *)popupView dismissWithSender:(id)sender {
    [self.popup dismiss:YES];
}

//时间转换
-(int)compareCurrentTime:(NSDate*)compareDate {
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    return timeInterval;
}

@end
