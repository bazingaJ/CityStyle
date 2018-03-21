//
//  CGFindViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGFindCell.h"

@interface CGFindViewController : BaseTableViewController<SWTableViewCellDelegate>

/**
 *  从品牌资源库添加客户
 */
@property (nonatomic, assign) BOOL isAdd;
/**
 *  说明储备客户
 */
@property (nonatomic,strong) NSString *chuBeiKeHuID;

@end
