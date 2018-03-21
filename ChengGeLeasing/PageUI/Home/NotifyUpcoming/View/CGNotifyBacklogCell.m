//
//  CGNotifyBacklogCell.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGNotifyBacklogCell.h"

@implementation CGNotifyBacklogCell

-(void)setModel:(CGNotifyBacklogModel *)model
{
    //创建"头像"
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 50, 50)];
    imageView.backgroundColor = UIColorFromRGBWith16HEX(0xBCCDE8);
    imageView.layer.cornerRadius = 5;
    imageView.clipsToBounds = YES;
    imageView.image = [UIImage imageNamed:@"home_icon_right"];
    imageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:imageView];
    
    //创建"名字"
    UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right +15, 15, 100, 20)];
    lbMsg.textColor = COLOR9;
    lbMsg.font = FONT12;
    lbMsg.text = @"林长志";
    [self.contentView addSubview:lbMsg];
    
    //创建"时间"
    UILabel *lbMsg1 =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -150, 15, 145, 20)];
    lbMsg1.textColor = COLOR9;
    lbMsg1.font = FONT12;
    lbMsg1.text = @"2016-12-16 18:14:25";
    [self.contentView addSubview:lbMsg1];
    
    //创建"详情";
    UILabel *lbMsg2 = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right +15, lbMsg1.bottom-4, SCREEN_WIDTH  -lbMsg.x, 50)];
    lbMsg2.font = FONT15;
    lbMsg2.text = @"待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项待办事项";
    lbMsg2.textColor = COLOR3;
    lbMsg2.numberOfLines = 2;
    [self.contentView addSubview:lbMsg2];
    
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 79.5, SCREEN_WIDTH, .5)];
    lineView.backgroundColor = LINE_COLOR;
    [self.contentView addSubview:lineView];
}

- (NSArray *)importantRightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:GRAY_COLOR icon:[UIImage imageNamed:@"delete_icon_small"]];
     [rightUtilityButtons sw_addUtilityButtonWithColor:GRAY_COLOR icon:[UIImage imageNamed:@"delete_icon_small"]];
    return rightUtilityButtons;
}

@end
