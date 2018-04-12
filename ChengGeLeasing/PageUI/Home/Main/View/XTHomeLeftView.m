//
//  XTHomeLeftView.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XTHomeLeftView.h"
#import "CGLeftViewCell.h"

@interface XTHomeLeftView () {
    CGRect leftFrame;
}
@property (nonatomic, strong) NSString *myPro_num;
@end

@implementation XTHomeLeftView

/**
 *  懒加载“tableView”
 */
- (CGMTableView *)tableView {
    if(!_tableView) {
        _tableView = [[CGMTableView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, self.frame.size.width, self.frame.size.height-STATUS_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-70) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = BACK_COLOR;
        _tableView.gestureMinimumPressDuration = 0.5;
        _tableView.drawMovalbeCellBlock = ^(UIView *movableCell){
            movableCell.layer.shadowColor = [UIColor grayColor].CGColor;
            movableCell.layer.masksToBounds = NO;
            movableCell.layer.cornerRadius = 0;
            movableCell.layer.shadowOffset = CGSizeMake(-5, 0);
            movableCell.layer.shadowOpacity = 0.4;
            movableCell.layer.shadowRadius = 5;
        };
        [self addSubview:_tableView];
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

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        leftFrame = frame;
        
        //设置背景色
        self.backgroundColor = BACK_COLOR;
        
        //创建“状态栏背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, STATUS_BAR_HEIGHT)];
        [backView setBackgroundColor:NAV_COLOR];
        [self addSubview:backView];
        
        //创建“tableView”
        [self tableView];
        
        //获取数据源
        [self getDataList];
        
        //创建"底部按钮"
        [self createBottomBtn];
        
    }
    return self;
}

- (void)createBottomBtn
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height -70 -HOME_INDICATOR_HEIGHT, leftFrame.size.width, 70)];
    [backView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:backView];
    
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, leftFrame.size.width-20, 45)];
    [btnFunc setTitle:@"创建项目" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT20];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc.layer setCornerRadius:5.0];
    [btnFunc setImage:[UIImage imageNamed:@"left_icon_xiangmu"] forState:UIControlStateNormal];
    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [btnFunc addTouch:^{
        if(self.didXiangmuClick) {
            self.didXiangmuClick(self,self.myPro_num);
        }
    }];
    [backView addSubview:btnFunc];
    
    //创建"提醒"
    UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50, 20, 20)];
    imageView.image = [UIImage imageNamed:@"left_icon_tixing"];
    imageView.contentMode = UIViewContentModeLeft;
    [backView addSubview:imageView];
    
    //创建"lab"
    UILabel *lbMsg1 = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right +5, imageView.top, 320, 20)];
    lbMsg1.textColor = COLOR9;
    lbMsg1.text = @"您还可以在我的-项目管理处创建项目";
    lbMsg1.font = FONT11;
    [backView addSubview:lbMsg1];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftFrame.size.width, 45)];
    [backView setBackgroundColor:[UIColor clearColor]];
    
    //创建“项目列表”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, leftFrame.size.width, 25)];
    [lbMsg setText:@"项目列表"];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentCenter];
    [lbMsg setFont:FONT18];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
 
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGLeftViewCell";
    CGLeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGLeftViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGTeamXiangmuModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setLeftViewModel:model frame:leftFrame];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CGTeamXiangmuModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    
    if ([model.is_vip_creat isEqualToString:@"1"] && [HelperManager CreateInstance].isFree)
    {
        [MBProgressHUD showMessage:@"会员已过期，没有权限操作" toView:self];
        return;
    }
    if(self.didClickItem) {
        self.didClickItem(self, model,indexPath.row);
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UPDATEPROJECT" object:nil];
}

- (NSArray *)dataSourceArrayInTableView:(CGMTableView *)tableView {
    return self.dataArr.copy;
}

- (void)tableView:(CGMTableView *)tableView newDataSourceArrayAfterMove:(NSArray *)newDataSourceArray {
    self.dataArr = newDataSourceArray.mutableCopy;
    
    //编辑数组重新排序
    NSMutableArray *itemArr = [NSMutableArray array];
    for (int i=0; i<self.dataArr.count; i++) {
        CGTeamXiangmuModel *model = [self.dataArr objectAtIndex:i];
        if(!model) continue;
        
        [itemArr addObject:model.user_id];
    }
    NSString *idsStr = [itemArr componentsJoinedByString:@","];
    NSLog(@"当前排序：%@",idsStr);

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"setSort" forKey:@"act"];
    [param setValue:idsStr forKey:@"pro_ids"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSLog(@"排序成功");
        }else {
            [MBProgressHUD showError:msg toView:nil];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
}

/**
 *  获取数据源
 */
- (void)getDataList {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getProjectList" forKey:@"act"];
    [param setValue:@"1" forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            self.myPro_num = dataDic[@"my_pro_num"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[CGTeamXiangmuModel mj_objectWithKeyValues:itemDic]];
                }
                
                //当前总数
                NSString *dataNum = [dataDic objectForKey:@"count"];
                if(!IsStringEmpty(dataNum)) {
                    //self.totalNum = [dataNum intValue];
                }else{
                    //self.totalNum = 0;
                }
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
