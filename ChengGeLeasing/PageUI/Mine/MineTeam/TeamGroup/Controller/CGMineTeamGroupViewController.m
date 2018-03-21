//
//  CGMineTeamGroupViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamGroupViewController.h"
#import "CGTeamGroupCell.h"
#import "CGMineTeamGroupEditViewController.h"

@interface CGMineTeamGroupViewController ()

@end

@implementation CGMineTeamGroupViewController

- (void)viewDidLoad {
    [self setRightButtonItemTitle:@"新增"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"所有分组";
    
}

/**
 *  返回按钮事件
 */
- (void)leftButtonItemClick {
    [super leftButtonItemClick];
    
    if(self.callBack) {
        self.callBack(self.dataArr.count);
    }
}

/**
 *  新增分组
 */
- (void)rightButtonItemClick {
    NSLog(@"新增分组");
    
    CGMineTeamGroupEditViewController *groupAddView = [[CGMineTeamGroupEditViewController alloc] init];
    groupAddView.title = @"新增分组";
    groupAddView.pro_id = self.pro_id;
    groupAddView.callBack = ^{
        NSLog(@"新增分组回调成功");
        
        [self.tableView.mj_header beginRefreshing];
        
    };
    [self.navigationController pushViewController:groupAddView animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGTeamGroupCell";
    CGTeamGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGTeamGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGTeamGroupModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setTeamGroupModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CGTeamGroupModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    
    //修改分组
    CGMineTeamGroupEditViewController *groupAddView = [[CGMineTeamGroupEditViewController alloc] init];
    groupAddView.title = @"编辑分组";
    groupAddView.pro_id = self.pro_id;
    groupAddView.groupModel = model;
    groupAddView.callBack = ^{
        NSLog(@"新增分组回调成功");
        
        [self.tableView.mj_header beginRefreshing];
        
    };
    [self.navigationController pushViewController:groupAddView animated:YES];
}

/**
 *  获取数据源
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getProInfo" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [param setValue:@"2" forKey:@"type"];
    [param setValue:@(self.pageIndex) forKey:@"page"];//预留
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if([dataDic isKindOfClass:[NSDictionary class]]) {
                NSArray *dataList = [dataDic objectForKey:@"list"];
                self.dataArr = [CGTeamGroupModel mj_objectArrayWithKeyValuesArray:dataList];
            }
            
            //设置空白页面
            [self.tableView emptyViewShowWithDataType:EmptyViewTypeGroup
                                              isEmpty:self.dataArr.count<=0
                                  emptyViewClickBlock:nil];
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
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
