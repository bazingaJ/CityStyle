//
//  CGVersionCell.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/21.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGVersionCell : UITableViewCell

@property (nonatomic, strong) UILabel *itemLab;

@property (nonatomic, strong) UILabel *detailLab1;

@property (nonatomic, strong) UILabel *detailLab2;

+(instancetype)cellWithTableView:(UITableView*)tableView;

@end
