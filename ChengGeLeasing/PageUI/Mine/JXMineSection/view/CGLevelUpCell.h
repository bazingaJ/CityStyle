//
//  CGLevelUpCell.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/21.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXLevelUpDelegate <NSObject>

// plus button click event
- (void)plusBtnClickWithButton:(UIButton *)sender;

// miuns button click event
- (void)miunsBtnClickWithButton:(UIButton *)sender;


@end


@interface CGLevelUpCell : UITableViewCell

@property (nonatomic, assign) id<JXLevelUpDelegate>delegate;

/**
 cell1
 */
@property (weak, nonatomic) IBOutlet UILabel *itemLab1;
@property (weak, nonatomic) IBOutlet UILabel *detailLab1;

/**
 cell2
 */
@property (weak, nonatomic) IBOutlet UILabel *itemLab2;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UILabel *detailLab2;

/**
 cell3
 */
@property (weak, nonatomic) IBOutlet UIImageView *payImage;
@property (weak, nonatomic) IBOutlet UILabel *payTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *payDetailLab;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end
