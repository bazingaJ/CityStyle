//
//  CGOperationDynamicView.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGOperationDynamicView.h"
@implementation CGOperationDynamicView

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
    CGFloat width = SCREEN_WIDTH/3;
    CGFloat height = 220;
    
    //创建"线"
    UIView *lineView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    lineView.backgroundColor = kRGB(245, 245, 245);
    [self addSubview:lineView];
    
    
    NSArray *titleArr = @[@"空置",@"稳营",@"预动",@"退铺"];
    //创建"已租"待租有意"无意"
    for (int i =0; i<titleArr.count; i++)
    {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(width*2, 35+i*50, width, 50)];
        backView.backgroundColor = [UIColor clearColor];
        [self addSubview:backView];
        
        //创建"颜色盒"
        UILabel *lbMsg1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        lbMsg1.layer.cornerRadius = 3;
        lbMsg1.clipsToBounds = YES;
        [backView addSubview:lbMsg1];
        
        //创建标题如"空置""
        UILabel *lbMsg2 =[[UILabel alloc]init];
        lbMsg2.text = titleArr[i];
        lbMsg2.font = FONT14;
        lbMsg2.textColor = UIColorFromRGBWith16HEX(0x7498D5);
        CGSize titleSize = [lbMsg2  sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        lbMsg2.frame = CGRectMake(CGRectGetMaxX(lbMsg1.frame)+5, 0, titleSize.width, 15);
        [backView addSubview:lbMsg2];
        
        //创建"平方米"
        UILabel *lbMsg4 = [[UILabel alloc]initWithFrame:CGRectMake(lbMsg2.left, lbMsg2.bottom+5, 150, 15)];
        lbMsg4.font = FONT14;
        lbMsg4.textColor = COLOR9;
        [backView addSubview:lbMsg4];
        lbMsg1.tag = i+5;
        lbMsg4.tag = i+20;
    }
    
    //创建"线"
    UILabel *lineMsg2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 10)];
    lineMsg2.backgroundColor = kRGB(245, 245, 245);
    [self addSubview:lineMsg2];
}

-(void)setModel:(CGOperationDynamicModel *)model
{
    _model = model;
    if (!_model) return;
    CGFloat width = SCREEN_WIDTH/3;
    // 数据源;
    NSString *oneStr;
    NSString *twoStr;
    NSString *threeStr;
    NSString *fourStr;
    
    if ([_model.empty[@"num"] isEqualToString:@"0"]
        &&[_model.profit[@"num"] isEqualToString:@"0"]
        &&[_model.togo[@"num"] isEqualToString:@"0"]
        &&[_model.out[@"num"] isEqualToString:@"0"])
    {
        oneStr = @"0";
        twoStr = @"1";
        threeStr = @"0";
        fourStr = @"0";
    }
    else
    {
        oneStr = _model.empty[@"num"];
        twoStr = _model.profit[@"num"];
        threeStr = _model.togo[@"num"];
        fourStr = _model.out[@"num"];
    }
    
    [self drawPresentChart:@[oneStr,twoStr,threeStr,fourStr] titles:nil];
    
    for (int i =0; i<4; i++)
    {
        UILabel *lbMsg1 = [self viewWithTag:5+i];
        UILabel *lbMsg4 = [self viewWithTag:20+i];
        switch (i)
        {
            case 0:
            {
                //空置
                lbMsg1.backgroundColor = UIColorFromRGBWith16HEX(0xBCCDE8);
                lbMsg4.text = [NSString stringWithFormat:@"%@㎡",_model.empty[@"area"]];
            }
                break;
            case 1:
            {
                //稳营
                lbMsg1.backgroundColor = UIColorFromRGBWith16HEX(0xB9B9B9);
                lbMsg4.text = [NSString stringWithFormat:@"%@㎡",_model.profit[@"area"]];
            }
                break;
                
            case 2:
            {
                //预动
                lbMsg1.backgroundColor = UIColorFromRGBWith16HEX(0xF9BE01);
                lbMsg4.text = [NSString stringWithFormat:@"%@㎡",_model.togo[@"area"]];
            }
                break;
            case 3:
            {
                //退铺
                lbMsg1.backgroundColor = UIColorFromRGBWith16HEX(0xFF0000);
                lbMsg4.text = [NSString stringWithFormat:@"%@㎡",_model.out[@"area"]];
            }
                break;
                
            default:
                break;
        }
    }
}

-(void)drawPresentChart:(NSArray*)valueDataArr titles:(NSArray*)titleArr
{
    float width =SCREEN_WIDTH/3;
    JHRingChart *ring = [[JHRingChart alloc] initWithFrame:CGRectMake(0, 0, width *2, width *2)];
    /*        background color         */
//    if ([self.model.empty_pre isEqualToString:@"0.00"] &&[self.model.calm_pre isEqualToString:@"0.00"] &&[self.model.ready_pre isEqualToString:@"0.00"]&&[self.model.re_pre isEqualToString:@"0.00"])
//    {
    ring.totalNum = _model.total;
//    }
    ring.tIndex =1;
    ring.backgroundColor = [UIColor clearColor];
    /*        Data source array, only the incoming value, the corresponding ratio will be automatically calculated         */
    ring.valueDataArr = [valueDataArr copy];
    /*         Width of ring graph        */
    ring.ringWidth = 35.0;
    /*        Fill color for each section of the ring diagram         */
    ring.fillColorArray = @[UIColorFromRGBWith16HEX(0xBBCDE9),UIColorFromRGBWith16HEX(0xA7A7A7),UIColorFromRGBWith16HEX(0xF9BE01),UIColorFromRGBWith16HEX(0xFF0000)];
    /*        Start animation             */
    [ring showAnimation];
    [self addSubview:ring];
    self.ringChart = ring;
    
}
@end
