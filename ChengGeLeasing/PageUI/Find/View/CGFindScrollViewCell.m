//
//  CGFindScrollViewCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/15.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGFindScrollViewCell.h"

@implementation CGFindScrollViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hardwareArr:(NSMutableArray *)hardwareArr {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        //分页数
        CGFloat cellH = 0;
        NSInteger pageNum = [hardwareArr count];
        if(pageNum>0) {
            NSArray *dataArr = hardwareArr[0];
            cellH = 45*dataArr.count+30;
        }
        
        //创建“滚动层”
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, cellH)];
        scrollView.contentSize = CGSizeMake(pageNum*SCREEN_WIDTH, cellH);
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        
        for (int i=0; i<pageNum; i++) {
            
            //创建“背景层”
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, cellH-30)];
            [backView setBackgroundColor:[UIColor whiteColor]];
            [scrollView addSubview:backView];
            
            //内部数组
            NSMutableArray *titleArr = hardwareArr[i];
            
            //创建“标题”
            for (int k=0; k<[titleArr count]; k++) {
                
                NSArray *itemArr = [titleArr objectAtIndex:k];
                
                //创建“标题”
                UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10+45*k, 150, 25)];
                [lbMsg setText:itemArr[1]];
                [lbMsg setTextColor:COLOR3];
                [lbMsg setTextAlignment:NSTextAlignmentLeft];
                [lbMsg setFont:FONT15];
                [backView addSubview:lbMsg];
                
                //创建“内容”
                UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(160, 10+45*k, backView.frame.size.width-170, 25)];
                [lbMsg2 setText:itemArr[2]];
                [lbMsg2 setTextColor:COLOR3];
                [lbMsg2 setTextAlignment:NSTextAlignmentRight];
                [lbMsg2 setFont:FONT15];
                [backView addSubview:lbMsg2];
                
                //创建“分割线”
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45*k-0.5, backView.frame.size.width, 0.5)];
                [lineView setBackgroundColor:LINE_COLOR];
                [backView addSubview:lineView];
                
            }
            
        }
        
        //创建“分页”
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, cellH-30, self.bounds.size.width, 30)];
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = pageNum;
        [self.pageControl setCurrentPageIndicatorTintColor:NAV_COLOR];
        [self.pageControl setPageIndicatorTintColor:[UIColor grayColor]];
        [self addSubview:self.pageControl];
    
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    self.pageControl.currentPage = page;
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
