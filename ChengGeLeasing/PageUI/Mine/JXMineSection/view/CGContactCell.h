//
//  CGContactCell.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/27.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGContactModel.h"

@protocol JXContactDelegate <NSObject>



@end

@interface CGContactCell : UITableViewCell

@property (nonatomic, strong) CGContactModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UIButton *invateBtn;
@property (nonatomic, assign) id<JXContactDelegate>delegate;
@end
