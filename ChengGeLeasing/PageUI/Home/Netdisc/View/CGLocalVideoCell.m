//
//  CGLocalVideoCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/27.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLocalVideoCell.h"

@implementation CGLocalVideoCell

- (void)setLocalVideoModel:(CGLocalVideoModel *)model {
    if(!model) return;
    
    //创建“视频截图”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 55, 55)];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [imgView setClipsToBounds:YES];
    if(model.thumbnail) {
        [imgView setImage:model.thumbnail];
    }else{
        //调用本地图片
        [imgView setImage:[UIImage imageNamed:@"default_img_square_list"]];
    }
    [self.contentView addSubview:imgView];
    
    //创建“视频小图标”
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 40, 10, 10)];
    [imgView2 setImage:[UIImage imageNamed:@"local_icon_video"]];
    [imgView addSubview:imgView2];
    
    //创建“视频名称”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, SCREEN_WIDTH-90, 20)];
    [lbMsg setText:model.video_name];
    [lbMsg setTextColor:UIColorFromRGBWith16HEX(0x333333)];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [self.contentView addSubview:lbMsg];
    
    //创建“视频大小”
    NSString *videoSize = [model fileSize:model.video_size];
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 35, 100, 20)];
    if(!IsStringEmpty(videoSize)) {
        [lbMsg2 setText:videoSize];
    }
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setTextColor:UIColorFromRGBWith16HEX(0x999999)];
    [lbMsg2 setFont:FONT11];
    [self.contentView addSubview:lbMsg2];
    
    //创建“视频发布时间”
    UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(80, 55, 150, 20)];
    [lbMsg3 setText:model.video_time];
    [lbMsg3 setTextColor:UIColorFromRGBWith16HEX(0x999999)];
    [lbMsg3 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg3 setFont:FONT11];
    [self.contentView addSubview:lbMsg3];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 84.6, SCREEN_WIDTH, 0.5)];
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
