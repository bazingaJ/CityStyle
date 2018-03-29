//
//  CGDropDownMenu.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/22.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGDropDownMenu.h"
#import "CGFormatModel.h"
#import "CGTeamGroupModel.h"
#import "CGXiangmuModel.h"
#import "CGTeamAreaModel.h"

@interface CGDropDownMenuItem : UIButton

@end

@implementation CGDropDownMenuItem

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //设置图片
        self.imageView.image = [UIImage imageNamed:@"menu_icon_down"];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.imageView.layer.transform = CATransform3DMakeRotation(selected ? M_PI : 0, 0, 0, 1);
    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.centerX = self.width * 0.5;
    self.imageView.left = self.titleLabel.right + 5;
    
}

@end

@interface CGDropDownMenu ()

/**
 *  项目ID
 */
@property (nonatomic, strong) NSString *proId;

@end

@interface CGDropDownMenu ()<UITableViewDelegate, UITableViewDataSource> {
    NSInteger tableNum;
    
    CGFormatModel *formatModel;
    CGFormatModel *formatModel2;
    CGFormatModel *formatModel3;
}

@property (nonatomic, strong) CGDropDownMenuItem *currentItem;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *dataArr1;
@property (nonatomic, strong) NSMutableArray *dataArr2;
@property (nonatomic, strong) UIView *popView;
@property (nonatomic, assign) CGFloat tableWidth;

//A-Z
@property (nonatomic, strong) UIView *pinyinView;
//意向度
@property (nonatomic, strong) UIView *intentionView;
//业态(九宫格)
@property (nonatomic, strong) UIView *formatView;
//项目(九宫格)
@property (nonatomic, strong) UIView *xiangmuView;
//全部时间
@property (nonatomic, strong) UIView *timeView;
//意向区域
@property (nonatomic, strong) UIView *intentionAreaView;
//意向区域
@property (nonatomic, strong) UIView *signAreaView;

@end

@implementation CGDropDownMenu

/**
 *  意向区域
 */
- (NSMutableArray *)intentionAreaArr {
    if(!_intentionAreaArr) {
        _intentionAreaArr = [NSMutableArray array];
    }
    return _intentionAreaArr;
}

/**
 *  项目
 */
- (NSMutableArray *)xiangmuArr {
    if(!_xiangmuArr) {
        _xiangmuArr = [NSMutableArray array];
    }
    return _xiangmuArr;
}

/**
 *  团队成员
 */
- (NSMutableArray *)teamMemberArr {
    if(!_teamMemberArr) {
        _teamMemberArr = [NSMutableArray array];
    }
    return _teamMemberArr;
}

/**
 *  团队分组
 */
- (NSMutableArray *)teamArr {
    if(!_teamArr) {
        _teamArr = [NSMutableArray array];
    }
    return _teamArr;
}

/**
 *  业态
 */
- (NSMutableArray *)dataArr {
    if(!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

/**
 *  业态1
 */
- (NSMutableArray *)dataArr1 {
    if(!_dataArr1) {
        _dataArr1 = [NSMutableArray array];
    }
    return _dataArr1;
}

/**
 *  业态2
 */
- (NSMutableArray *)dataArr2 {
    if(!_dataArr2) {
        _dataArr2 = [NSMutableArray array];
    }
    return _dataArr2;
}

/**
 *  业态
 */
- (NSMutableArray *)formatArr {
    if(!_formatArr) {
        _formatArr = [NSMutableArray array];
    }
    return _formatArr;
}

/**
 *  类型
 */
- (NSMutableArray *)typeArr {
    if(!_typeArr) {
        _typeArr = [NSMutableArray array];
        [_typeArr addObject:@[@"0",@"全部"]];
        [_typeArr addObject:@[@"2",@"非连锁"]];
        [_typeArr addObject:@[@"1",@"连锁"]];
    }
    return _typeArr;
}

/**
 *  背景层视图
 */
- (UIView *)popView {
    if(!_popView) {
        WS(weakSelf);
         CGFloat y = [self convertPoint:self.origin toView:kWindow].y;
        _popView = [[UIView alloc] initWithFrame:CGRectMake(0, y+self.height-self.top, SCREEN_WIDTH, SCREEN_HEIGHT-y-HOME_INDICATOR_HEIGHT-self.height+self.top)];
        _popView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [_popView setHidden:YES];
        [_popView addTouch:^{
            NSLog(@"点击了背景层");
            
            [weakSelf dismiss];
            
        }];
        [kWindow addSubview:_popView];
    }
    return _popView;
}

/**
 *  A-Z
 */
- (UIView *)pinyinView {
    if(!_pinyinView) {
        _pinyinView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        _pinyinView.backgroundColor = [UIColor whiteColor];
        
        //创建“数据源”
        NSMutableArray *titleArr = [NSMutableArray array];
        [titleArr addObject:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J"]];
        [titleArr addObject:@[@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T"]];
        [titleArr addObject:@[@"ALL",@"U",@"V",@"W",@"X",@"Y",@"Z",@"0-9"]];
        CGFloat tWidth = (self.frame.size.width-20)/10;
        for (int i=0; i<[titleArr count]; i++) {
            NSArray *itemArr = [titleArr objectAtIndex:i];
            for (int k=0; k<[itemArr count]; k++) {
                NSString *letterStr = itemArr[k];
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10+tWidth*k, 10+40*i, tWidth, 40)];
                [btnFunc setTitle:letterStr forState:UIControlStateNormal];
                [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
                [btnFunc.titleLabel setFont:FONT16];
                [btnFunc setSelected:NO];
                [btnFunc addTouch:^{
                    NSLog(@"您点击了字母：%@",letterStr);
                    btnFunc.selected = !btnFunc.isSelected;
                    if([letterStr isEqualToString:@"ALL"]) {
                        [self.currentItem setTitle:@"A-Z" forState:UIControlStateNormal];
                    }else{
                        [self.currentItem setTitle:letterStr forState:UIControlStateNormal];
                    }
                    if(self.callAZBack) {
                        self.callAZBack(letterStr);
                        [self dismiss];
                    }
                    
                }];
                [_pinyinView addSubview:btnFunc];
            }
        }
    }
    return _pinyinView;
}

/**
 *  意向度
 */
- (UIView *)intentionView {
    if(!_intentionView) {
        _intentionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [_intentionView setBackgroundColor:[UIColor whiteColor]];
        
        //数据源
        NSMutableArray *titleArr = [NSMutableArray array];
        [titleArr addObject:@[@"全部",@"0%",@"15%",@"25%"]];
        [titleArr addObject:@[@"40%",@"60%",@"90%",@"100%"]];
        CGFloat tWidth = (self.frame.size.width-10-50)/4;
        for (int i=0; i<[titleArr count]; i++) {
            NSArray *itemArr = [titleArr objectAtIndex:i];
            for (int k=0; k<[itemArr count]; k++) {
                NSString *titleStr = itemArr[k];
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(5+(tWidth+10)*k, 15+45*i, tWidth, 30)];
                [btnFunc setTitle:titleStr forState:UIControlStateNormal];
                [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
                [btnFunc.titleLabel setFont:FONT14];
                [btnFunc.layer setCornerRadius:4.0];
                [btnFunc.layer setBorderWidth:1];
                [btnFunc.layer setBorderColor:LINE_COLOR.CGColor];
                [btnFunc setBackgroundColor:[UIColor whiteColor]];
                [btnFunc addTouch:^{
                    NSLog(@"点击了意向度");
                    
                    for (UIView *view in btnFunc.superview.subviews) {
                        if([view isKindOfClass:[UIButton class]]) {
                            UIButton *btn = (UIButton *)view;
                            [btn setBackgroundColor:[UIColor whiteColor]];
                            [btn setTitleColor:COLOR3 forState:UIControlStateNormal];
                            [btn.layer setBorderColor:LINE_COLOR.CGColor];
                        }
                    }
                    [btnFunc setBackgroundColor:MAIN_COLOR];
                    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [btnFunc.layer setBorderColor:[UIColor whiteColor].CGColor];
                    
                    btnFunc.selected = !btnFunc.isSelected;
                    if([titleStr isEqualToString:@"全部"]) {
                        [self.currentItem setTitle:@"意向度" forState:UIControlStateNormal];
                    }else{
                        [self.currentItem setTitle:titleStr forState:UIControlStateNormal];
                    }
                    
                    NSString *intentionStr = @"";
                    if([titleStr isEqualToString:@"全部"]) {
                        intentionStr = @"all";
                    }else {
                        intentionStr = [titleStr stringByReplacingOccurrencesOfString:@"%" withString:@""];
                    }
                    
                    if(self.callIntentionBack) {
                        self.callIntentionBack(intentionStr);
                        [self dismiss];
                    }
                    
                }];
                [_intentionView addSubview:btnFunc];
            }
        }
        
    }
    return _intentionView;
}

- (UIView *)formatView {
    if(!_formatView) {
        _formatView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [_formatView setBackgroundColor:[UIColor whiteColor]];
    }
    
    //清除所有视图
    for (UIView *view in _formatView.subviews) {
        [view removeFromSuperview];
    }
    
    NSInteger imgNum = [self.formatArr count];
    NSInteger rowNum = 0;
    if(imgNum>0) {
        rowNum = imgNum/4;
        NSInteger colNum = imgNum%4;
        if(colNum>0) {
            rowNum += 1;
        }
    }
    CGFloat tWidth = (self.frame.size.width-10-50)/4;
    for (int i=0; i<rowNum; i++) {
        for (int k=0; k<4; k++) {
            NSInteger tIndex = 4*i+k;
            if(tIndex>[self.formatArr count]-1) continue;
            
            CGFormatModel *model = [self.formatArr objectAtIndex:tIndex];
            
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(5+(tWidth+10)*k, 15+45*i, tWidth, 30)];
            [btnFunc setTitle:model.name forState:UIControlStateNormal];
            [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT14];
            [btnFunc.layer setCornerRadius:4.0];
            [btnFunc.layer setBorderWidth:1];
            [btnFunc.layer setBorderColor:LINE_COLOR.CGColor];
            [btnFunc addTouch:^{
                NSLog(@"点击业态");
                for (UIView *view in btnFunc.superview.subviews) {
                    if([view isKindOfClass:[UIButton class]]) {
                        UIButton *btn = (UIButton *)view;
                        [btn setBackgroundColor:[UIColor whiteColor]];
                        [btn setTitleColor:COLOR3 forState:UIControlStateNormal];
                        [btn.layer setBorderColor:LINE_COLOR.CGColor];
                    }
                }
                [btnFunc setBackgroundColor:MAIN_COLOR];
                [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnFunc.layer setBorderColor:[UIColor whiteColor].CGColor];
                
                btnFunc.selected = !btnFunc.isSelected;
                if([model.name isEqualToString:@"全部"]) {
                    [self.currentItem setTitle:@"业态" forState:UIControlStateNormal];
                }else{
                    [self.currentItem setTitle:model.name forState:UIControlStateNormal];
                }
                
                if(self.callFormatBack) {
                    self.callFormatBack(model.id,model.name);
                    [self dismiss];
                }
            }];
            [_formatView addSubview:btnFunc];
            
        }
    }
    
    return _formatView;
}

/**
 *  项目视图
 */
- (UIView *)xiangmuView {
    if(!_xiangmuView) {
        _xiangmuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [_xiangmuView setBackgroundColor:[UIColor whiteColor]];
    }
    
    //清除所有视图
    for (UIView *view in _xiangmuView.subviews) {
        [view removeFromSuperview];
    }
    
    NSInteger imgNum = [self.xiangmuArr count];
    NSInteger rowNum = 0;
    if(imgNum>0) {
        rowNum = imgNum/4;
        NSInteger colNum = imgNum%4;
        if(colNum>0) {
            rowNum += 1;
        }
    }
    CGFloat tWidth = (self.frame.size.width-10-50)/4;
    for (int i=0; i<rowNum; i++) {
        for (int k=0; k<4; k++) {
            NSInteger tIndex = 4*i+k;
            if(tIndex>[self.xiangmuArr count]-1) continue;
            
            CGXiangmuModel *model = [self.xiangmuArr objectAtIndex:tIndex];
            
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(5+(tWidth+10)*k, 15+45*i, tWidth, 30)];
            [btnFunc setTitle:model.pro_name forState:UIControlStateNormal];
            [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT14];
            [btnFunc.layer setCornerRadius:4.0];
            [btnFunc.layer setBorderWidth:1];
            [btnFunc.layer setBorderColor:LINE_COLOR.CGColor];
            [btnFunc addTouch:^{
                NSLog(@"点击业态");
                for (UIView *view in btnFunc.superview.subviews) {
                    if([view isKindOfClass:[UIButton class]]) {
                        UIButton *btn = (UIButton *)view;
                        [btn setBackgroundColor:[UIColor whiteColor]];
                        [btn setTitleColor:COLOR3 forState:UIControlStateNormal];
                        [btn.layer setBorderColor:LINE_COLOR.CGColor];
                    }
                }
                [btnFunc setBackgroundColor:MAIN_COLOR];
                [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnFunc.layer setBorderColor:[UIColor whiteColor].CGColor];
                
                btnFunc.selected = !btnFunc.isSelected;
                if([model.pro_name isEqualToString:@"全部"]) {
                    [self.currentItem setTitle:@"项目" forState:UIControlStateNormal];
                }else{
                    [self.currentItem setTitle:model.pro_name forState:UIControlStateNormal];
                }
                
                if(self.callTeamXiangmuBack) {
                    self.proId = model.pro_id;
                    self.callTeamXiangmuBack(model.pro_id,model.pro_name);
                    [self dismiss];
                }
            }];
            [_xiangmuView addSubview:btnFunc];
            
        }
    }
    
    return _xiangmuView;
}

/**
 *  全部时间
 */
- (UIView *)timeView {
    if(!_timeView) {
        _timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [_timeView setBackgroundColor:[UIColor whiteColor]];
    }
    
    //清除所有视图
    for (UIView *view in _timeView.subviews) {
        [view removeFromSuperview];
    }
    
    NSMutableArray *timeArr = [NSMutableArray array];
    [timeArr addObject:@[@"0",@"全部"]];
    [timeArr addObject:@[@"1",@"本周"]];
    [timeArr addObject:@[@"2",@"上周"]];
    [timeArr addObject:@[@"3",@"本月"]];
    [timeArr addObject:@[@"4",@"上月"]];
    [timeArr addObject:@[@"5",@"本季度"]];
    [timeArr addObject:@[@"6",@"上季度"]];
    
    NSInteger imgNum = [timeArr count];
    NSInteger rowNum = 0;
    if(imgNum>0) {
        rowNum = imgNum/4;
        NSInteger colNum = imgNum%4;
        if(colNum>0) {
            rowNum += 1;
        }
    }
    CGFloat tWidth = (self.frame.size.width-10-50)/4;
    for (int i=0; i<rowNum; i++) {
        for (int k=0; k<4; k++) {
            NSInteger tIndex = 4*i+k;
            if(tIndex>[timeArr count]-1) continue;
            
            NSArray *itemArr = [timeArr objectAtIndex:tIndex];
            
            
            NSString *timeStr = itemArr[1];
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(5+(tWidth+10)*k, 15+45*i, tWidth, 30)];
            [btnFunc setTitle:timeStr forState:UIControlStateNormal];
            [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT14];
            [btnFunc.layer setCornerRadius:4.0];
            [btnFunc.layer setBorderWidth:1];
            [btnFunc.layer setBorderColor:LINE_COLOR.CGColor];
            [btnFunc addTouch:^{
                NSLog(@"全部时间");
                for (UIView *view in btnFunc.superview.subviews) {
                    if([view isKindOfClass:[UIButton class]]) {
                        UIButton *btn = (UIButton *)view;
                        [btn setBackgroundColor:[UIColor whiteColor]];
                        [btn setTitleColor:COLOR3 forState:UIControlStateNormal];
                        [btn.layer setBorderColor:LINE_COLOR.CGColor];
                    }
                }
                [btnFunc setBackgroundColor:MAIN_COLOR];
                [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnFunc.layer setBorderColor:[UIColor whiteColor].CGColor];
                
                btnFunc.selected = !btnFunc.isSelected;
                if([timeStr isEqualToString:@"全部"]) {
                    [self.currentItem setTitle:@"全部时间" forState:UIControlStateNormal];
                }else{
                    [self.currentItem setTitle:timeStr forState:UIControlStateNormal];
                }
                
                if(self.callTimeBack) {
                    self.callTimeBack(itemArr[0], timeStr);
                    [self dismiss];
                }
            }];
            [_timeView addSubview:btnFunc];
            
        }
    }
    
    return _timeView;
}

/**
 *  意向区域
 */
- (UIView *)intentionAreaView {
    if(!_intentionAreaView) {
        _intentionAreaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [_intentionAreaView setBackgroundColor:[UIColor whiteColor]];
    }
    
    //清除所有视图
    for (UIView *view in _intentionAreaView.subviews) {
        [view removeFromSuperview];
    }
    
    NSInteger imgNum = [self.intentionAreaArr count];
    NSInteger rowNum = 0;
    if(imgNum>0) {
        rowNum = imgNum/4;
        NSInteger colNum = imgNum%4;
        if(colNum>0) {
            rowNum += 1;
        }
    }
    CGFloat tWidth = (self.frame.size.width-10-50)/4;
    for (int i=0; i<rowNum; i++) {
        for (int k=0; k<4; k++) {
            NSInteger tIndex = 4*i+k;
            if(tIndex>[self.intentionAreaArr count]-1) continue;
            
            CGTeamAreaModel *model = [self.intentionAreaArr objectAtIndex:tIndex];
            
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(5+(tWidth+10)*k, 15+45*i, tWidth, 30)];
            [btnFunc setTitle:model.name forState:UIControlStateNormal];
            [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT14];
            [btnFunc.layer setCornerRadius:4.0];
            [btnFunc.layer setBorderWidth:1];
            [btnFunc.layer setBorderColor:LINE_COLOR.CGColor];
            [btnFunc addTouch:^{
                NSLog(@"意向区域");
                for (UIView *view in btnFunc.superview.subviews) {
                    if([view isKindOfClass:[UIButton class]]) {
                        UIButton *btn = (UIButton *)view;
                        [btn setBackgroundColor:[UIColor whiteColor]];
                        [btn setTitleColor:COLOR3 forState:UIControlStateNormal];
                        [btn.layer setBorderColor:LINE_COLOR.CGColor];
                    }
                }
                [btnFunc setBackgroundColor:MAIN_COLOR];
                [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnFunc.layer setBorderColor:[UIColor whiteColor].CGColor];
                
                btnFunc.selected = !btnFunc.isSelected;
                if([model.name isEqualToString:@"全部"]) {
                    [self.currentItem setTitle:@"意向区域" forState:UIControlStateNormal];
                }else{
                    [self.currentItem setTitle:model.name forState:UIControlStateNormal];
                }
                
                if(self.callTeamAreaBack) {
                    self.callTeamAreaBack(model.id, model.name);
                    [self dismiss];
                }
            }];
            [_intentionAreaView addSubview:btnFunc];
            
        }
    }
    
    return _intentionAreaView;
}

/**
 *  签约面积
 */
- (UIView *)signAreaView {
    if(!_signAreaView) {
        _signAreaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [_signAreaView setBackgroundColor:[UIColor whiteColor]];
    }
    
    //清除所有视图
    for (UIView *view in _signAreaView.subviews) {
        [view removeFromSuperview];
    }
    
    NSMutableArray *signArr = [NSMutableArray array];
    [signArr addObject:@[@"1",@"按签约面积"]];
    [signArr addObject:@[@"2",@"按签约数量"]];
    [signArr addObject:@[@"3",@"全部客户数"]];
    [signArr addObject:@[@"4",@"25%客户数"]];
    [signArr addObject:@[@"5",@"40%客户数"]];
    [signArr addObject:@[@"6",@"60%客户数"]];
    
    NSInteger imgNum = [signArr count];
    NSInteger rowNum = 0;
    if(imgNum>0) {
        rowNum = imgNum/4;
        NSInteger colNum = imgNum%4;
        if(colNum>0) {
            rowNum += 1;
        }
    }
    CGFloat tWidth = (self.frame.size.width-10-50)/4;
    for (int i=0; i<rowNum; i++) {
        for (int k=0; k<4; k++) {
            NSInteger tIndex = 4*i+k;
            if(tIndex>[signArr count]-1) continue;
            
            NSArray *itemArr = [signArr objectAtIndex:tIndex];
            
            
            NSString *signStr = itemArr[1];
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(5+(tWidth+10)*k, 15+45*i, tWidth, 30)];
            [btnFunc setTitle:signStr forState:UIControlStateNormal];
            [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT14];
            [btnFunc.layer setCornerRadius:4.0];
            [btnFunc.layer setBorderWidth:1];
            [btnFunc.layer setBorderColor:LINE_COLOR.CGColor];
            [btnFunc addTouch:^{
                NSLog(@"全部时间");
                for (UIView *view in btnFunc.superview.subviews) {
                    if([view isKindOfClass:[UIButton class]]) {
                        UIButton *btn = (UIButton *)view;
                        [btn setBackgroundColor:[UIColor whiteColor]];
                        [btn setTitleColor:COLOR3 forState:UIControlStateNormal];
                        [btn.layer setBorderColor:LINE_COLOR.CGColor];
                    }
                }
                [btnFunc setBackgroundColor:MAIN_COLOR];
                [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnFunc.layer setBorderColor:[UIColor whiteColor].CGColor];
                
                btnFunc.selected = !btnFunc.isSelected;
                [self.currentItem setTitle:signStr forState:UIControlStateNormal];
                
                if(self.callSignAreaBack) {
                    self.callSignAreaBack(itemArr[0], signStr);
                    [self dismiss];
                }
            }];
            [_signAreaView addSubview:btnFunc];
            
        }
    }
    
    return _signAreaView;
}

/**
 *  初始化1
 */
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.tableWidth, 0) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = BACK_COLOR;
    }
    return _tableView;
}

/**
 *  初始化2
 */
- (UITableView *)tableView1 {
    if(!_tableView1) {
        _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(self.tableWidth, 0, self.tableWidth, 0) style:UITableViewStyleGrouped];
        _tableView1.dataSource = self;
        _tableView1.delegate = self;
        _tableView1.separatorInset = UIEdgeInsetsZero;
        _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView1.backgroundColor = [UIColor whiteColor];
    }
    return _tableView1;
}

/**
 *  初始化3
 */
- (UITableView *)tableView2 {
    if(!_tableView2) {
        _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(self.tableWidth*2, 0, self.tableWidth, 0) style:UITableViewStyleGrouped];
        _tableView2.dataSource = self;
        _tableView2.delegate = self;
        _tableView2.separatorInset = UIEdgeInsetsZero;
        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView2.backgroundColor = BACK_COLOR;
    }
    return _tableView2;
}

/**
 *  获取当前视图宽度
 */
- (CGFloat)tableWidth {
    return self.frame.size.width/tableNum;
}

/**
 *  初始化
 */
- (id)initWithFrame:(CGRect)frame titleArr:(NSMutableArray *)titleArr {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //设置默认值
        tableNum = 1;
        //设置标题
        NSInteger titleNum = [titleArr count];
        CGFloat tWidth = self.frame.size.width/titleNum;
        for (NSInteger i=0; i<titleNum; i++) {
            NSArray *itemArr = [titleArr objectAtIndex:i];
            CGDropDownMenuItem *menuItem = [[CGDropDownMenuItem alloc] initWithFrame:CGRectMake(tWidth*i, 0, tWidth-1, frame.size.height)];
            [menuItem setTitle:itemArr[0] forState:UIControlStateNormal];
            [menuItem setTitleColor:COLOR3 forState:UIControlStateNormal];
            [menuItem.titleLabel setFont:FONT15];
            [menuItem setImage:[UIImage imageNamed:@"menu_icon_down"] forState:UIControlStateNormal];
            [menuItem setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            [menuItem setImageEdgeInsets:UIEdgeInsetsMake(0, menuItem.frame.size.width-menuItem.imageView.frame.size.width, 0, 0)];
            [menuItem setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [menuItem setTag:[itemArr[1] integerValue]];
            [menuItem addTarget:self action:@selector(menuItemClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:menuItem];
        }
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [self addSubview:lineView];
        
        //获取找资源业态列表
        [self getFindFormatList];
        
    }
    return self;
}

/**
 *  下来菜单点击事件
 */
- (void)menuItemClick:(CGDropDownMenuItem *)menuItem {
    NSLog(@"点击了菜单");
    
    //清除所有视图
    for (UIView *view in self.popView.subviews) {
        [view removeFromSuperview];
    }
    
    if ([_currentItem isEqual:menuItem]) {
        _currentItem.selected = !_currentItem.selected;
    }else{
        _currentItem.selected = NO;
        _currentItem = menuItem;
        _currentItem.selected = YES;
    }
    
    if (menuItem.selected) {
        [self show];
    }else{
        [self dismiss];
    }
    
}

/**
 *  显示
 */
- (void)show {
    
    NSInteger itemTag = self.currentItem.tag;
    if(itemTag==100) {
        //类型(单列表)
        
        tableNum = 1;
        _tableView.width = self.frame.size.width;
        
        [self.tableView reloadData];
        [self.popView addSubview:[self tableView]];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            NSInteger rowNum = 0;
            if(self.currentItem.tag==100) {
                //单列
                rowNum = self.typeArr.count;
            }
            else
            {
                rowNum = 10;
            }
            
            _tableView.height = (rowNum*45 > SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-self.height) ? (SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-self.height) : rowNum*45;
        }completion:^(BOOL finished) {
            self.isShow = YES;
        }];
        
    }else if(itemTag==300) {
        //业态(三级列表)
        
        tableNum = 3;
        _tableView.width = self.frame.size.width/tableNum;
        
        [self.popView addSubview:[self tableView]];
        [self.popView addSubview:[self tableView1]];
        [self.popView addSubview:[self tableView2]];
        
        NSInteger rowNum = self.dataArr.count;
        
        [self.tableView reloadData];
        [UIView animateWithDuration:0.2 animations:^{
            self.tableView.height = (rowNum*45 > SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-self.height) ? (SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-self.height) : rowNum*45;
        }completion:^(BOOL finished) {
            self.isShow = YES;
        }];
        
    }else if(itemTag==301) {
        //业态(九宫格)
        
        //特殊处理
        if(self.isSP && (IsStringEmpty(self.proId) || self.proId==0)) {
            return;
        }
        
        [self.formatArr removeAllObjects];
        CGFormatModel *model = [CGFormatModel new];
        model.id = @"0";
        model.name = @"全部";
        [self.formatArr addObject:model];
        
        //根据项目获取业态列表
        [self getFormatList];
        
        [self.popView addSubview:[self formatView]];
        
        NSInteger imgNum = [self.formatArr count];
        NSInteger rowNum = 0;
        if(imgNum>0) {
            rowNum = imgNum/4;
            NSInteger colNum = imgNum%4;
            if(colNum>0) {
                rowNum += 1;
            }
        }else {
            rowNum = 1;
        }
        [UIView animateWithDuration:0.2 animations:^{
            _formatView.height = rowNum*30+15*2+(rowNum-1)*15;
        }completion:^(BOOL finished) {
            self.isShow = YES;
        }];
        
    }else if(itemTag==200) {
        //业务员
        
        [self.teamArr removeAllObjects];
        
        //获取业务员信息
        [self getTeamMemberList];
        
        tableNum = 2;
        _tableView.width = self.frame.size.width/tableNum;
        
        [self.popView addSubview:[self tableView]];
        [self.popView addSubview:[self tableView1]];
        
        NSInteger rowNum = self.teamArr.count;
        
        [self.tableView reloadData];
        [UIView animateWithDuration:0.2 animations:^{
            self.tableView.height = (rowNum*45 > SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-self.height) ? (SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-self.height) : rowNum*45;
            if(self.tableView.height <= 300) {
                self.tableView.height = 300;
            }
        }completion:^(BOOL finished) {
            self.isShow = YES;
        }];
        
    }else if(itemTag==1000) {
        //A-Z
        
        [self.popView addSubview:[self pinyinView]];
        [UIView animateWithDuration:0.2 animations:^{
            _pinyinView.height = 150;
        }completion:^(BOOL finished) {
            self.isShow = YES;
        }];
        
    }else if(itemTag==2000){
        //项目
        
        [self.xiangmuArr removeAllObjects];
        CGXiangmuModel *model = [CGXiangmuModel new];
        model.pro_id = @"0";
        model.pro_name = @"全部";
        [self.xiangmuArr addObject:model];
        
        //根据项目获取业态列表
        [self getXiangmuList];
        
        [self.popView addSubview:[self xiangmuView]];
        
        NSInteger imgNum = [self.xiangmuArr count];
        NSInteger rowNum = 0;
        if(imgNum>0) {
            rowNum = imgNum/4;
            NSInteger colNum = imgNum%4;
            if(colNum>0) {
                rowNum += 1;
            }
        }else {
            rowNum = 1;
        }
        [UIView animateWithDuration:0.2 animations:^{
            _xiangmuView.height = rowNum*30+15*2+(rowNum-1)*15;
        }completion:^(BOOL finished) {
            self.isShow = YES;
        }];
        
    }else if(itemTag==3000) {
        //全部时间
        
        [self.popView addSubview:[self timeView]];
        [UIView animateWithDuration:0.2 animations:^{
            _timeView.height = 105;
        }completion:^(BOOL finished) {
            self.isShow = YES;
        }];
        
    }else if(itemTag==4000) {
        //意向区域
        
        [self.intentionAreaArr removeAllObjects];
        CGTeamAreaModel *model = [CGTeamAreaModel new];
        model.id = @"0";
        model.name = @"全部";
        [self.intentionAreaArr addObject:model];
        
        //根据项目获取业态列表
        [self getTeamAreaList];
        
        [self.popView addSubview:[self intentionAreaView]];
        
        NSInteger imgNum = [self.intentionAreaArr count];
        NSInteger rowNum = 0;
        if(imgNum>0) {
            rowNum = imgNum/4;
            NSInteger colNum = imgNum%4;
            if(colNum>0) {
                rowNum += 1;
            }
        }else {
            rowNum = 1;
        }
        [UIView animateWithDuration:0.2 animations:^{
            _intentionAreaView.height = rowNum*30+15*2+(rowNum-1)*15;
        }completion:^(BOOL finished) {
            self.isShow = YES;
        }];
        
    }else if(itemTag==5000) {
        //按签约面积
        
        [self.popView addSubview:[self signAreaView]];
        [UIView animateWithDuration:0.2 animations:^{
            _signAreaView.height = 105;
        }completion:^(BOOL finished) {
            self.isShow = YES;
        }];
        
    }else if(itemTag==10000) {
        //意向度
        
        [self.popView addSubview:[self intentionView]];
        [UIView animateWithDuration:0.2 animations:^{
            _intentionView.height = 105;
        }completion:^(BOOL finished) {
            self.isShow = YES;
        }];
        
    }
    
    [self.popView setHidden:NO];
    
}

/**
 *  隐藏
 */
- (void)dismiss {
    _currentItem = nil;
    [UIView animateWithDuration:0.2 animations:^{
//        _tableView.height = 0;
//        _tableView1.height = 0;
//        _tableView2.height = 0;
//        _pinyinView.height = 0;
    } completion:^(BOOL finished) {
        //清除所有视图
        for (UIView *view in self.popView.subviews) {
            [view removeFromSuperview];
        }
        [self.popView setHidden:YES];
        _isShow = NO;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView==_tableView) {
        if(self.currentItem.tag==100) {
            //类型(单列)
            return self.typeArr.count;
        }else if(self.currentItem.tag==300) {
            //三级列表
            return self.dataArr.count;
        }else if(self.currentItem.tag==200) {
            return self.teamArr.count;
        }
        return 0;
    }else if(tableView==_tableView1) {
        if(self.currentItem.tag==300) {
            //业态
            return self.dataArr1.count;
        }else if(self.currentItem.tag==200) {
            //业务员
            return self.teamMemberArr.count;
        }
    }else if(tableView==_tableView2) {
        return self.dataArr2.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGDropDownMenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    //创建“背景层”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.tableWidth, 45)];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT15];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnFunc setBackgroundColor:[UIColor clearColor]];
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    if(tableView==_tableView) {
        if(self.currentItem.tag==100) {
            //类型
            NSArray *itemArr = [self.typeArr objectAtIndex:indexPath.row];
            [btnFunc setTitle:itemArr[1] forState:UIControlStateNormal];
        }else if(self.currentItem.tag==300){
            CGFormatModel *model = [self.dataArr objectAtIndex:indexPath.row];
            [btnFunc setTitle:model.name forState:UIControlStateNormal];
        }else if(self.currentItem.tag==200) {
            CGTeamGroupModel *model = [self.teamArr objectAtIndex:indexPath.row];
            [btnFunc setTitle:model.name forState:UIControlStateNormal];
        }
        [btnFunc setTag:100+indexPath.row];
    }else if(tableView==_tableView1) {
        cell.backgroundColor = [UIColor whiteColor];
        
        if(self.currentItem.tag==200) {
            //业务员
            CGTeamMemberModel *model = [self.teamMemberArr objectAtIndex:indexPath.row];
            [btnFunc setTitle:model.name forState:UIControlStateNormal];
        }else if(self.currentItem.tag==300) {
            CGFormatModel *model = [self.dataArr1 objectAtIndex:indexPath.row];
            [btnFunc setTitle:model.name forState:UIControlStateNormal];
        }
        [btnFunc setImage:nil forState:UIControlStateNormal];
        [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
        [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        [btnFunc setTag:1000+indexPath.row];
    }else if(tableView==_tableView2) {
        
        CGFormatModel *model = [self.dataArr2 objectAtIndex:indexPath.row];
        [btnFunc setTitle:model.name forState:UIControlStateNormal];
        [btnFunc setImage:nil forState:UIControlStateNormal];
        [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
        [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        [btnFunc setTag:10000+indexPath.row];
    }
    [btnFunc addTarget:self action:@selector(btnFuncCellClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btnFunc];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, btnFunc.frame.size.height-0.5, btnFunc.frame.size.width, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [btnFunc addSubview:lineView];
    
    return cell;
}

/**
 *  单元格选择
 */
- (void)btnFuncCellClick:(UIButton *)btnSender {
    NSLog(@"单元格选择");
    if(btnSender.tag<1000) {
        //第一区块
        
        //清除背景色
        UITableViewCell *cell = (UITableViewCell *)btnSender.superview.superview;
        for (UIView *view in cell.superview.subviews) {
            if([view isKindOfClass:[UITableViewCell class]]) {
                UITableViewCell *cell = (UITableViewCell *)view;
                cell.backgroundColor = BACK_COLOR;
            }
        }
        cell.backgroundColor = [UIColor whiteColor];
        
        switch (self.currentItem.tag) {
            case 100: {
                //类型
                
                //单列选择
                if(tableNum==1) {
                    NSArray *itemArr = [self.typeArr objectAtIndex:btnSender.tag-100];
                    [self.currentItem setTitle:itemArr[1] forState:UIControlStateNormal];
                    if(self.callTypeBack) {
                        self.callTypeBack(itemArr[0], itemArr[1]);
                        [self dismiss];
                    }
                    return;
                }
                
                break;
            }
            case 200: {
                //业务员
                
                CGTeamGroupModel *teamModel = [self.teamArr objectAtIndex:btnSender.tag-100];
                self.teamMemberArr = teamModel.memberList;
                
                break;
            }
            case 300: {
                //三级业态
                
                formatModel = [self.dataArr objectAtIndex:btnSender.tag-100];
                self.dataArr1 = formatModel.second_cate_list;
                
                //清除第三栏数据
                [self.dataArr2 removeAllObjects];
                
                if ([formatModel.name isEqualToString:@"全部"])
                {
                    [self.currentItem setTitle:@"业态" forState:UIControlStateNormal];
                    if(self.callFormatListBack) {
                        formatModel2.id = @"0";
                        formatModel3.id = @"0";
                        self.callFormatListBack(formatModel.id, formatModel2.id, formatModel3.id);
                        [self dismiss];
                    }
                }
                
                break;
            }
                
            default:
                break;
        }
        
        [self.tableView1 reloadData];
        [self.tableView2 reloadData];
        self.tableView1.height = self.tableView.height;
        
    }else if(btnSender.tag<10000) {
        //第二区块
        
        //清除背景色
        UITableViewCell *cell = (UITableViewCell *)btnSender.superview.superview;
        for (UIView *view in cell.superview.subviews) {
            if([view isKindOfClass:[UITableViewCell class]]) {
                UITableViewCell *cell = (UITableViewCell *)view;
                cell.backgroundColor = [UIColor whiteColor];
                UIButton *btnFunc = (UIButton *)cell.contentView.subviews[0];
                [btnFunc setImage:nil forState:UIControlStateNormal];
            }
        }
        [btnSender setImage:[UIImage imageNamed:@"cell_icon_select"] forState:UIControlStateNormal];
        
        
        switch (self.currentItem.tag) {
            case 200: {
                //业务员
                
                CGTeamMemberModel *model = [self.teamMemberArr objectAtIndex:btnSender.tag-1000];
                [self.currentItem setTitle:model.name forState:UIControlStateNormal];
                if(self.callTeamMemberBack) {
                    self.callTeamMemberBack(model.ID,model.name);
                    [self dismiss];
                }
                return;
                
                break;
            }
            case 300: {
                //三级业态
                formatModel2 = [self.dataArr1 objectAtIndex:btnSender.tag-1000];
                self.dataArr2 = formatModel2.third_cate_list;

                if ([formatModel2.name isEqualToString:@"全部"])
                {
                    [self.currentItem setTitle:formatModel.name forState:UIControlStateNormal];
                    if(self.callFormatListBack) {
                        self.callFormatListBack(formatModel.id, formatModel2.id, formatModel3.id);
                        [self dismiss];
                    }
                }
                break;
            }
                
            default:
                break;
        }
        
        [self.tableView2 reloadData];
        self.tableView2.height = self.tableView.height;
        
    }else if(btnSender.tag>=10000) {
        //第三区块
        
        //清除背景色
        UITableViewCell *cell = (UITableViewCell *)btnSender.superview.superview;
        for (UIView *view in cell.superview.subviews) {
            if([view isKindOfClass:[UITableViewCell class]]) {
                UITableViewCell *cell = (UITableViewCell *)view;
                cell.backgroundColor = BACK_COLOR;
                UIButton *btnFunc = (UIButton *)cell.contentView.subviews[0];
                [btnFunc setImage:nil forState:UIControlStateNormal];
            }
        }
        cell.backgroundColor = [UIColor whiteColor];
        [btnSender setImage:[UIImage imageNamed:@"cell_icon_select"] forState:UIControlStateNormal];
        
        formatModel3 = [self.dataArr2 objectAtIndex:btnSender.tag-10000];
        if ([formatModel3.name isEqualToString:@"全部"])
        {
            [self.currentItem setTitle:formatModel2.name forState:UIControlStateNormal];
            if(self.callFormatListBack) {
                self.callFormatListBack(formatModel.id, formatModel2.id, formatModel3.id);
                [self dismiss];
            }
        }
        else
        {
            [self.currentItem setTitle:formatModel3.name forState:UIControlStateNormal];
            if(self.callFormatListBack) {
                self.callFormatListBack(formatModel.id, formatModel2.id, formatModel3.id);
                [self dismiss];
            }
        }
        
    }
    
}

/**
 *  获取资源业态列表
 */
- (void)getFindFormatList {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"depot" forKey:@"app"];
    [param setValue:@"getCateList" forKey:@"act"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSArray *dataList = [json objectForKey:@"data"];
            self.dataArr = [CGFormatModel mj_objectArrayWithKeyValuesArray:dataList];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
}

/**
 *  根据项目获取业态
 */
- (void)getFormatList {
    
    //特殊情况处理
    NSString *xiangmuId = [HelperManager CreateInstance].proId;
    if(self.isSP) {
        xiangmuId = self.proId;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getProAttr" forKey:@"act"];
    [param setValue:xiangmuId forKey:@"pro_id"];
    NSDictionary *json = [HttpRequestEx getSyncWidthURL:SERVICE_URL param:param];
    NSString *code = [json objectForKey:@"code"];
    if([code isEqualToString:SUCCESS]) {
        NSArray *dataList = json[@"data"][@"cate"];
        for (NSDictionary *itemDic in dataList) {
            [self.formatArr addObject:[CGFormatModel mj_objectWithKeyValues:itemDic]];
        }
    }
    
}

/**
 *  获取团队分组及成员
 */
- (void)getTeamMemberList {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getProAttr" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    NSDictionary *json = [HttpRequestEx getSyncWidthURL:SERVICE_URL param:param];
    NSString *code = [json objectForKey:@"code"];
    if([code isEqualToString:SUCCESS]) {
        NSArray *dataList = json[@"data"][@"member"];
        for (NSDictionary *itemDic in dataList) {
            [self.teamArr addObject:[CGTeamGroupModel mj_objectWithKeyValues:itemDic]];
        }
    }
    
}

/**
 *  获取项目列表
 */
- (void)getXiangmuList {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getProListWithCateList" forKey:@"act"];
    NSDictionary *json = [HttpRequestEx getSyncWidthURL:SERVICE_URL param:param];
    NSString *code = [json objectForKey:@"code"];
    if([code isEqualToString:SUCCESS]) {
        NSArray *dataList = [json objectForKey:@"data"];
        for (NSDictionary *itemDic in dataList) {
            [self.xiangmuArr addObject:[CGXiangmuModel mj_objectWithKeyValues:itemDic]];
        }
    }
    
}

/**
 *  获取意向区域
 */
- (void)getTeamAreaList {
    
    NSMutableDictionary *param =[NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getGroupList" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    NSDictionary *json = [HttpRequestEx getSyncWidthURL:SERVICE_URL param:param];
    NSString *code = [json objectForKey:@"code"];
    if([code isEqualToString:SUCCESS]) {
        NSArray *dataList = json[@"data"][@"list"];
        for (NSDictionary *itemDic in dataList) {
            [self.intentionAreaArr addObject:[CGTeamAreaModel mj_objectWithKeyValues:itemDic]];
        }
    }
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
