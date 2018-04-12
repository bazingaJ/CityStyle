//
//  CGRemoveVC.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGRemoveVC.h"
#import "CGMemberModel.h"
#import "CGMemberCell.h"

static NSString *const currentTitle = @"移交账户";

static NSString *const unselectPicText = @"mine_icon_normal";

static NSString *const selectPicText = @"select";

static NSString *const bottomBtnText = @"确定";

static NSString *const cellIdentifier = @"CGMemberCell1";

static const CGFloat bottomBtnHeight = 45.f;

@interface CGRemoveVC ()
@property (nonatomic, strong) NSIndexPath *beforeIndex;
@end

@implementation CGRemoveVC

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    self.bottomH = bottomBtnHeight;
    [super viewDidLoad];
    self.title = currentTitle;
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
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setTitle:bottomBtnText forState:UIControlStateNormal];
    [bottomBtn setBackgroundColor:MAIN_COLOR];
    bottomBtn.titleLabel.font = FONT15;
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-HOME_INDICATOR_HEIGHT);
        make.height.mas_equalTo(45);
    }];
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
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CGMemberCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    CGMemberModel *model = self.dataArr[indexPath.row];
    cell.remove_model = model;
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
    
    if (self.beforeIndex)
    {
        CGMemberCell *cell = [tableView cellForRowAtIndexPath:self.beforeIndex];
        cell.removeBtn.selected = NO;
    }
    CGMemberCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
    currentCell.choiceBtn.selected = YES;
    self.beforeIndex = indexPath;
    
}
#pragma mark - Get Members List Data
- (void)getMemberListData
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
                               NSArray *dataArr = [CGMemberModel mj_objectArrayWithKeyValuesArray:arr];
                               // 数据筛选 创建者本人或者非管理员账户不可移交
                               [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                  
                                   CGMemberModel *model = (CGMemberModel *)obj;
                                   if ([model.is_owner isEqualToString:@"2"])
                                   {
                                       [self.dataArr addObject:model];
                                   }
                                   
                               }];
                               [self.tableView reloadData];
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
- (void)bottomBtnClick
{
    if (self.dataArr.count == 0)
    {
        [MBProgressHUD showError:@"暂无成员" toView:self.view];
        return;
    }
    CGMemberModel *model = self.dataArr[self.beforeIndex.row];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"ucenter";
    param[@"act"] = @"devAccount";
    param[@"member_id"] = model.member_id;
    param[@"business_id"] = self.account_id;
    [MBProgressHUD showSimple:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUDForView:self.view];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                   [MBProgressHUD showMessage:@"移交成功" toView:self.view];
                                   
                               });
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
