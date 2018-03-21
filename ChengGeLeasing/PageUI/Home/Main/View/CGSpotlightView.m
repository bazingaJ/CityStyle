//
//  CGSpotlightView.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/25.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGSpotlightView.h"
@interface CGSpotlightView()
{
    NSInteger _page;
}
@end

@implementation CGSpotlightView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    }
    return self;
}

-(void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    _page =0;
    NSArray *pagArr = [dataArr objectAtIndex:_page];
    
    [self setUpChildView:pagArr];
    
}

-(void)btnClick:(UIButton *)sender
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    _page ++;
    if (_page >=self.dataArr.count || sender.tag == 100)
    {
        [self removeFromSuperview];
        return;
    }
    
    NSArray *pagArr = [self.dataArr objectAtIndex:_page];
    
    [self setUpChildView:pagArr];
}

-(void)setUpChildView:(NSArray *)pagArr
{
    for (int i =0; i<pagArr.count; i++)
    {
        NSDictionary *dataDic = pagArr[i];
        if ([dataDic[@"type"] isEqualToString:@"1"])
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectFromString(dataDic[@"frame"])];
            imageView.image =[UIImage imageNamed:dataDic[@"pic"]];
            [self addSubview:imageView];
        }
        else if ([dataDic[@"type"] isEqualToString:@"2"] ||[dataDic[@"type"] isEqualToString:@"3"])
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame =CGRectFromString(dataDic[@"frame"]);
            [btn setImage:[UIImage imageNamed:dataDic[@"pic"]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside
             ];
            
            if ([dataDic[@"type"] isEqualToString:@"2"])
            {
                btn.tag =100;
            }
            [self addSubview:btn];
        }
    }
}
@end
