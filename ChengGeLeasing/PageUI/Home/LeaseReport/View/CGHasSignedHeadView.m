//
//  CGHasSignedHeadView.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGHasSignedHeadView.h"
#import "CGStatisticsListModel.h"


@implementation CGHasSignedHeadView

//懒加载
-(NSArray *)colorArr
{
    if (!_colorArr)
    {
        _colorArr =@[kRGB(42, 171, 136),
                     kRGB(91, 200, 168),
                     kRGB(135, 222, 197),
                     kRGB(142, 229, 255),
                     kRGB(113, 220, 254),
                     kRGB(99, 206, 239),
                     kRGB(63, 183, 232),
                     kRGB(85, 131, 201),
                     kRGB(48, 68, 196),
                     kRGB(60, 36, 170)];
    }
    return _colorArr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setDataArr:(NSMutableArray *)dataArr
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    _dataArr = dataArr;
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    float width =SCREEN_WIDTH/3;
    
    //创建"右侧数据"
    
    [self.temColoarr removeAllObjects];
    NSMutableArray *temDataArr = [NSMutableArray array];
    self.temColoarr= [NSMutableArray array];
    for (int i =0; i<self.dataArr.count; i++)
    {
        //获取字典
       CGStatisticsListModel *model = self.dataArr[i];
        //创建"颜色盒"
        UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(width*2, 15+i*(15+10), 15, 15)];
        lbMsg.layer.cornerRadius = 3;
        lbMsg.clipsToBounds = YES;
        lbMsg.backgroundColor =self.colorArr[i];
        [self addSubview:lbMsg];
        //创建"名称"Lab
        UILabel *lbMsg1 =[[UILabel alloc]initWithFrame:CGRectMake(width*2+20,15+i*(15+10),50, 15)];
        lbMsg1.text =model.name;
        lbMsg1.font =FONT12;
        lbMsg1.textColor =COLOR3;
        [self addSubview:lbMsg1];
        
        //创建"个数"
        UILabel *lbMsg2 =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -50, 15+i*(15+10), 40, 15)];
        lbMsg2.text = [NSString stringWithFormat:@"%@个",model.count];
        lbMsg2.textAlignment =NSTextAlignmentRight;
        lbMsg2.font =FONT12;
        lbMsg2.textColor =COLOR3;
        [self addSubview:lbMsg2];
        
        [temDataArr addObject:model.ratio];
    }
    
//    if (!temDataArr.count)
//    {
//        [temDataArr addObject:@"1"];
//    }
    
    //创建"仪表盘"
    [self drawPresentChart:temDataArr titles:nil];
}

-(void)drawPresentChart:(NSArray*)valueDataArr titles:(NSArray*)titleArr
{
    float width =SCREEN_WIDTH/3;
    JHRingChart *ring = [[JHRingChart alloc] initWithFrame:CGRectMake(0, 0, width *2, width *2)];
    ring.backgroundColor = [UIColor clearColor];
    NSInteger num =self.dataArr.count;
    if (num<1)
    {
        num = 0;
    }
    ring.totalNum = [NSString stringWithFormat:@"%ld",num];
    ring.tIndex = 0;
    ring.valueDataArr = [valueDataArr copy];
    ring.ringWidth = 35.0;
    ring.fillColorArray = self.colorArr;
    [ring showAnimation];
    [self addSubview:ring];
    self.ringChart = ring;
    
}

@end
