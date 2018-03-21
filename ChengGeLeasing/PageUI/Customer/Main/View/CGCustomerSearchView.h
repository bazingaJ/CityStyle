//
//  CGCustomerSearchView.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/8/1.
//  Copyright © 2017年 田浩渺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGCustomerSearchView : UIView

@property(nonatomic,strong)UIColor *btnTitleColor;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)void (^callBack)(NSString *str);

-(void)setUpSearchView;

@end
