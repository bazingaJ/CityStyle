//
//  CGEmailPopView.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CGEmailPopViewDelegate <NSObject>

-(void)cgEmailPopView:(UIButton *)sender;

@end
@interface CGEmailPopView : UIView
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,weak)id <CGEmailPopViewDelegate>delegate;
@end
