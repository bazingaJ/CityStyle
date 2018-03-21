//
//  CGEditNotifyBacklogViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGEditNotifyBacklogViewController.h"
#import "CGLimitTextView.h"
#import "WSDatePickerView.h"
#import "CGSelectAddCustomerViewController.h"
#import "CGLinkmanSelectionViewController.h"
#import "CGSelectingReminderTimeViewController.h"
@interface CGEditNotifyBacklogViewController ()

@property (nonatomic, strong) CGLimitTextView *limitView;

@end

@implementation CGEditNotifyBacklogViewController

- (void)viewDidLoad
{
    [self setRightButtonItemTitle:@"保存"];
    
    self.hiddenHeaderRefresh = YES;
    
    [super viewDidLoad];

    if (!self.model)
    {
        self.model = [CGRemindModel new];
        self.model.cust_name = self.cust_name;
        self.model.cust_id = self.cust_id;
    }
}

-(void)rightButtonItemClick
{
    [self.view endEditing:YES];
    
    if ([self.title isEqualToString:@"编辑待办"])
    {
        //编辑待办
        [self editToDoList];
    }
    else
    {
        //添加待办
         [self setToDoList];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==1)
    {
        return 3;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0)
    {
        return 0.001;
    }
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {
        return 160;
    }
    
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGEditNotifyBacklogViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    if (indexPath.section ==0)
    {
        //创建“详情输入框”
        self.limitView = [[CGLimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
        self.limitView.limitNum = 200;
        
        if (IsStringEmpty(self.model.content))
        {
            self.limitView.placeHolder = @"详情...";
        }
        else
        {
           self.limitView.textView.text = self.model.content;
        }
        [cell.contentView addSubview:self.limitView];
    }
    else if (indexPath.section ==1)
    {
        //创建"标题"
        UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 45)];
        lbMsg.font = FONT16;
        lbMsg.textColor = COLOR3;
        lbMsg.text = @[@"时间",@"客户",@"联系人"][indexPath.row];
        [cell.contentView addSubview:lbMsg];
        
        //创建"内容"
        UILabel *lbMsg1 =[[UILabel alloc]initWithFrame:CGRectMake(95, 0, SCREEN_WIDTH -120, 45)];
        lbMsg1.font = FONT16;
        lbMsg1.textColor = COLOR3;
        [cell.contentView addSubview:lbMsg1];
        
        if (self.type ==1)
        {
            if (indexPath.row !=1)
            {
                //创建"箭头"
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -30, 0, 15, 45)];
                imageView.contentMode = UIViewContentModeRight;
                imageView.image = [UIImage imageNamed:@"mine_arrow_right"];
                [cell.contentView addSubview:imageView];
            }
        }
        else
        {
            //创建"箭头"
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -30, 0, 15, 45)];
            imageView.contentMode = UIViewContentModeRight;
            imageView.image = [UIImage imageNamed:@"mine_arrow_right"];
            [cell.contentView addSubview:imageView];
        }
    
        //创建"线"
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(95, 44.5, SCREEN_WIDTH-95, .5)];
        lineView.backgroundColor = LINE_COLOR;
        [cell.contentView addSubview:lineView];
        
        if (indexPath.row ==0)
        {
            //时间

            if (IsStringEmpty(self.model.time))
            {
                self.model.time = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm"];
            }
          
            lbMsg1.text = self.model.time;
        }
        else if (indexPath.row ==1)
        {
            lbMsg1.text  = self.model.cust_name;
        }
        else if (indexPath.row ==2)
        {
            lbMsg1.text  = self.model.linkman_name;
        }
    }
    else if (indexPath.section ==2)
    {
        //创建"标题"
        UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 45)];
        lbMsg.font = FONT16;
        lbMsg.textColor = COLOR3;
        lbMsg.text = @"提醒";
        [cell.contentView addSubview:lbMsg];
        
        //创建"内容"
        UILabel *lbMsg1 =[[UILabel alloc]initWithFrame:CGRectMake(95, 0, SCREEN_WIDTH -120, 45)];
        lbMsg1.font = FONT16;
        lbMsg1.textColor = COLOR3;
        lbMsg1.text = self.model.type_name;
        [cell.contentView addSubview:lbMsg1];
        
        //创建"箭头"
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -30, 0, 15, 45)];
        imageView.contentMode = UIViewContentModeRight;
        imageView.image = [UIImage imageNamed:@"mine_arrow_right"];
        [cell.contentView addSubview:imageView];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.model.content = self.limitView.textView.text;
     [self.view endEditing:YES];
    if (indexPath.section ==1)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                //时间
                WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
                    NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
                    self.model.time = date;
                    [self.tableView reloadData];
                }];
                datepicker.dateLabelColor = MAIN_COLOR;//年-月-日-时-分 颜色
                datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
                datepicker.doneButtonColor = MAIN_COLOR;//确定按钮的颜色
                [datepicker show];
                
            }
                break;
            case 1:
            {
                if (self.type ==1) return;

                //客户
                CGSelectAddCustomerViewController * selectAddCustomerView = [[CGSelectAddCustomerViewController alloc]init];
                selectAddCustomerView.type =4;
                WS(weakSelf);
                selectAddCustomerView.callBack = ^(CGSelectAddCustomerModel *model)
                {
                    weakSelf.model.cust_id      = model.cust_id;//客户id
                    weakSelf.model.cust_name      = model.name;//客户名称;
                    weakSelf.model.linkman_name   = model.linkman_name;//联系人名字
                    weakSelf.model.linkman_id     = model.linkman_id;//联系人id
                    [weakSelf.tableView reloadData];
                };
                [self.navigationController pushViewController:selectAddCustomerView animated:YES];
                
            }
                break;
            case 2:
            {
                //联系人
                if (IsStringEmpty(self.model.cust_id))
                {
                    [MBProgressHUD showError:@"请选择客户" toView:self.view];
                    return;
                }
                
                CGLinkmanSelectionViewController *linkmanSelectionView =[[CGLinkmanSelectionViewController alloc]init];
                linkmanSelectionView.cust_id = self.model.cust_id;
                WS(weakSelf);
                linkmanSelectionView.callBack = ^(CGLinkmanModel *model)
                {
                    weakSelf.model.linkman_id = model.id;
                    weakSelf.model.linkman_name = model.name;
                    [weakSelf.tableView reloadData];
                };
                [self.navigationController pushViewController:linkmanSelectionView animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section ==2)
    {
        CGSelectingReminderTimeViewController *timeView = [CGSelectingReminderTimeViewController new];
        WS(weakSelf);
        timeView.callBack = ^(NSDictionary *dataDic)
        {
            weakSelf.model.type_name = dataDic[@"title"];
            weakSelf.model.type = dataDic[@"id"];
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:timeView animated:YES];
    }
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

//添加代办事项
-(void)setToDoList
{
    if (IsStringEmpty(self.model.content))
    {
        [MBProgressHUD showError:@"请输入待办事项" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.cust_id))
    {
        [MBProgressHUD showError:@"请选择客户" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.linkman_id))
    {
        [MBProgressHUD showError:@"请选择联系人" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.time))
    {
        [MBProgressHUD showError:@"请选择时间" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.type))
    {
        [MBProgressHUD showError:@"请选择提醒时间" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMsg:@"添加中.." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"setToDoList" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.model.cust_id forKey:@"cust_id"];
    [param setValue:self.model.linkman_id forKey:@"linkman_id"];
    [param setValue:self.model.time forKey:@"time"];
    [param setValue:self.model.type forKey:@"type"];
    [param setValue:self.limitView.textView.text forKey:@"content"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *code = json[@"code"];
        NSString *msg = json[@"msg"];
        if ([code isEqualToString:SUCCESS])
        {
            [MBProgressHUD showSuccess:@"添加成功" toView:self.view];
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            [MBProgressHUD showError:msg toView:self.view];
        }

    } failure:^(NSError *error)
    {
        [MBProgressHUD hideHUD:self.view];
    }];
}

//编辑待办
-(void)editToDoList
{
    self.model.content = self.limitView.textView.text;
    if (IsStringEmpty(self.model.content))
    {
        [MBProgressHUD showError:@"请输入待办事项" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.cust_id))
    {
        [MBProgressHUD showError:@"请选择客户" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.linkman_id))
    {
        [MBProgressHUD showError:@"请选择联系人" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.time))
    {
        [MBProgressHUD showError:@"请选择时间" toView:self.view];
        return;
    }
    if (IsStringEmpty(self.model.type))
    {
        [MBProgressHUD showError:@"请选择提醒时间" toView:self.view];
        return;
    }
    [MBProgressHUD showMsg:@"修改中.." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"editToDoList" forKey:@"act"];
    [param setValue:self.model.id forKey:@"id"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.model.cust_id forKey:@"cust_id"];
    [param setValue:self.model.linkman_id forKey:@"linkman_id"];
    [param setValue:self.model.time forKey:@"time"];
    [param setValue:self.model.type forKey:@"type"];
    [param setValue:self.model.content forKey:@"content"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
    {[MBProgressHUD hideHUD:self.view];
        NSString *code = json[@"code"];
        NSString *msg = json[@"msg"];
        if ([code isEqualToString:SUCCESS])
        {
            [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            [MBProgressHUD showError:msg toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD:self.view];
    }];
}

@end

