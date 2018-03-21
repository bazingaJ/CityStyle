//
//  CGRegionalDistributionHeadView.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGRegionalDistributionHeadView.h"

@implementation CGRegionalDistributionHeadView

-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    [self setUpView];
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpView];
    }
    return self;
}

-(void)setUpView
{
    if (!_dataDic) return;

    //创建"铺位"
    UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 10, 20)];
    lbMsg.font =FONT12;
    lbMsg.textColor = COLOR3;
    lbMsg.text = [NSString stringWithFormat:@"铺位:%@个",_dataDic[@"total_num"]];
    [lbMsg sizeToFit];
    [self addSubview:lbMsg];
    
    //创建"已签约"
    UILabel *lbMsg1 =[[UILabel alloc]initWithFrame:CGRectMake(lbMsg.right+15, 15, 10, 20)];
    lbMsg1.font = FONT12;
    lbMsg1.textColor = COLOR3;
    lbMsg1.text = [NSString stringWithFormat:@"已签约:%@个",_dataDic[@"sign_num"]];
    [lbMsg1 sizeToFit];
    [self addSubview:lbMsg1];
    
    //创建"有意向"
    UILabel *lbMsg2 = [[UILabel alloc]initWithFrame:CGRectMake(lbMsg1.right +15, 15, 10, 20)];
    lbMsg2.font =FONT12;
    lbMsg2.textColor = COLOR3;
    lbMsg2.text = [NSString stringWithFormat:@"有意向:%@个",_dataDic[@"intent_num"]];
    [lbMsg2 sizeToFit];
    [self addSubview:lbMsg2];
    
    //创建"饼状图"
    NSString * oneStr;
    NSString * twoStr;
    NSString * threeStr;
    
    if ([_dataDic[@"sign_num"] isEqualToString:@"0"] &&[_dataDic[@"intent_num"] isEqualToString:@"0"] &&[_dataDic[@"no_intent_num"] isEqualToString:@"0"])
    {
        oneStr = @"1";
        twoStr = @"0";
        threeStr = @"0";
    }
    else
    {
        oneStr = _dataDic[@"sign_num"];
        twoStr = _dataDic[@"intent_num"];
        threeStr = _dataDic[@"no_intent_num"];
    }
    
    
    [self drawPresentChart:@[oneStr,twoStr,threeStr] titles:nil];
    
    //创建"右侧颜色盒"
    for (int i =0; i<3; i++)
    {
        //创建"颜色盒"
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, (self.height/2-30)+i*(30), 15, 15)];
        view.layer.cornerRadius = 5;
        view.clipsToBounds = YES;
        view.backgroundColor =@[UIColorFromRGBWith16HEX(0xB9B9B9),UIColorFromRGBWith16HEX(0x779AD6),UIColorFromRGBWith16HEX(0xBBCDE9)][i];
        [self addSubview:view];
        
        //创建"标题"
        UILabel *lbMsg1 =[[UILabel alloc]initWithFrame:CGRectMake(view.right+5, view.top, 60, 15)];
        lbMsg1.textColor = UIColorFromRGBWith16HEX(0x779AD6);
        lbMsg1.font = FONT15;
        lbMsg1.text = @[@"已签约",@"有意向",@"无意向"][i];
        [self addSubview:lbMsg1];
    }
}

-(void)drawPresentChart:(NSArray*)valueDataArr titles:(NSArray*)titleArr
{
    float width =SCREEN_WIDTH/3;
    JHRingChart *ring = [[JHRingChart alloc] initWithFrame:CGRectMake(0,40, width *2, width *2)];
    ring.backgroundColor = [UIColor clearColor];
     ring.totalNum = _dataDic[@"total_num"];
    ring.tIndex = 0;
    ring.valueDataArr = [valueDataArr copy];
    ring.ringWidth = 35.0;
    ring.fillColorArray = @[UIColorFromRGBWith16HEX(0xB9B9B9),UIColorFromRGBWith16HEX(0x779AD6),UIColorFromRGBWith16HEX(0xBBCDE9)];
    [ring showAnimation];
    [self addSubview:ring];
    self.ringChart = ring;
}
@end
