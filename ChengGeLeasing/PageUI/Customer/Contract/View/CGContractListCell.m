//
//  CGContractListCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGContractListCell.h"

@implementation CGContractListCell

- (void)setContractModel:(CGContractModel *)model {
    if(!model) return;
    
    //创建“合同标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-120, 20)];
    [lbMsg setText:model.pro_name];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    
    //创建“合同状态”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-110, 10, 100, 20)];
    [lbMsg2 setText:model.status_name];
    [lbMsg2 setTextColor:MAIN_COLOR];
    [lbMsg2 setTextAlignment:NSTextAlignmentRight];
    [lbMsg2 setFont:FONT16];
    [self.contentView addSubview:lbMsg2];
    
    //创建“签约铺位”
    NSMutableArray *titleArr = [NSMutableArray array];
    //签约铺位
    NSString *posName = @"";
    if(!IsStringEmpty(model.pos_name)) {
        posName = model.pos_name;
    }
    [titleArr addObject:@[@"签约铺位",posName]];
    //签约面积
    NSString *areaStr = @"0";
    if(!IsStringEmpty(model.area)) {
        areaStr = model.area;
    }
    [titleArr addObject:@[@"签约面积",[NSString stringWithFormat:@"%@m²",areaStr]]];
    //开始时间
    NSString *startTime = @"";
    if(!IsStringEmpty(model.start_time)) {
        startTime = model.start_time;
    }
    [titleArr addObject:@[@"开始时间",startTime]];
    //结束时间
    NSString *endTime = @"";
    if(!IsStringEmpty(model.end_time)) {
        endTime = model.end_time;
    }
    [titleArr addObject:@[@"结束时间",endTime]];
    //合作方式
    NSString *mannerName = @"";
    if(!IsStringEmpty(model.manner_name)) {
        mannerName = model.manner_name;
    }
    [titleArr addObject:@[@"合作方式",mannerName]];
    
    CGFloat tWidth = (SCREEN_WIDTH-20)/2;
    for (int i=0; i<3; i++) {
        for (int k=0; k<2; k++) {
            NSInteger tIndex = 2*i+k;
            if(tIndex>[titleArr count]-1) continue;
            
            NSArray *itemArr = [titleArr objectAtIndex:tIndex];
            
            UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(10+tWidth*k, 30+20*i, tWidth, 20)];
            [lbMsg3 setText:[NSString stringWithFormat:@"%@:%@",itemArr[0],itemArr[1]]];
            [lbMsg3 setTextColor:COLOR9];
            [lbMsg3 setTextAlignment:NSTextAlignmentLeft];
            [lbMsg3 setFont:FONT14];
            [self.contentView addSubview:lbMsg3];
            
        }
    }
    
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
