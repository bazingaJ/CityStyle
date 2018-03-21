//
//  CGCustomerDetailViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGCustomerDetailViewController : BaseViewController

/**
 *  客户ID
 */
@property (nonatomic, strong) NSString *cust_id;
/**
 *  是否签约
 */
@property (nonatomic, assign) BOOL isSign;
/**
 *  是否为我的客户:1是 2否
 */
@property (nonatomic, strong) NSString *isMine;
/**
 *  客户封面
 */
@property (nonatomic, strong) NSString *cust_cover;
/**
 *  1储备客户  2经营事项
 */
@property (nonatomic, assign) NSInteger type;
/**
 *  是否从全部客户界面进去
 */
@property (nonatomic, assign) BOOL isAllCust;

@end
