//
//  CGNetdiscCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/27.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGNetdiscCell.h"

@implementation CGNetdiscCell

- (void)setNetdiscModel:(CGNetdiscModel *)model indexPath:(NSIndexPath *)indexPath {
    if(!model) return;
    
    //创建“背景层”
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [backView.layer setCornerRadius:4.0];
    [backView.layer setMasksToBounds:YES];
    [backView setBackgroundColor:MAIN_COLOR];
    [self.contentView addSubview:backView];
    
    //创建“图标”
    //文件类型 1图片 2视频 3word 4excel 5 CAD 6 3DMAX 7 PDF 8其他
    
    NSString *imgStr = @"";
    switch ([model.type integerValue]) {
        case 1: {
            //图片
            imgStr = @"netdisc_icon_image";
            
            break;
        }
        case 2: {
            //视频
            imgStr = @"netdisc_icon_video";
            
            break;
        }
        case 3: {
            //Word
            imgStr = @"netdisc_icon_word";
            
            break;
        }
        case 4: {
            //Excel
            imgStr = @"netdisc_icon_excel";
            
            break;
        }
        case 5: {
            //CAD
            imgStr = @"netdisc_icon_cad";
            
            break;
        }
        case 6: {
            //3DMAX
            imgStr = @"netdisc_icon_other";
            
            break;
        }
        case 7: {
            //PDF
            imgStr = @"netdisc_icon_pdf";
            
            break;
        }
        case 8: {
            //其他
            imgStr = @"netdisc_icon_other";
            
            break;
        }
            
        default:
            break;
    }
    model.cover_icon = imgStr;
    
    UIImage *img = [UIImage imageNamed:imgStr];
    CGFloat tW = img.size.width;
    CGFloat tH = img.size.height;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((50-tW)/2, (50-tH)/2, tW, tH)];
    [imgView setImage:img];
    [imgView setUserInteractionEnabled:NO];
    [backView addSubview:imgView];
    
    //创建“文件名称”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, SCREEN_WIDTH-80, 20)];
    [lbMsg setText:model.name];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    
    //创建“文件名”、“时间”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 40, SCREEN_WIDTH-80, 20)];
    [lbMsg2 setText:model.add_time];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT12];
    [self.contentView addSubview:lbMsg2];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 69.5, SCREEN_WIDTH, 0.5)];
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
