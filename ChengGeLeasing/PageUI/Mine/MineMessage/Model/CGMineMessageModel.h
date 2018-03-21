//
//  CGMineMessageModel.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  消息-模型
 */
@interface CGMineMessageModel : NSObject

/**
 *  消息ID
 */
@property (nonatomic, strong) NSString *system_message_id;
/**
 *  消息标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  消息内容
 */
@property (nonatomic, strong) NSString *content;
/**
 *  消息发布时间
 */
@property (nonatomic, strong) NSString *date;
/**
 *  是否已读：1已读 2未读
 */
@property (nonatomic, strong) NSString *is_read;

@end
