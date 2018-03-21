//
//  CGFindCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGFindCell.h"

@implementation CGFindCell

- (void)setFindModel:(CGFindModel *)model indexPath:(NSIndexPath *)indexPath {
    if(!model) return;
    
    self.indexPath = indexPath;
    
    //创建“更新时间”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 15)];
    [lbMsg setText:[NSString stringWithFormat:@"更新时间：%@",model.update_date]];
    [lbMsg setTextColor:COLOR9];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT12];
    [self.contentView addSubview:lbMsg];
    
    //创建“封面”
    NSString *imgURL = model.img_url;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 60, 60)];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [imgView setClipsToBounds:YES];
    [imgView.layer setCornerRadius:4.0];
    [imgView.layer setMasksToBounds:YES];
    [imgView.layer setBorderWidth:0.5];
    [imgView.layer setBorderColor:LINE_COLOR.CGColor];
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
    [self.contentView addSubview:imgView];
    
    //创建“资源名称”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, SCREEN_WIDTH-130, 20)];
    [lbMsg2 setText:model.name];
    [lbMsg2 setTextColor:COLOR3];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT16];
    [self.contentView addSubview:lbMsg2];
    
    //创建“分类”
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(80, 60, SCREEN_WIDTH-130, 20)];
    [lbMsg3 setText:model.cate];
    [lbMsg3 setTextColor:COLOR9];
    [lbMsg3 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg3 setFont:FONT13];
    [self.contentView addSubview:lbMsg3];
    
    //创建“数量”
    NSString *memNum = @"0";
    if(!IsStringEmpty(model.member_num)) {
        memNum = model.member_num;
    }
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 60, 40, 20)];
    [btnFunc setTitle:memNum forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR9 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT12];
    [btnFunc setImage:[UIImage imageNamed:@"find_contact_num"] forState:UIControlStateNormal];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [self.contentView addSubview:btnFunc];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 99.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView];
    
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
