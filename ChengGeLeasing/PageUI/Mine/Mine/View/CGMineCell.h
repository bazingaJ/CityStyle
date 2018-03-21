//
//  CGMineCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGUserModel.h"

@interface CGMineCell : UITableViewCell

- (void)setMineCellModel:(CGUserModel *)model indexPath:(NSIndexPath *)indexPath titleDic:(NSMutableDictionary *)titleDic;

@end
