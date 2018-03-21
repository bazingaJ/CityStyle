//
//  CGMineTeamGroupEditViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamGroupEditViewController.h"
#import "CGTeamMemberModel.h"
#import "CGMineTeamGroupMemberAddViewController.h"

@interface CGMineTeamGroupEditViewController () {
    
    //单元格高度
    CGFloat cellH;
    //数据行数
    NSInteger rowNum;
    //总数
    NSInteger itemNum;
    
}

@property (nonatomic, strong) NSMutableArray *userArr;

@end

@implementation CGMineTeamGroupEditViewController

/**
 *  已选择成员ID
 */
- (NSMutableArray *)userArr {
    if(!_userArr) {
        _userArr = [NSMutableArray array];
    }
    return _userArr;
}

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [self setRightButtonItemTitle:@"保存"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.title = @"新增分组";
    
    if(!_groupModel) {
        _groupModel = [CGTeamGroupModel new];
    }
    
    //初始化已经存在的用户
    if(self.groupModel.memberList.count) {
        for (int i=0; i<self.groupModel.memberList.count; i++) {
            CGTeamMemberModel *memberModel = [self.groupModel.memberList objectAtIndex:i];
            [self.dataArr addObject:memberModel];
            [self.userArr addObject:memberModel.id];
        }
    }
    
    //设置模拟成员
    CGTeamMemberModel *model = [CGTeamMemberModel new];
    model.name = @"";
    model.avatar = @"mine_member_add";
    [self.dataArr addObject:model];
    
    //设置默认值
    rowNum = 1;
    itemNum = [self.dataArr count];
    
}

/**
 *  保存
 */
- (void)rightButtonItemClick {
    NSLog(@"保存");
    [self.view endEditing:YES];
    
    //验证分组名称
    NSString *groupName = self.groupModel.name;
    if(IsStringEmpty(groupName)) {
        [MBProgressHUD showError:@"请输入分组名称" toView:self.view];
        return;
    }else if([NSString stringContainsEmoji:groupName]) {
        [MBProgressHUD showError:@"分组名称不能包含表情" toView:self.view];
        return;
    }if([groupName length]>10) {
        [MBProgressHUD showError:@"分组名称不能超过10个字符" toView:self.view];
        return;
    }
    
    //验证成员
    if(!self.userArr.count) {
        [MBProgressHUD showError:@"请选择成员" toView:self.view];
        return;
    }
    
    NSString *memberIdStr = [self.userArr componentsJoinedByString:@","];
    
    [MBProgressHUD showMsg:@"保存中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"addNewGroup" forKey:@"act"];
    [param setValue:groupName forKey:@"name"];
    [param setValue:memberIdStr forKey:@"member"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [param setValue:self.groupModel.id forKey:@"team_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"保存成功" toView:self.view];
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                if(self.callBack) {
                    self.callBack();
                }
            });
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [MBProgressHUD hideHUD:self.view];
    }];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==1) {
        return 35;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==1) {
        itemNum = [self.dataArr count];
        rowNum = itemNum/5;
        NSInteger colNum = itemNum%5;
        if(colNum>0) {
            rowNum += 1;
        }
        cellH = rowNum*100;
        return cellH;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section==0) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    [backView setBackgroundColor:[UIColor whiteColor]];
    
    //创建“小组成员”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-20, 35)];
    [lbMsg setText:@"小组成员"];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGMineTeamGroupEditViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    switch (indexPath.section) {
        case 0: {
            //创建“分组输入框”
            
            UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 25)];
            [tbxContent setPlaceholder:@"请输入组名,例如招商一组"];
            [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
            [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
            [tbxContent setTextColor:COLOR3];
            [tbxContent setTextAlignment:NSTextAlignmentLeft];
            [tbxContent setFont:FONT16];
            [tbxContent setText:self.groupModel.name];
            [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
            [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [cell.contentView addSubview:tbxContent];
            
            break;
        }
        case 1: {
            //创建“小组成员”
            CGFloat tWidth = (SCREEN_WIDTH-20)/5;
            for (int i=0; i<rowNum; i++) {
                for (int k=0; k<5; k++) {
                    int tIndex = 5*i+k;
                    if(tIndex>itemNum-1) continue;
                    
                    CGTeamMemberModel *model = [self.dataArr objectAtIndex:tIndex];
                    
                    //创建“背景层”
                    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10+tWidth*k, 100*i, tWidth-1, 99)];
                    [btnFunc setTag:(itemNum-tIndex)];
                    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:btnFunc];
                    
                    if(tIndex>itemNum-2) {
                        //添加、删除
                        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-50)/2, 10, 50, 50)];
                        [imgView.layer setCornerRadius:4.0];
                        [imgView.layer setMasksToBounds:YES];
                        [imgView setImage:[UIImage imageNamed:model.avatar]];
                        [btnFunc addSubview:imgView];
                        
                    }else{
                        
                        //创建“头像”
                        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-50)/2, 10, 50, 50)];
                        [imgView setContentMode:UIViewContentModeScaleAspectFill];
                        [imgView setClipsToBounds:YES];
                        [imgView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
                        [imgView.layer setCornerRadius:4.0];
                        [imgView.layer setMasksToBounds:YES];
                        [btnFunc addSubview:imgView];
                        
                        //创建“删除”按钮
                        UIButton *btnDel = [[UIButton alloc] initWithFrame:CGRectMake(imgView.centerX+18, imgView.centerY-32, 15, 15)];
                        [btnDel setImage:[UIImage imageNamed:@"mine_member_quchu"] forState:UIControlStateNormal];
                        [btnDel setTag:btnFunc.tag];
                        [btnDel addTouch:^{
                            NSLog(@"删除成员");
                            [self.view endEditing:YES];
                            
                            [self.dataArr removeObject:model];
                            [self.userArr removeObject:model.id];
                            
                            //刷新界面
                            [self.tableView beginUpdates];
                            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                            [self.tableView endUpdates];
                            
                        }];
                        [btnFunc addSubview:btnDel];
                        
                    }
                    
                    //创建“名称”
                    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, tWidth, 20)];
                    [lbMsg setText:model.name];
                    [lbMsg setTextColor:COLOR3];
                    [lbMsg setTextAlignment:NSTextAlignmentCenter];
                    [lbMsg setFont:FONT15];
                    [btnFunc addSubview:lbMsg];
                    
                    
                }
            }
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)textFieldDidChange:(UITextField *)textField {
    self.groupModel.name = textField.text;
}

/**
 *  添加成员按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"添加成员%zd",btnSender.tag);
    [self.view endEditing:YES];
    
    if(btnSender.tag==1) {
        //添加成员
        
        CGMineTeamGroupMemberAddViewController *memberAddView = [[CGMineTeamGroupMemberAddViewController alloc] init];
        memberAddView.pro_id = self.pro_id;
        memberAddView.selectedArr = self.userArr;
        memberAddView.callBack = ^(NSMutableArray *memberArr) {
            NSLog(@"添加组员回调成功");
            
            [self.dataArr removeAllObjects];
            [self.userArr removeAllObjects];
            
            //返回的团队成员
            for (int i=0; i<memberArr.count; i++) {
                CGTeamMemberModel *model = [memberArr objectAtIndex:i];
                [self.dataArr addObject:model];
                
                [self.userArr addObject:model.id];
                
            }
            
            //设置模拟成员
            CGTeamMemberModel *model = [CGTeamMemberModel new];
            model.name = @"";
            model.avatar = @"mine_member_add";
            [self.dataArr addObject:model];
            
            //刷新单元格
            [self.tableView beginUpdates];
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView endUpdates];
            
        };
        [self.navigationController pushViewController:memberAddView animated:YES];
        
    }
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
