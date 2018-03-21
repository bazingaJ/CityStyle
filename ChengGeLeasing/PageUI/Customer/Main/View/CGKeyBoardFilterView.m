//
//  CGKeyBoardFilterView.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGKeyBoardFilterView.h"
@interface CGKeyBoardFilterView ()

@property (nonatomic, strong) UIButton *selectedBtn;

@end
@implementation CGKeyBoardFilterView

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
    
    float spacing = (SCREEN_WIDTH-330)/9;
    
   NSArray*AZArr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"0-9",@"U",@"V",@"W",@"S",@"W",@"Z",@"ALL"];
    UIButton *numBtn20;
    for (int i =0; i<AZArr.count; i++)
    {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15+i%10*(30+spacing), 15+i/10*(30+spacing), 30, 30);
        [btn setTitle:AZArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:COLOR3 forState:UIControlStateNormal];
        [btn setTitleColor:WHITE_COLOR forState:UIControlStateSelected];
        btn.titleLabel.font = FONT16;
        btn.backgroundColor = WHITE_COLOR;
        btn.layer.cornerRadius =4;
        btn.layer.borderColor =UIColorFromRGBWith16HEX(0xBEC2C8).CGColor;
        btn.layer.borderWidth =.5;
        btn.clipsToBounds = YES;
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i >19)
        {
            if (i==20)
            {
                btn.width =30+30+spacing;
                numBtn20 = btn;
            }
            else
            {
                btn.x = numBtn20.right+spacing+((i%10)-1)*(30+spacing);
            }
            if (i==27)
            {
                btn.width =30+30+spacing;
                _selectedBtn = btn;
                btn.selected = YES;
                btn.backgroundColor = UIColorFromRGBWith16HEX(0x789BD4);
            }
        }
        [self addSubview:btn];
    }
    //创建"线"
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 129.5, SCREEN_WIDTH, .5)];
    lineView.backgroundColor = LINE_COLOR;
    [self addSubview:lineView];
    
}

-(void)btnClick:(UIButton *)sender
{
    if (_selectedBtn == sender) return;
    sender.selected =YES;
    _selectedBtn.selected =NO;
    [_selectedBtn setBackgroundColor:WHITE_COLOR];
    [sender setBackgroundColor:UIColorFromRGBWith16HEX(0x789BD4)];
    _selectedBtn = sender;
    
    if (self.callBack)
    {
        NSString *simple_keywords;
        
        if ([sender.titleLabel.text isEqualToString:@"ALL"])
        {
            simple_keywords = @"all";
        }
        else if ([sender.titleLabel.text isEqualToString:@"0-9"])
        {
            simple_keywords = @"num";
        }
        else
        {
            simple_keywords = sender.titleLabel.text;
        }
        
        self.callBack(simple_keywords);
    }
}

@end
