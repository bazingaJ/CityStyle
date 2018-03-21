//
//  CGFindChubeiCustomerCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGCustomerModel.h"
#import "SWTableViewCell.h"

@interface CGFindChubeiCustomerCell : SWTableViewCell

- (void)setCustomerModel:(CGCustomerModel *)model indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, assign) NSIndexPath *indexPath;

@end
