//
//  CGMineTeamAreaViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamAreaViewController.h"
#import "CGMineTeamAreaAddViewController.h"

@interface CGMineTeamAreaViewController ()

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger totalNum;

@end

@implementation CGMineTeamAreaViewController

/**
 *  懒加载“tableView”
 */
- (CGMTableView *)tableView {
    if(!_tableView) {
        _tableView = [[CGMTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
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
        [self.view addSubview:_tableView];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.dataArr removeAllObjects];
            self.pageIndex = 1;
            [self getDataList:NO];
        }];
        [_tableView.mj_header beginRefreshing];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"区域管理";
    
    //加载"tableView"
    [self tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return self.dataArr.count;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==1) {
        return 65;
    }
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 55;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    
    //创建“新增区域”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 45)];
    [btnFunc setTitle:@"新增区域" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc.layer setCornerRadius:4.0];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnFunc];
    
    return bgView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGMineTeamAreaCell";
    CGMineTeamAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGMineTeamAreaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGTeamAreaModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setDelegate:self];
    [cell setTeamAreaModel:model indexPath:indexPath];
    
    return cell;
    
}

- (NSArray *)dataSourceArrayInTableView:(CGMTableView *)tableView {
    return self.dataArr.copy;
}

- (void)tableView:(CGMTableView *)tableView newDataSourceArrayAfterMove:(NSArray *)newDataSourceArray {
    self.dataArr = newDataSourceArray.mutableCopy;
    
    //编辑数组重新排序
    NSMutableArray *itemArr = [NSMutableArray array];
    for (int i=0; i<self.dataArr.count; i++) {
        CGTeamAreaModel *model = [self.dataArr objectAtIndex:i];
        if(!model) continue;
        
        [itemArr addObject:model.id];
    }
    NSString *idsStr = [itemArr componentsJoinedByString:@","];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"setGroupSort" forKey:@"act"];
    [param setValue:idsStr forKey:@"group_ids"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSLog(@"排序成功");
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
}

/**
 *  区域管理委托代理
 */
- (void)CGMineTeamAreaCellClick:(CGTeamAreaModel *)model tIndex:(NSInteger)tIndex indexPath:(NSIndexPath *)indexPath {
    NSLog(@"区域管理委托代理");
    
    switch (tIndex) {
        case 0: {
            //编辑
            CGMineTeamAreaAddViewController *addView = [[CGMineTeamAreaAddViewController alloc] init];
            addView.pro_id = self.pro_id;
            addView.areaInfo = model;
            addView.callBack = ^{
                NSLog(@"新增区域回调成功");
                
                [self.tableView.mj_header beginRefreshing];
            };
            [self.navigationController pushViewController:addView animated:YES];
            
            break;
        }
        case 1: {
            //删除
            
            UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"警告" message:@"您确定要删除吗?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"删除");
                
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setValue:@"ucenter" forKey:@"app"];
                [param setValue:@"dropGroup" forKey:@"act"];
                [param setValue:model.id forKey:@"group_id"];
                [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                    NSString *msg = [json objectForKey:@"msg"];
                    NSString *code = [json objectForKey:@"code"];
                    if([code isEqualToString:SUCCESS]) {
                        
                        [self.dataArr removeObject:model];
                        
                        //静态刷新
                        [self.tableView beginUpdates];
                        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                        //延迟一秒返回
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [MBProgressHUD showSuccess:@"删除成功" toView:self.view];
                        });
                        
                    }else{
                        [MBProgressHUD showError:msg toView:self.view];
                    }
                } failure:^(NSError *error) {
                    NSLog(@"%@",[error description]);
                }];
                
            }];
            [aler addAction:cancelAction];
            [aler addAction:okAction];
            [self presentViewController:aler animated:YES completion:nil];
            
            break;
        }
            
        default:
            break;
    }
    
}

/**
 *  新增区域
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"新增区域");
    
    CGMineTeamAreaAddViewController *addView = [[CGMineTeamAreaAddViewController alloc] init];
    addView.pro_id = self.pro_id;
    addView.callBack = ^{
        NSLog(@"新增区域回调成功");
        
        [self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:addView animated:YES];
    
}

/**
 *  获取数据源
 */
- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getProInfo" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [param setValue:@"3" forKey:@"type"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if([dataDic isKindOfClass:[NSDictionary class]]) {
                NSArray *dataList = [dataDic objectForKey:@"list"];
                self.dataArr = [CGTeamAreaModel mj_objectArrayWithKeyValuesArray:dataList];
            }
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self.tableView.mj_header endRefreshing];
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
