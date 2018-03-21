//
//  CGAddNoteViewController.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGAddNoteViewController : BaseTableViewController

@property (nonatomic, strong) void (^callBack)(NSString *content);
@property (nonatomic, strong) NSString *content;

@end
