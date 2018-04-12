//
//  CGAddVipMemberViewController.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/4/2.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGAddVipMemberViewController.h"
#import "CGMemberModel.h"
#import "CGMemberCell.h"
#import "CGTeamXiangmuModel.h"
#import "CGTeamMemberModel.h"

static NSString *const currentTitle = @"添加成员";

static NSString *const currentTitle1 = @"移除成员";

static NSString *const unselectPicText = @"mine_icon_normal";

static NSString *const selectPicText = @"select";

static NSString *const bottomBtnText = @"确定";

static NSString *const cellIdentifier = @"CGMemberCell1";


@interface CGAddVipMemberViewController ()

@end

@implementation CGAddVipMemberViewController

- (void)viewDidLoad
{
    [self setHiddenHeaderRefresh:YES];
    if ([self.isAdd isEqualToString:@"1"])
    {
        [self setRightButtonItemTitle:@"添加"];
    }
    else
    {
        [self setRightButtonItemTitle:@"移除"];
    }
    
    [super viewDidLoad];
    if ([self.isAdd isEqualToString:@"1"])
    {
        self.title = currentTitle;
    }
    else
    {
        self.title = currentTitle1;
    }
    
    [self prepareData];
    [self createUI];
    
}

- (void)prepareData
{
    
    // 获取成员列表
    [self getMemberListData];
    
}

- (void)createUI
{
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CGMemberCell class]) owner:nil options:nil]objectAtIndex:1];
    }
    CGMemberModel *model = self.dataArr[indexPath.row];
    cell.operationModel = model;
    cell.removeBtn.tag = indexPath.row + 1;
    [cell.removeBtn addTarget:self action:@selector(removeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGMemberModel *model = self.dataArr[indexPath.row];
    if ([model.isBefore isEqualToString:@"1"])
    {
        // 如果之前存在 则该cell 无法选中
        if (![self.isAdd isEqualToString:@"1"])
        {
            CGMemberCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
            currentCell.removeBtn.selected = !currentCell.removeBtn.selected;
            if (currentCell.removeBtn.isSelected)
            {
                model.isNewAdd = @"1";
            }
            else
            {
                model.isNewAdd = @"2";
            }
        }
    }
    else
    {
        CGMemberCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
        currentCell.removeBtn.selected = !currentCell.removeBtn.selected;
        if (currentCell.removeBtn.isSelected)
        {
            model.isNewAdd = @"1";
        }
        else
        {
            model.isNewAdd = @"2";
        }
    }
    
    
}
#pragma mark - Get Members List Data
- (void)getMemberListData
{
    
    if ([self.isAdd isEqualToString:@"1"])
    {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"app"] = @"ucenter";
        param[@"act"] = @"getGroupMember";
        param[@"business_id"] = self.account_id;
        [HttpRequestEx postWithURL:SERVICE_URL
                            params:param
                           success:^(id json) {
                               NSString *code = [json objectForKey:@"code"];
                               NSString *msg  = [json objectForKey:@"msg"];
                               if ([code isEqualToString:SUCCESS])
                               {
                                   NSDictionary *dataDic = [json objectForKey:@"data"];
                                   NSArray *arr = dataDic[@"list"];
                                   [self.dataArr removeAllObjects];
                                   self.dataArr = [CGMemberModel mj_objectArrayWithKeyValuesArray:arr];
                                   [self handelMemberSelectedOperation];
                                   //设置空白页面
                                   [self.tableView emptyViewShowWithDataType:EmptyViewTypeMember
                                                                     isEmpty:self.dataArr.count<=0
                                                         emptyViewClickBlock:nil];
                               }
                               else
                               {
                                   [MBProgressHUD showError:msg toView:self.view];
                               }
                           }
                           failure:^(NSError *error) {
                               
                               [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                           }];
    }
    else if ([self.isAdd isEqualToString:@"2"])
    {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:@"ucenter" forKey:@"app"];
        [param setValue:@"getProInfo" forKey:@"act"];
        [param setValue:self.pro_id forKey:@"pro_id"];
        [param setValue:@"1" forKey:@"type"];
        [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
            NSString *code = [json objectForKey:@"code"];
            if([code isEqualToString:SUCCESS])
            {
                NSDictionary *dataDic = [json objectForKey:@"data"];
                CGTeamXiangmuModel *xiangmuModel = [CGTeamXiangmuModel mj_objectWithKeyValues:dataDic];
                //团队成员
                if(xiangmuModel.list.count > 0)
                {
                    [self.dataArr removeAllObjects];
                    self.dataArr = [CGMemberModel mj_objectArrayWithKeyValuesArray:xiangmuModel.list];
                }
                
            }
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
        }];
    }
}


/**
 处理成员已经在项目中的问题
 */
- (void)handelMemberSelectedOperation
{
    
    if ([self.isAdd isEqualToString:@"1"])
    {
        for (CGMemberModel *model in self.dataArr)
        {
            model.isBefore = @"2";
            for (CGTeamMemberModel *model1 in self.selectdArr)
            {
                if ([model.member_id isEqualToString:model1.ID])
                {
                    model.isBefore = @"1";
                }
            }
        }
    }
    else
    {
        for (CGMemberModel *model in self.dataArr)
        {
            model.isBefore = @"2";
        }
    }
    
    [self.tableView reloadData];
}

- (void)rightButtonItemClick
{
    
    NSString *memberStr = @"";
    for (CGMemberModel *model in self.dataArr)
    {
        if ([model.isNewAdd isEqualToString:@"1"])
        {
            memberStr = [memberStr stringByAppendingString:[NSString stringWithFormat:@"%@,",model.member_id]];
        }
    }
    if ([self.isAdd isEqualToString:@"1"])
    {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"app"] = @"ucenter";
        param[@"act"] = @"addNewUser";
        param[@"pro_id"] = self.pro_id;
        param[@"member"] = memberStr;
        [MBProgressHUD showSimple:self.view];
        [HttpRequestEx postWithURL:SERVICE_URL
                            params:param
                           success:^(id json) {
                               [MBProgressHUD hideHUDForView:self.view];
                               NSString *code = [json objectForKey:@"code"];
                               NSString *msg  = [json objectForKey:@"msg"];
                               if ([code isEqualToString:SUCCESS])
                               {
                                   [MBProgressHUD showMessage:@"已添加" toView:self.view];
                                   [self.navigationController popViewControllerAnimated:YES];
                               }
                               else
                               {
                                   [MBProgressHUD showError:msg toView:self.view];
                               }
                           }
                           failure:^(NSError *error) {
                               [MBProgressHUD hideHUDForView:self.view];
                               [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                           }];
    }
    else
    {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"app"] = @"ucenter";
        param[@"act"] = @"dropUser";
        param[@"pro_id"] = self.pro_id;
        param[@"member"] = memberStr;
        [MBProgressHUD showSimple:self.view];
        [HttpRequestEx postWithURL:SERVICE_URL
                            params:param
                           success:^(id json) {
                               [MBProgressHUD hideHUDForView:self.view];
                               NSString *code = [json objectForKey:@"code"];
                               NSString *msg  = [json objectForKey:@"msg"];
                               if ([code isEqualToString:SUCCESS])
                               {
                                   [MBProgressHUD showMessage:@"已移除" toView:self.view];
                                   [self.navigationController popViewControllerAnimated:YES];
                               }
                               else
                               {
                                   [MBProgressHUD showError:msg toView:self.view];
                               }
                           }
                           failure:^(NSError *error) {
                               [MBProgressHUD hideHUDForView:self.view];
                               [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                           }];
    }
}
- (void)removeButtonClick:(UIButton *)button
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag - 1 inSection:0];
    CGMemberModel *model = self.dataArr[indexPath.row];
    
    if ([self.isAdd isEqualToString:@"1"])
    {
        if ([model.isBefore isEqualToString:@"1"])
        {
            // 之前页面带过来的 不给于点击事件
        }
        else
        {
            // 改变按钮状态
            button.selected = !button.selected;
            // 修改模型按钮状态
            if (button.isSelected)
            {
                model.isNewAdd = @"1";
            }
            else
            {
                model.isNewAdd = @"2";
            }
            
        }
    }
    else
    {
        button.selected = !button.selected;
        if (button.isSelected)
        {
            model.isNewAdd = @"1";
        }
        else
        {
            model.isNewAdd = @"2";
        }
    }
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
