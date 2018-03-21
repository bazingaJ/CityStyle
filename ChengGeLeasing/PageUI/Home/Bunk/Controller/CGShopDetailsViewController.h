//
//  CGShopDetailsViewController.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGShopDetailsViewController : BaseViewController
@property (nonatomic, strong) NSString *pos_id;//商铺ID
@property (nonatomic, assign) NSInteger type;//1:首页-经营动态 2:首页直接进
@property (nonatomic, strong) NSString *is_mine;//是否是自己
@property (nonatomic, strong) void(^callBackData)(void);//1:首页-经营动态 2:首页直接进
@end
