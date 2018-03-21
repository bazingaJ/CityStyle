//
//  CGCustomerFunnelHeadView.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGCustomerFunnelHeadView.h"
#import "CGFunneStatisticsModel.h"

#define selectedColor kRGB(217, 217, 217)

@implementation CGCustomerFunnelHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame])
    {
        [self setUpView];
    }
    return self;
}

-(void)setUpView
{

    NSArray *lineColorArr = @[UIColorFromRGBWith16HEX(0x6797D3),
                              UIColorFromRGBWith16HEX(0x4AC3ED),
                              UIColorFromRGBWith16HEX(0x73D7F3),
                              UIColorFromRGBWith16HEX(0x6ADDFE),
                              UIColorFromRGBWith16HEX(0x9DEAFF),
                              UIColorFromRGBWith16HEX(0x9DEAFF),
                              UIColorFromRGBWith16HEX(0x6AD0B7)];
    
    NSArray *titleArr = @[@"储备/暂无意向",@"初步接洽",@"现场考察",@"谈合作方案",@"谈合同",@"已签约",@"已收款"];
    NSArray *numArr = @[@"0%",@"15%",@"25%",@"40%",@"60%",@"90%",@"100%"];
    for (int i=0; i<7; i++)
    {
        
        //创建"储备/暂无意向"
        UIButton *btnFunc =[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-30)/3, 10+i*26, SCREEN_WIDTH - (SCREEN_WIDTH-30)/3, 26)];
        [btnFunc setTitle:titleArr[i] forState:UIControlStateNormal];
        [btnFunc setTitleColor:COLOR9 forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT13];
        [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        btnFunc.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [btnFunc setTag:100+i];
        [self addSubview:btnFunc];
        //创建"漏斗"
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 10+i*26, ((SCREEN_WIDTH-30)/3)*2, 26)];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.image =[UIImage imageNamed:[NSString stringWithFormat:@"home_funnel_%d",i]];
        [self addSubview:imageView];
        
        //创建"lbMsg"
        UILabel *lbMsg = [[UILabel alloc]initWithFrame:imageView.frame];
        lbMsg.textColor = COLOR3;
        lbMsg.font = FONT12;
        lbMsg.tag = 10+i;
        lbMsg.backgroundColor = [UIColor clearColor];
        lbMsg.textAlignment  = NSTextAlignmentCenter;
        [self addSubview:lbMsg];
        
        //创建"线"
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(imageView.width/2, 36+(i*26)-.5, SCREEN_WIDTH, .5)];
        lineView.backgroundColor =lineColorArr[i];
        [self addSubview:lineView];
        
        //创建"0%"
        NSString *tagStr = numArr[i];
        UILabel *lbMsg2 =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100-50,10+i*26, 40, 26)];
        lbMsg2.font = FONT13;
        lbMsg2.text = tagStr;
        lbMsg2.textAlignment = NSTextAlignmentRight;
        lbMsg2.textColor = COLOR9;
        [lbMsg2 setTag:100+i];
        [self addSubview:lbMsg2];
        
        __block UIButton *tempBtn = btnFunc;
        [btnFunc addTouch:^{
            NSLog(@"点击");
            
            for (UIView *view in self.subviews) {
                if([view isKindOfClass:[UIButton class]]) {
                    UIButton *tempBtn = (UIButton *)view;
                    if(tempBtn.tag<100) continue;
                    
                    //恢复默认颜色
                    [tempBtn setTitleColor:COLOR9 forState:UIControlStateNormal];
                    [tempBtn setBackgroundColor:WHITE_COLOR];
                    [tempBtn setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
                }
                if([view isKindOfClass:[UILabel class]]) {
                    UILabel *lbMsg = (UILabel *)view;
                    if(lbMsg.tag<100) continue;
                    
                    //恢复默认颜色
                    [lbMsg setTextColor:COLOR9];
                }
                
            }
            
            //设置选中颜色
            [tempBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [tempBtn setBackgroundImage:[UIImage imageNamed:@"loudou"] forState:UIControlStateNormal];
            [lbMsg2 setTextColor:MAIN_COLOR];
            
            //委托代理
            if([self.delegate respondsToSelector:@selector(CGCustomerFunnelHeadViewClick:)]) {
                [self.delegate CGCustomerFunnelHeadViewClick:tagStr];
            }
            
        }];
        
        
    }
    
}

-(void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    for (int i=0; i<dataArr.count; i++)
    {
        CGFunneStatisticsModel *model = [dataArr objectAtIndex:i];
        
        UILabel *lbMsg =[self viewWithTag:10+i];
        lbMsg.text = model.count;
    }
}
@end
