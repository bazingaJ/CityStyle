//
//  CGSelectAddCustomerModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGSelectAddCustomerModel.h"

@implementation CGSelectAddCustomerModel

-(void)setLinkman_list:(NSArray *)linkman_list
{
    _linkman_list = linkman_list;
    //联系人id
    _linkman_id     =linkman_list[0][@"id"];
    //联系人名字
    _linkman_name   =linkman_list[0][@"name"];
    //联系人手机号
    _linkman_mobile =linkman_list[0][@"mobile"];
}

@end
