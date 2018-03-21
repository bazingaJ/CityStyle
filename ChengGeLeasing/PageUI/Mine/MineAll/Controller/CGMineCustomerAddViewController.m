//
//  CGMineCustomerAddViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineCustomerAddViewController.h"
#import "CGCustomerXiangmuView.h"
#import "CGCustomerModel.h"
#import "CGCustomerFormatView.h"
#import "CGFormatModel.h"
#import "CGCustomerLinkmanModel.h"

@interface CGMineCustomerAddViewController () {
    NSMutableDictionary *titleDic;
    
    //客户
    CGCustomerModel *customerInfo;
}

@end

@implementation CGMineCustomerAddViewController

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    [self setRightButtonItemTitle:@"保存"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"新增客户";
    
    //初始化客户模型
    if(!customerInfo) {
        customerInfo = [CGCustomerModel new];
    }
    
    //设置数据源
    titleDic = [NSMutableDictionary dictionary];
    
    //备注:标题/描述/是否有箭头/是否可编辑/索引值
    //第一区块
    NSMutableArray *titleArr1 = [NSMutableArray array];
    [titleArr1 addObject:@[@"客户名称",@"品牌店/店铺名",@"0",@"0",@"0",@""]];
    [titleArr1 addObject:@[@"所属项目",@"请选择所属项目",@"1",@"1",@"1",@""]];
    [titleArr1 addObject:@[@"经营业态",@"请选择经营业态",@"1",@"1",@"2",@""]];
    [titleDic setValue:titleArr1 forKey:@"0"];
    
    //第二区块
    NSMutableArray *titleArr2 = [NSMutableArray array];
    [titleArr2 addObject:@[@"联系人",@"姓名",@"0",@"0",@"100",@""]];
    [titleArr2 addObject:@[@"电话",@"手机/固定电话",@"0",@"0",@"101",@""]];
    [titleDic setValue:titleArr2 forKey:@"1"];
    
}

/**
 *  保存按钮事件
 */
- (void)rightButtonItemClick {
    NSLog(@"保存");
    [self.view endEditing:YES];
    
    NSMutableArray *titleArr1 = [titleDic objectForKey:@"0"];
    NSArray *itemArr1 = [titleArr1 objectAtIndex:0];
    NSString *proName = itemArr1[5];
    
    //客户名称验证
    if(IsStringEmpty(proName)) {
        [MBProgressHUD showError:@"请输入客户名称" toView:self.view];
        return;
    }
    
    //项目ID验证
    if(IsStringEmpty(customerInfo.pro_id)) {
        [MBProgressHUD showError:@"请选择所属项目" toView:self.view];
        return;
    }
    
    //经营业态验证
    if(IsStringEmpty(customerInfo.cate_id)) {
        [MBProgressHUD showError:@"请选择经营业态" toView:self.view];
        return;
    }
    
    //遍历联系人信息
    NSMutableArray *itemArr = [NSMutableArray array];
    for (int i=1; i<[titleDic count]; i++) {
        NSMutableArray *titleArr2 = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",i]];
        //联系人
        NSArray *itemArr2 = [titleArr2 objectAtIndex:0];
        NSString *contactName = itemArr2[5];
        //电话
        NSArray *itemArr3 = [titleArr2 objectAtIndex:1];
        NSString *mobileStr = itemArr3[5];
        
        //联系人、电话验证
        if(IsStringEmpty(contactName) ||
           IsStringEmpty(mobileStr)) {
            [MBProgressHUD showError:@"请完善联系人信息" toView:self.view];
            return;
        }
        
        //加入数组
        [itemArr addObject:@{@"linkman_name":contactName,@"linkman_mobile":mobileStr}];
    }
    
    //联系人验证
    if([itemArr count]<=0) {
        [MBProgressHUD showError:@"请输入完整的联系人信息" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMsg:@"保存中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"setNewCust" forKey:@"act"];
    [param setValue:customerInfo.pro_id forKey:@"pro_id"];
    [param setValue:proName forKey:@"name"];
    [param setValue:customerInfo.cate_id forKey:@"cate_id"];
    [param setValue:itemArr forKey:@"linkman"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"新增客户成功" toView:self.view];
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if(self.callBack) {
                    self.callBack();
                }
                [self.navigationController popViewControllerAnimated:YES];
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
    return [titleDic count]+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==[titleDic count]) {
        return 1;
    }
    NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",section]];
    return [titleArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0) {
        return 0.0001;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==[titleDic count]) {
        return 70;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section>1) {
        return 45;
    }
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if(section<=1 || section==[titleDic count]) return [UIView new];
    
    //创建“删除”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    [btnFunc setBackgroundColor:[UIColor whiteColor]];
    [btnFunc setTitle:@"删除" forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc addTouch:^{
        NSLog(@"删除当前项");
        
        //移除数组
        NSString *tIndex = [NSString stringWithFormat:@"%zd",section];
        [titleDic removeObjectForKey:tIndex];
        
        //更新字典
        [self updateCustomerTitleDic];
        
    }];
    [btnFunc.titleLabel setFont:FONT16];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnFunc.frame.size.width, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [btnFunc addSubview:lineView];
    
    return btnFunc;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGMineCustomerAddViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if(indexPath.section==[titleDic count]) {
        
        cell.backgroundColor = [UIColor clearColor];
        
        //创建“添加更多联系人”
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, SCREEN_WIDTH-20, 45)];
        [btnFunc setTitle:@"添加更多联系人" forState:UIControlStateNormal];
        [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT17];
        [btnFunc setBackgroundColor:MAIN_COLOR];
        [btnFunc.layer setCornerRadius:4.0];
        [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnFunc];
        
    }else{
        cell.backgroundColor = [UIColor whiteColor];
        
        NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",indexPath.section]];
        NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
        [lbMsg setText:itemArr[0]];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [cell.contentView addSubview:lbMsg];
        
        //创建“内容”
        NSInteger tag = [itemArr[4] integerValue];
        NSInteger row = tag%100;
        UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-130, 25)];
        [tbxContent setPlaceholder:itemArr[1]];
        [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
        [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
        [tbxContent setTextColor:COLOR3];
        [tbxContent setTextAlignment:NSTextAlignmentLeft];
        [tbxContent setFont:FONT16];
        if(indexPath.section>=1) {
            //联系人信息
            if(row==0) {
                
                //联系人
                [tbxContent setText:itemArr[5]];
                
            }else if(row==1) {
                
                //电话
                [tbxContent setText:itemArr[5]];
                [tbxContent setKeyboardType:UIKeyboardTypePhonePad];
                
            }
        }else{
            //客户名称
            switch (row) {
                case 0: {
                    //客户名称
                    [tbxContent setText:itemArr[5]];
                    
                    break;
                }
                case 1: {
                    //所属项目
                    
                    if (!IsStringEmpty(self.chuBeiKeHuID) && IsStringEmpty(customerInfo.pro_name))
                    {
                        customerInfo.pro_id = self.chuBeiKeHuID;
                        customerInfo.pro_name = @"储备客户";
                        [tbxContent setText:customerInfo.pro_name];
                    }
                    else
                    {
                        if (IsStringEmpty(customerInfo.pro_name))
                        {
                            customerInfo.pro_id = [HelperManager CreateInstance].proId;
                            customerInfo.pro_name = [HelperManager CreateInstance].proName;
                            [tbxContent setText:[HelperManager CreateInstance].proName];
                        }
                        else
                        {
                            [tbxContent setText:customerInfo.pro_name];
                        }
                    }
                    
                    break;
                }
                case 2: {
                    //经营业态
                    [tbxContent setText:customerInfo.cate_name];
                    
                    break;
                }
                    
                default:
                    break;
            }
        }
        [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
        [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [tbxContent setTag:tag];
        if([itemArr[3] integerValue]==1) {
            [tbxContent setEnabled:NO];
        }
        [cell.contentView addSubview:tbxContent];
        
        //创建“右侧尖头”
        if([itemArr[2] integerValue]==1) {
            UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
            [imgView2 setImage:[UIImage imageNamed:@"mine_arrow_right"]];
            [cell.contentView addSubview:imgView2];
        }
        
        //创建“分割线”
        if(indexPath.row<[titleArr count]-1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 44.5, SCREEN_WIDTH-100, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    switch (indexPath.section) {
        case 0: {
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            UITextField *tbxContent = [cell.contentView viewWithTag:indexPath.row];
            
            switch (indexPath.row) {
                case 1: {
                    
                    //选择所属项目
                    CGCustomerXiangmuView *xiangmuView = [[CGCustomerXiangmuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270) titleStr:@"所属项目"];
                    [xiangmuView getXiangmuList];
                    xiangmuView.callBack = ^(NSString *pro_id, NSString *pro_name) {
                        NSLog(@"项目ID：%@-项目名称：%@",pro_id,pro_name);
                        [tbxContent setText:pro_name];
                        
                        //设置项目信息
                        customerInfo.pro_id = pro_id;
                        customerInfo.pro_name = pro_name;
                        
                        //清除业态信息
                        customerInfo.cate_id = @"";
                        customerInfo.cate_name = @"";
                        
                        //刷新经营业态
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
                        [self.tableView beginUpdates];
                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        [self.tableView endUpdates];
                        
                    };
                    [xiangmuView show];
                    
                    break;
                }
                case 2: {
                    //选择经营业态
                    
                    //项目验证
                    if(IsStringEmpty(customerInfo.pro_id)) {
                        [MBProgressHUD showError:@"请选择所属项目" toView:self.view];
                        return;
                    }
                    
                    CGCustomerFormatView *formatView = [[CGCustomerFormatView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270) titleStr:@"经营业态"];
                    [formatView getFormatList:customerInfo.pro_id];
//                    [formatView setIsMultiple:YES];
                    formatView.callBack = ^(NSString *cateId, NSString *cateName) {
                        NSLog(@"业态ID：%@-业态名称：%@",cateId,cateName);
                        [tbxContent setText:cateName];
                        
                        //设置业态信息
                        customerInfo.cate_id = cateId;
                        customerInfo.cate_name = cateName;

                    };
                    [formatView show];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            break;
        }
            
        default:
            break;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)textFieldDidChange:(UITextField *)textField {

    NSInteger tag = textField.tag;
    NSInteger section = tag/100;
    NSInteger row = tag%100;
    
    NSMutableArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",section]];
    NSMutableArray *itemArr = [[titleArr objectAtIndex:row] mutableCopy];
    if(row==0) {
        //联系人
        itemArr[5] = textField.text;
    }else if(row==1) {
        itemArr[5] = textField.text;
    }
    NSLog(@"当前行:%@",itemArr);
    [titleArr removeObjectAtIndex:row];
    [titleArr insertObject:itemArr atIndex:row];
    NSLog(@"当前块:%@",titleArr);
    
}

/**
 *  添加更多联系人事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"添加更多联系人");
    
    NSInteger titleNum = [titleDic count];
    NSString *key = [NSString stringWithFormat:@"%zd",titleNum];
    
    //第N区块
    NSMutableArray *titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"联系人",@"姓名",@"0",@"0",[NSString stringWithFormat:@"%zd",titleNum*100],@""]];
    [titleArr addObject:@[@"电话",@"手机/固定电话",@"0",@"0",[NSString stringWithFormat:@"%zd",titleNum*100+1],@""]];
    [titleDic setValue:titleArr forKey:key];
    
    NSLog(@"%@",titleDic);
    
    //刷新
    [self.tableView reloadData];
    
}

/**
 *  重整数组
 */
- (void)updateCustomerTitleDic {
    
    //存留
    NSMutableDictionary *itemDic = [NSMutableDictionary dictionary];
    
    NSInteger itemNum = [titleDic count];
    for (int i=0; i<itemNum+1; i++) {
        NSString *key = [NSString stringWithFormat:@"%zd",i];
        if(i<=1) {
            
            //保留原始数组
            [itemDic setValue:[titleDic objectForKey:key] forKey:key];
            
        }else{
            
            //处理新数组
            NSMutableArray *titleArr = [titleDic objectForKey:key];
            if(titleArr && titleArr.count) {
                NSInteger titleNum = [itemDic count];
                NSString *keyStr = [NSString stringWithFormat:@"%zd",titleNum];
                
                //联系人
                NSMutableArray *itemArr = [[titleArr objectAtIndex:0] mutableCopy];
                itemArr[4] = [NSString stringWithFormat:@"%zd",titleNum*100];
                
                //电话
                NSMutableArray *itemArr2 = [[titleArr objectAtIndex:1] mutableCopy];
                itemArr2[4] = [NSString stringWithFormat:@"%zd",titleNum*100+1];
                
                [itemDic setValue:titleArr forKey:keyStr];
                
            }
            
        }
        
    }
    
    //重新赋值
    [titleDic removeAllObjects];
    titleDic = itemDic;
    
    [self.tableView reloadData];
    
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
