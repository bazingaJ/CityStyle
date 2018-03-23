//
//  CGMemberCell.h
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMemberModel.h"
#import "SWTableViewCell.h"

@interface CGMemberCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *positionLab;
@property (nonatomic, strong) CGMemberModel *model;

@property (weak, nonatomic) IBOutlet UIButton *headImg;
@property (weak, nonatomic) IBOutlet UILabel *memberName;
@property (weak, nonatomic) IBOutlet UILabel *memberTel;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;
@property (nonatomic, strong) CGMemberModel*remove_model;

@end
