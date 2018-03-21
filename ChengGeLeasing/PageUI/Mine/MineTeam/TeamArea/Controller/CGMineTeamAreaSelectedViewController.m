//
//  CGMineTeamAreaSelectedViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamAreaSelectedViewController.h"
#import "CGMineTeamAreaSelectedCell.h"
#import "CGMineTeamAreaAddViewController.h"

@interface CGMineTeamAreaSelectedViewController ()

@end

@implementation CGMineTeamAreaSelectedViewController

- (void)viewDidLoad {
    
    [self setRightButtonItemTitle:@"新增区域"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择所在区域";
    
}

-(void)rightButtonItemClick
{
    CGMineTeamAreaAddViewController *addView = [[CGMineTeamAreaAddViewController alloc] init];
    addView.pro_id = self.pro_id;
    addView.callBack = ^{
        NSLog(@"新增区域回调成功");
        
        [self.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:addView animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGMineTeamAreaSelectedCell";
    CGMineTeamAreaSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGMineTeamAreaSelectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
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
    [cell setTeamAreaModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CGTeamAreaModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(!model) return;
    
    if(self.callBack) {
        self.callBack(model.id, model.name);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
