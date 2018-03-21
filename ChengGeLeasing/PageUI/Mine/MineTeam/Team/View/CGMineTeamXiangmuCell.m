//
//  CGMineTeamXiangmuCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamXiangmuCell.h"

@implementation CGMineTeamXiangmuCell

- (void)setTeamXiangmuModel:(CGTeamXiangmuModel *)model indexPath:(NSIndexPath *)indexPath {
    if(!model) return;
    
    self.indexPath = indexPath;
    
    //创建“背景层”
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 120)];
    [backView.layer setCornerRadius:5.0];
    [backView.layer setMasksToBounds:YES];
    [backView.layer setBorderWidth:0.3];
    [backView.layer setBorderColor:MAIN_COLOR.CGColor];
    [backView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:backView];
    
    //创建“姓名”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [lbMsg.layer setCornerRadius:4];
    [lbMsg.layer setMasksToBounds:YES];
    [lbMsg setBackgroundColor:MAIN_COLOR];
    [lbMsg setText:model.initials];
    [lbMsg setTextColor:[UIColor whiteColor]];
    [lbMsg setTextAlignment:NSTextAlignmentCenter];
    [lbMsg setFont:FONT24];
    [backView addSubview:lbMsg];
    
    //创建“项目名称”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(70, 10, SCREEN_WIDTH-80, 25)];
    [btnFunc setTitle:model.name forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT18];
    [btnFunc setImage:[UIImage imageNamed:@"left_icon_member"] forState:UIControlStateNormal];
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backView addSubview:btnFunc];
    
    //创建“总面积”、“已租面积”
    
    //总面积
    CGFloat totalArea = 0;
    if(!IsStringEmpty(model.totalArea)) {
        totalArea = [model.totalArea floatValue];
    }
    
    //已租面积
    NSInteger signArea = 0;
    if(IsStringEmpty(model.totalSignArea)) {
        signArea = [model.totalSignArea floatValue];
    }
    
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 40, SCREEN_WIDTH-80, 20)];
    [lbMsg2 setText:[NSString stringWithFormat:@"总面积：%.2fm²    已租面积：%.2fm²",totalArea,signArea]];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT12];
    [backView addSubview:lbMsg2];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, 70, backView.frame.size.width-10, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [backView addSubview:lineView];
    
    //创建“参数”
    NSMutableArray *titleArr = [NSMutableArray array];
    //已租
    NSString *signNum = @"0%";
    if(!IsStringEmpty(model.signNum)) {
        signNum = [[NSString stringWithFormat:@"%@",model.signNum] stringByAppendingString:@"%"];
    }
    [titleArr addObject:@[signNum,@"已租"]];
    //稳营商铺
    NSString *profitNum = @"0%";
    if(!IsStringEmpty(model.profitNum)) {
        profitNum = [[NSString stringWithFormat:@"%@",model.profitNum] stringByAppendingString:@"%"];
    }
    [titleArr addObject:@[profitNum,@"稳营商铺"]];
    //预动商铺
    NSString *togoNum = @"0";
    if(!IsStringEmpty(model.togoNum)) {
        togoNum = model.togoNum;
    }
    [titleArr addObject:@[togoNum,@"预动商铺"]];
    //退铺警告
    NSString *outNum = @"0";
    if(!IsStringEmpty(model.outNum)) {
        outNum = model.outNum;
    }
    [titleArr addObject:@[outNum,@"退铺警告"]];
    NSInteger titleNum = [titleArr count];
    
    CGFloat tWidth = backView.frame.size.width/titleNum;
    
    for (int i=0; i<titleNum; i++) {
        NSArray *itemArr = [titleArr objectAtIndex:i];
        
        UIView *tView = [[UIView alloc] initWithFrame:CGRectMake(tWidth*i, 70, tWidth-1, 50)];
        [backView addSubview:tView];
        
        //创建“值”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, tWidth, 20)];
        [lbMsg setText:itemArr[0]];
        [lbMsg setTextColor:MAIN_COLOR];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setFont:FONT13];
        if(i==3) {
            [lbMsg setTextColor:RED_COLOR];
        }
        [tView addSubview:lbMsg];
        
        //创建“标题”
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, tWidth, 20)];
        [lbMsg2 setText:itemArr[1]];
        [lbMsg2 setTextColor:COLOR9];
        [lbMsg2 setTextAlignment:NSTextAlignmentCenter];
        [lbMsg2 setFont:FONT12];
        [tView addSubview:lbMsg2];
        
        //创建“分割线”
        if(i<titleNum-1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(tWidth-0.5, 10, 0.5, 30)];
            [lineView setBackgroundColor:LINE_COLOR];
            [tView addSubview:lineView];
        }
        
    }
    
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
