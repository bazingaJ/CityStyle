//
//  CGUMSocialSheetEx.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGUMSocialSheetEx : UIView

@property (strong, nonatomic) UIView *backView;
@property (assign, nonatomic) CGFloat yPosition;
@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSMutableArray *timeArr;

- (void)show;
- (void)dismiss;
- (id)initWithView:(UIViewController *)view param:(NSDictionary *)param;
- (void)showAlert;

@property (nonatomic, strong) UIViewController *view;
@property (nonatomic, strong) NSDictionary *param;

//直接分享
- (id)initWithParam:(UIViewController *)view index:(NSInteger)index param:(NSDictionary *)param;

//分平台分享
- (void)UMSocialShareSheetPressed:(NSInteger)index param:(NSDictionary *)param;

@property (nonatomic, assign) BOOL isHasCollect;
@property (nonatomic, copy) NSString *is_collect;
@property (nonatomic, copy) void(^callBackBlock)(NSString *is_collect);

@property (strong, nonatomic) KLCPopup *popup;

@property (nonatomic, copy) void(^callSuccBack)(BOOL isSucc);

@end
