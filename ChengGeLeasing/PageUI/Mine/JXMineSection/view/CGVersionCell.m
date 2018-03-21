//
//  CGVersionCell.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/21.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGVersionCell.h"

static NSString *const cellIdentifier = @"JX_CGVersionCell";

@implementation CGVersionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+ (instancetype)cellWithTableView:(UITableView*)tableView
{
    CGVersionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[CGVersionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // create title label
        self.itemLab = [[UILabel alloc] init];
        self.itemLab.font = FONT15;
        self.itemLab.textColor = COLOR3;
        self.itemLab.text = @"";
        [self.contentView addSubview:self.itemLab];
        [self.itemLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        // create free detail label
        self.detailLab1 = [[UILabel alloc] init];
        self.detailLab1.font = FONT15;
        self.detailLab1.textColor = COLOR6;
        self.detailLab1.text = @"";
        self.detailLab1.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.detailLab1];
        [self.detailLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        // create enterprise detail label
        self.detailLab2 = [[UILabel alloc] init];
        self.detailLab2.font = FONT15;
        self.detailLab2.textColor = COLOR6;
        self.detailLab2.text = @"";
        self.detailLab2.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.detailLab2];
        [self.detailLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_right).offset(-50);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        UIView *lineVi = [[UIView alloc] init];
        lineVi.backgroundColor = LINE_COLOR;
        [self.contentView addSubview:lineVi];
        [lineVi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(self.contentView);
        }];
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
