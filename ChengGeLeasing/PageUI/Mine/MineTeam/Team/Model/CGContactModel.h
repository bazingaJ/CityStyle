//
//  CGContactModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/16.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  通讯录-模型
 */
@interface CGContactModel : NSObject

/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *id;
/**
 *  姓名
 */
@property (nonatomic, strong) NSString *name;
/**
 *  手机号码
 */
@property (nonatomic, strong) NSString *mobile;
/**
 *  手机号码(带“-”)
 */
@property (nonatomic, strong) NSString *mobileStr;
/**
 *  用户头像
 */
@property (nonatomic, strong) NSString *avatar;
/**
 *  是否已经加入该项目 1是2否 
 */
@property (nonatomic, strong) NSString *isIn;
/**
 *  已点击添加
 */
@property (nonatomic, assign) BOOL isAdd;

@end
