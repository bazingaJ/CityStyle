//
//  CGFindScrollViewCell.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/15.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGFindScrollViewCell : UITableViewCell<UIScrollViewDelegate>

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hardwareArr:(NSMutableArray *)hardwareArr;

@property (nonatomic, strong) UIView *backView1;
@property (nonatomic, strong) UIView *backView2;
@property (nonatomic, strong) UIPageControl *pageControl;

@end
