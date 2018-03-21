//
//  CGMineTeamAreaAddViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGTeamAreaModel.h"

@interface CGMineTeamAreaAddViewController : BaseViewController<UITextFieldDelegate>

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *pro_id;
/**
 *  区域对象
 */
@property (nonatomic, strong) CGTeamAreaModel *areaInfo;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^callBack)();

@end
