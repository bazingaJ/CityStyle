//
//  CGIntentionSelectionViewController.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGIntentionSelectionViewController : BaseTableViewController

/**
 * 是否可以(仅仅可以)选择100% 1是2否 （仅仅90%的意向度才可以）
 */
@property (nonatomic, strong) NSString *is_can_hundred;
/**
 * 1:招租事项
 */
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) void(^callBack)(NSDictionary *dataDic);

@end
