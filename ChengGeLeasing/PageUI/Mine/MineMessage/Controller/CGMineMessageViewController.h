//
//  CGMineMessageViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGSegmentView.h"

@interface CGMineMessageViewController : BaseViewController<CGSegmentViewDelegate>

/**
 *  是否是推送跳过来的
 */
@property (nonatomic, assign) BOOL isPush;
/**
 *  索引值
 */
@property (nonatomic, assign) NSInteger segmentIndex;

@end
