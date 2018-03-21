//
//  CGCustomerXiangmuView.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGCustomerXiangmuView.h"
#import "CGXiangmuModel.h"

@implementation CGCustomerXiangmuView

/**
 *  懒加载“tableView”
 */
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, self.yPosition-HOME_INDICATOR_HEIGHT-45) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_backView addSubview:_tableView];
    }
    return _tableView;
}

/**
 *  懒加载
 */
- (NSMutableArray *)dataArr {
    if(!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (id)initWithFrame:(CGRect)frame titleStr:(NSString *)titleStr {
    self = [super initWithFrame:frame];
    if(self) {
        
        //设置frame
        CGRect rect = [UIScreen mainScreen].bounds;
        self.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        //设置面板高度
        self.yPosition = 270;
        
        //创建“View”背景层
        CGRect frame = self.backView.frame;
        frame.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.yPosition);
        frame.origin = CGPointMake(0, self.frame.size.height);
        
        //创建“背景层”
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.userInteractionEnabled = YES;
        _backView.frame = frame;
        [self addSubview:_backView];
        
        //创建“标题”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45)];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [_backView addSubview:backView];
        
        //创建“”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, backView.frame.size.width-20, 25)];
        [lbMsg setText:titleStr];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT17];
        [backView addSubview:lbMsg];
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, backView.frame.size.width, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [backView addSubview:lineView];
        
        //创建“tableView”
        [self tableView];
        
        //弹层
        [self showAlert];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
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
    static NSString *cellIdentity = @"CGCustomerXiangmuViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for(UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGXiangmuModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width-20, 25)];
    [lbMsg setText:model.pro_name];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [cell.contentView addSubview:lbMsg];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, self.frame.size.width, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [cell.contentView addSubview:lineView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGXiangmuModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    
    if(self.callBack) {
        self.callBack(model.pro_id, model.pro_name);
        [self dismiss];
    }
    
}

/**
 *  获取项目列表
 */
- (void)getXiangmuList {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getProListWithCateList" forKey:@"act"];
    [param setValue:@"1" forKey:@"is_had_backup"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSArray *dataList = [json objectForKey:@"data"];
            self.dataArr = [CGXiangmuModel mj_objectArrayWithKeyValuesArray:dataList];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
}

//显示弹出层
- (void)show {
    [UIView animateWithDuration:.23 animations:^{
        CGRect frame = _backView.frame;
        frame.origin.y -= self.yPosition;
        _backView.frame = frame;
    }];
}

//关闭弹出层
- (void)dismiss {
    [UIView animateWithDuration:.23 animations:^{
        CGRect frame = self.backView.frame;
        frame.origin.y += self.yPosition;
        self.backView.frame = frame;
        [self removeFromSuperview];
    } completion:^(BOOL complete){
        //[self.delegate EYWalletPaySheetSheetPressed:self index:self.index];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self topToDismiss];
}

- (void)btnFuncCloseClick:(UIButton *)btnSender {
    UIButton *btnFunc = (UIButton *)btnSender;
    self.index = (NSInteger)btnFunc.tag;
    [self dismiss];
}

- (void)showAlert {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

- (void)topToDismiss {
    self.index = -1;
    [self dismiss];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
