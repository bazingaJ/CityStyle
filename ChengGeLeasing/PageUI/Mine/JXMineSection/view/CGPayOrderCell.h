//
//  CGPayOrderCell.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGOrderListModel.h"

@interface CGPayOrderCell : UITableViewCell

@property (nonatomic, strong) CGOrderListModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLab;
@property (weak, nonatomic) IBOutlet UILabel *orderContentLab;
@property (weak, nonatomic) IBOutlet UILabel *orderAmount;

@end
