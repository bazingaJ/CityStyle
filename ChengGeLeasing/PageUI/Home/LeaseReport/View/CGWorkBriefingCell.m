//
//  CGWorkBriefingCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/20.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGWorkBriefingCell.h"

@implementation CGWorkBriefingCell

- (void)setWorkBriefingModel:(CGWorkBriefingModel *)model {
    if(!model) return;
    
    //创建“图标”
    UIImage *img = [UIImage imageNamed:model.icon];
    CGFloat tW = img.size.width;
    CGFloat tH = img.size.height;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10+(80-tW)/2, 15, tW, tH)];
    [imgView setImage:img];
    [self.contentView addSubview:imgView];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 80, 15)];
    //[lbMsg setText:titleArr[1]];
    [lbMsg setText:model.name];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentCenter];
    [lbMsg setFont:FONT13];
    [self.contentView addSubview:lbMsg];
    
    //创建“个数”
    NSString *numStr = @"0个";
    if(!IsStringEmpty(model.count)) {
        numStr = [NSString stringWithFormat:@"%@个",model.count];
    }
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, 25, SCREEN_WIDTH/3, 25)];
    [lbMsg2 setText:numStr];
    [lbMsg2 setTextColor:COLOR3];
    [lbMsg2 setTextAlignment:NSTextAlignmentCenter];
    [lbMsg2 setFont:FONT15];
    [self.contentView addSubview:lbMsg2];
    if(!IsStringEmpty(numStr)) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:numStr];
        //字体颜色
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:[UIColor blackColor]
                        range:NSMakeRange(0, [numStr length]-1)];
        //字体大小
        [attrStr addAttribute:NSFontAttributeName
                        value:FONT24
                        range:NSMakeRange(0, [numStr length]-1)];
        
        lbMsg2.attributedText = attrStr;
    }
    
    //创建“排名”
    if(model.isMem || model.isMine) {
        
        NSString *sortStr = [NSString stringWithFormat:@"NO.%@",model.rank];
        UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 25, SCREEN_WIDTH/2-30, 25)];
        [lbMsg3 setText:sortStr];
        [lbMsg3 setTextColor:[UIColor blackColor]];
        [lbMsg3 setTextAlignment:NSTextAlignmentRight];
        [lbMsg3 setFont:FONT24];
        [self.contentView addSubview:lbMsg3];
        if(!IsStringEmpty(sortStr)) {
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:sortStr];
            //字体颜色
            [attrStr addAttribute:NSForegroundColorAttributeName
                            value:COLOR3
                            range:NSMakeRange(0, 3)];
            //字体大小
            [attrStr addAttribute:NSFontAttributeName
                            value:FONT15
                            range:NSMakeRange(0, 3)];
            
            lbMsg3.attributedText = attrStr;
        }
        
    }
    
    //创建“升降(1不变 2上升 3下降)”
    if((model.isMem || model.isMine) && model.isTime) {
        UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 32.5, 11.5, 10)];
        if([model.ratio isEqualToString:@"2"]) {
            //上升
            [imgView2 setImage:[UIImage imageNamed:@"work_icon_up2"]];
        }else if([model.ratio isEqualToString:@"3"]) {
            //下降
            [imgView2 setImage:[UIImage imageNamed:@"work_icon_down2"]];
        }
        [self.contentView addSubview:imgView2];
    }
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 74.5, SCREEN_WIDTH, 0.5)];
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
