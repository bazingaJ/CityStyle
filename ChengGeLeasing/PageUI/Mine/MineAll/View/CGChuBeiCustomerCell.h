//
//  CGChuBeiCustomerCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGCustomerModel.h"
#import "SWTableViewCell.h"

@interface CGChuBeiCustomerCell : SWTableViewCell

- (void)setCustomerModel:(CGCustomerModel *)model indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, assign) NSIndexPath *indexPath;

@end
