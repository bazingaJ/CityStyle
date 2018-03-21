//
//  CGCustomerCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGCustomerCell.h"

@implementation CGCustomerCell

- (void)setCustomerModel:(CGCustomerModel *)model indexPath:(NSIndexPath *)indexPath {
    if(!model) return;
    
    self.indexPath = indexPath;
    
    //创建“首字母”
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    [imageView.layer setCornerRadius:4];
    [imageView.layer setMasksToBounds:YES];
    [imageView setBackgroundColor:MAIN_COLOR];
    imageView.layer.borderWidth = .5;
    imageView.layer.borderColor = LINE_COLOR.CGColor;
    [self.contentView addSubview:imageView];
    
    if (!IsStringEmpty(model.logo))
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage avatarWithName:model.first_letter]];
    }
    else
    {
        imageView.image = [UIImage avatarWithName:model.first_letter];
    }
    
    //创建“名称”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, SCREEN_WIDTH-150, 20)];
    [lbMsg2 setText:model.name];
    [lbMsg2 setTextColor:COLOR3];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT16];
    [self.contentView addSubview:lbMsg2];
    
    //创建“时间”
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 10, 70, 20)];
    [lbMsg3 setText:model.add_time];
    [lbMsg3 setTextColor:COLOR9];
    [lbMsg3 setTextAlignment:NSTextAlignmentRight];
    [lbMsg3 setFont:FONT12];
    [self.contentView addSubview:lbMsg3];
    
    //创建“类型”
    UILabel *lbMsg4 = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 100, 20)];
    [lbMsg4 setText:model.cate_name];
    [lbMsg4 setTextColor:COLOR9];
    [lbMsg4 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg4 setFont:FONT13];
    [self.contentView addSubview:lbMsg4];
    
    //创建“意向度”
    UILabel *lbMsg9 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 30, 90, 20)];
    [lbMsg9 setText:[NSString stringWithFormat:@"意向度:%@%%",model.intent]];
    [lbMsg9 setTextColor:UIColorFromRGBWith16HEX(0x789BD4)];
    [lbMsg9 setTextAlignment:NSTextAlignmentRight];
    [lbMsg9 setFont:FONT13];
    [self.contentView addSubview:lbMsg9];
    
    //创建“客户名称”
    UILabel *lbMsg5 = [[UILabel alloc] initWithFrame:CGRectMake(180, 30, SCREEN_WIDTH-190, 20)];
    [lbMsg5 setText:model.pro_name];
    [lbMsg5 setTextColor:MAIN_COLOR];
    [lbMsg5 setTextAlignment:NSTextAlignmentRight];
    [lbMsg5 setFont:FONT13];
    [self.contentView addSubview:lbMsg5];
    
    //创建“内容”
    NSString *contentStr = model.intro;
    UILabel *lbMsg6 = [[UILabel alloc] initWithFrame:CGRectMake(70, 50, SCREEN_WIDTH-80, 50)];
    [lbMsg6 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg6 setTextColor:COLOR3];
    [lbMsg6 setFont:FONT13];
    [lbMsg6 setNumberOfLines:2];
    if(!IsStringEmpty(contentStr)) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:5.0f];
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
        [lbMsg6 setAttributedText:attStr];
    }
    [self.contentView addSubview:lbMsg6];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 104.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView];
    
    //创建“招租”、“待办”
    NSMutableArray *titleArr = [NSMutableArray array];
    //招租
    NSString *intentStr = @"0";
    if(!IsStringEmpty(model.intent_count)) {
        intentStr = model.intent_count;
    }
    [titleArr addObject:@[@"intent_icon_count",intentStr]];
    //待办
    NSString *todoStr = @"0";
    if(!IsStringEmpty(model.to_do_count)) {
        todoStr = model.to_do_count;
    }
    [titleArr addObject:@[@"todo_icon_count",todoStr]];
    
    NSInteger titleNum = [titleArr count];
    for (int i=0; i<titleNum; i++) {
        NSArray *itemArr = [titleArr objectAtIndex:i];
        
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10+70*i, 105, 70, 30)];
        [btnFunc setTitle:itemArr[1] forState:UIControlStateNormal];
        [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT12];
        [btnFunc setImage:[UIImage imageNamed:itemArr[0]] forState:UIControlStateNormal];
        [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [self.contentView addSubview:btnFunc];
    }
    
    //是否我的客户
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 105, 90, 30)];
    if([model.is_mine isEqualToString:@"1"])
    {
         [btnFunc setTitle:@"我" forState:UIControlStateNormal];
    }
    else
    {
        [btnFunc setTitle:model.user_name forState:UIControlStateNormal];
    }
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT12];
    [btnFunc setImage:[UIImage imageNamed:@"customer_icon_mine"] forState:UIControlStateNormal];
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.contentView addSubview:btnFunc];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
