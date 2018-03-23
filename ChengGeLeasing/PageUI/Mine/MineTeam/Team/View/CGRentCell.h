//
//  CGRentCell.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGRentCell : UITableViewCell

/**
 cell1
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *numTF1;

/**
 cell2
 */
@property (weak, nonatomic) IBOutlet UITextField *numTF2;
@property (weak, nonatomic) IBOutlet UILabel *conditionLab;

@end
