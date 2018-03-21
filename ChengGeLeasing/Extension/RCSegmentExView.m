//
//  RCSegmentExView.m
//  ProjectOne
//
//  Created by RongCheng on 16/3/31.
//  Copyright © 2016年 JiYue.com. All rights reserved.
//

#import "RCSegmentExView.h"

@implementation RCSegmentExView

- (instancetype)initWithFrame:(CGRect)frame  controllers:(NSArray*)controllers titleArray:(NSArray*)titleArray ParentController:(UIViewController*)parentC with:(NSInteger)index
{
    if ( self=[super initWithFrame:frame  ])
    {
        self.controllers=controllers;
        self.nameArray=titleArray;
        
        self.segmentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 45)];
        self.segmentView.tag=50;
        self.segmentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.segmentView];
        
        self.segmentScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 45, frame.size.width, frame.size.height -45)];
        self.segmentScrollV.contentSize=CGSizeMake(frame.size.width*self.controllers.count, 0);
        self.segmentScrollV.delegate=self;
        self.segmentScrollV.showsHorizontalScrollIndicator=NO;
        self.segmentScrollV.pagingEnabled=YES;
        self.segmentScrollV.bounces=NO;
        [self addSubview:self.segmentScrollV];
        
        for (int i=0;i<self.controllers.count;i++)
        {
            UIViewController * contr=self.controllers[i];
            [self.segmentScrollV addSubview:contr.view];
            contr.view.frame=CGRectMake(i*frame.size.width, 0, frame.size.width,frame.size.height);
            [parentC addChildViewController:contr];
            [contr didMoveToParentViewController:parentC];
        }
        for (int i=0;i<self.controllers.count;i++)
        {
            UIButton * btn=[ UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(i*(frame.size.width/self.controllers.count), 0, frame.size.width/self.controllers.count, 45);
            btn.tag=i;
            [btn setTitle:self.nameArray[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:COLOR9 forState:(UIControlStateNormal)];
            [btn setTitleColor:MAIN_COLOR forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.titleLabel.font = FONT15;
            if (i==index)
            {
                btn.selected=YES ;
                self.seleBtn=btn;
                btn.titleLabel.font = FONT15;
                [self Click:btn];
            } else {
                btn.selected=NO;
            }
            
            [self.segmentView addSubview:btn];
        }
        self.line=[[UILabel alloc] initWithFrame:CGRectMake(index *frame.size.width/self.controllers.count,43, frame.size.width/self.controllers.count, 2)];
        self.line.backgroundColor = ORANGE_COLOR;
        self.line.tag=100;
        [self.segmentView addSubview:self.line];
        
        self.down=[[UILabel alloc]initWithFrame:CGRectMake(0, 44.5, frame.size.width, 0.5)];
        //self.down.backgroundColor=[UIColor grayColor];
        [self.segmentView addSubview:self.down];
}
    
    
    return self;
}
- (void)Click:(UIButton*)sender
{
    self.seleBtn.titleLabel.font = FONT15;
    self.seleBtn.selected=NO;
    self.seleBtn=sender;
    self.seleBtn.selected=YES;
    self.seleBtn.titleLabel.font = FONT15;
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)* (sender.tag);
        self.line.center=frame;
    }];
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag)*self.frame.size.width, 0) animated:YES ];
    if(self.callBack) {
        self.callBack(sender.tag);
    }
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"SelectVC" object:sender userInfo:nil];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)*(self.segmentScrollV.contentOffset.x/self.frame.size.width);
        self.line.center=frame;
    }];
    UIButton * btn=(UIButton*)[self.segmentView viewWithTag:(self.segmentScrollV.contentOffset.x/self.frame.size.width)];
    self.seleBtn.selected=NO;
    self.seleBtn=btn;
    self.seleBtn.selected=YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
