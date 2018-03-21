//
//  CGMineAuthViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineAuthViewController.h"
#import "CGMineAuthMemberModel.h"
#import "CGMineAuthModel.h"

@interface CGMineAuthViewController () {
    CGMineAuthMemberModel *selectMemModel;
}

@end

@implementation CGMineAuthViewController

/**
 *  懒加载“tableView1”
 */
- (UITableView *)tableView1 {
    if(!_tableView1) {
        _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH/2, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45) style:UITableViewStyleGrouped];
        _tableView1.dataSource = self;
        _tableView1.delegate = self;
        _tableView1.separatorInset = UIEdgeInsetsZero;
        _tableView1.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView1.backgroundColor = BACK_COLOR;
        [self.view addSubview:_tableView1];
    }
    return _tableView1;
}

/**
 *  懒加载“tableView2”
 */
- (UITableView *)tableView2 {
    if(!_tableView2) {
        _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 45, SCREEN_WIDTH/2, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45) style:UITableViewStyleGrouped];
        _tableView2.dataSource = self;
        _tableView2.delegate = self;
        _tableView2.separatorInset = UIEdgeInsetsZero;
        _tableView2.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView2.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tableView2];
    }
    return _tableView2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"分配权限";
    
    CGFloat tWidth = SCREEN_WIDTH/2;
    for (int i=0; i<2; i++) {

        //创建“背景层”
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(tWidth*i, 0, tWidth, 45)];
        if(i==0) {
            [backView setBackgroundColor:BACK_COLOR];
        }else if(i==1) {
            [backView setBackgroundColor:[UIColor whiteColor]];
        }
        [self.view addSubview:backView];

        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, backView.frame.size.width-20, 25)];
        if(i==0) {
            [lbMsg setText:@"团队成员"];
        }else if(i==1) {
            [lbMsg setText:@"权限设置"];
        }
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [backView addSubview:lbMsg];
    }
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self.view addSubview:lineView];
    
    [self tableView1];
    
    [self tableView2];
    
    //获取人员和权限列表
    [self getMemberAndAuth];
    
    //获取所有权限
    [self getAllAuthList];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView==_tableView1) {
        return self.dataArr1.count;
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
    static NSString *cellIndentifier = @"CGMineAuthViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if(tableView==_tableView1) {
        
        CGMineAuthMemberModel *model;
        if(self.dataArr1.count) {
            model = [self.dataArr1 objectAtIndex:indexPath.row];
        }
        
        //创建“标题”
        NSInteger authNum  = model.authArr.count;
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH/2-20, 25)];
        [lbMsg setText:[NSString stringWithFormat:@"%@(%zd)",model.user_name,authNum]];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [cell.contentView addSubview:lbMsg];
        
        //设置选中背景层
        if([model.user_id isEqualToString:selectMemModel.user_id]) {
            cell.backgroundColor = [UIColor whiteColor];
        }
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH/2, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [cell.contentView addSubview:lineView];
        
    }else if(tableView==_tableView2) {
        
        CGMineAuthModel *model;
        if(self.dataArr2.count) {
            model = [self.dataArr2 objectAtIndex:indexPath.row];
        }
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH/2-20, 25)];
        [lbMsg setText:model.name];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [cell.contentView addSubview:lbMsg];
        
        //创建“选择”按钮
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-35, 10, 25, 25)];
        if([selectMemModel.authArr containsObject:model.id]) {
            //已有权限
            [btnFunc setImage:[UIImage imageNamed:@"mine_icon_selected"] forState:UIControlStateNormal];
            [btnFunc setSelected:YES];
        }else{
            //未有权限
            [btnFunc setImage:[UIImage imageNamed:@"mine_icon_normal"] forState:UIControlStateNormal];
            [btnFunc setSelected:NO];
        }
        [btnFunc setTag:[model.id integerValue]];
        [btnFunc addTarget:self action:@selector(btnFuncAuthClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnFunc];
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH/2, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [cell.contentView addSubview:lineView];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView==_tableView1) {
        
        //设置底色
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        //预先清除所有底色
        for (UIView *view in cell.superview.subviews) {
            if([view isKindOfClass:[UITableViewCell class]]) {
                UITableViewCell *cell = (UITableViewCell *)view;
                cell.backgroundColor = BACK_COLOR;
            }
        }
        cell.backgroundColor = [UIColor whiteColor];
        
        //当前选择项
        if(self.dataArr1.count) {
            selectMemModel = [self.dataArr1 objectAtIndex:indexPath.row];
        }
        [self.tableView2 reloadData];
        
    }else if(tableView==_tableView2) {

    }
}

/**
 *  设置权限
 */
- (void)btnFuncAuthClick:(UIButton *)btnSender {
    NSLog(@"设置权限");
    
    //设置按钮状态
    btnSender.selected = !btnSender.selected;
    
    NSInteger authId = btnSender.tag;
    
    //用户验证
    if(IsStringEmpty(selectMemModel.user_id)) {
        [MBProgressHUD showError:@"请选择用户" toView:self.view];
        return;
    }
    
    //权限ID验证
    if(authId<=0) {
        [MBProgressHUD showError:@"权限ID不能为空" toView:self.view];
        return;
    }
    
    NSString *auth_id = [NSString stringWithFormat:@"%zd",authId];
    NSMutableArray *itemArr = [selectMemModel.authArr mutableCopy];
    if(btnSender.isSelected) {
        [itemArr addObject:auth_id];
    }else{
        [itemArr removeObject:auth_id];
    }
    
    //ID重组
    NSString *authStr = [itemArr componentsJoinedByString:@","];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"serUserAuth" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [param setValue:selectMemModel.user_id forKey:@"member"];
    [param setValue:authStr forKey:@"auth"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSLog(@"设置权限成功");
            
            //存留最新数据
            selectMemModel.auth = authStr;
            
            //设置图片状态
            if(btnSender.isSelected) {
                //选中
                [btnSender setImage:[UIImage imageNamed:@"mine_icon_selected"] forState:UIControlStateNormal];
            }else{
                //未选中
                [btnSender setImage:[UIImage imageNamed:@"mine_icon_normal"] forState:UIControlStateNormal];
            }
            
            //刷新左侧列表
            [self.tableView1 reloadData];
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
}

/**
 *  获取人员和权限列表
 */
- (void)getMemberAndAuth {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getUserListWithAuthByPro" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSArray *dataList = [json objectForKey:@"data"];
            self.dataArr1 = [CGMineAuthMemberModel mj_objectArrayWithKeyValuesArray:dataList];
        }
        [self.tableView1 reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
}

/**
 *  获取所有权限列表
 */
- (void)getAllAuthList {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getAuthList" forKey:@"act"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSArray *dataList = [json objectForKey:@"data"];
            self.dataArr2 = [CGMineAuthModel mj_objectArrayWithKeyValuesArray:dataList];
        }
        [self.tableView2 reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
