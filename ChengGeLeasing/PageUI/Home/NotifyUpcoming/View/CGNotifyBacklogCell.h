//
//  CGNotifyBacklogCell.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGNotifyBacklogModel.h"
#import "SWTableViewCell.h"
@interface CGNotifyBacklogCell :SWTableViewCell

@property (nonatomic ,strong) CGNotifyBacklogModel *model;

- (NSArray *)importantRightButtons;
@end
