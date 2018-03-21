//
//  CGCustomerFunnelHeadView.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CGCustomerFunnelHeadViewDelegate <NSObject>

- (void)CGCustomerFunnelHeadViewClick:(NSString *)tagStr;

@end


@interface CGCustomerFunnelHeadView : UIView

@property (assign) id<CGCustomerFunnelHeadViewDelegate> delegate;
@property (nonatomic, strong) NSArray *dataArr;

@end
