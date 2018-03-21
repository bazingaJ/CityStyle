//
//  LTPickerView.h
//  AIYISHU
//
//  Created by 相约在冬季 on 16/4/11.
//  Copyright © 2016年 AIYISHU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTPickerView : UIView
@property (nonatomic,strong) void (^block)(id obj,NSString* str,int num);
@property (nonatomic,copy) NSString* title;
@property (nonatomic,strong) NSArray* dataSource;//数据源
@property (nonatomic,copy) NSString* defaultStr;
-(void)show;
-(void)close;
@end
