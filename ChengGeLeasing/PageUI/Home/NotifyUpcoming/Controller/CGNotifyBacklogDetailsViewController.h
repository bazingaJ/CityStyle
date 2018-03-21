//
//  CGNotifyBacklogDetailsViewController.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGNotifyBacklogDetailsViewController : BaseTableViewController

@property (nonatomic, strong) NSString *toDo_id;
/**
 *  是否已办:1是 2否
 */
@property (nonatomic, strong) NSString *is_do;

@end
