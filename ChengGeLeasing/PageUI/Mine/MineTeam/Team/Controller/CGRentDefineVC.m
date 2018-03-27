//
//  CGRentDefineVC.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/23.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGRentDefineVC.h"
#import "CGRentCell.h"

static NSString *const currentTitle = @"租金定义";

static NSString *const cellIdentifier1 = @"CGRentCell1";

static NSString *const cellIdentifier2 = @"CGRentCell2";

static NSString *const bottomText = @"确定";

static const CGFloat bottomHeight = 45.f;

@interface CGRentDefineVC ()
@property (nonatomic, strong) NSArray *sectionTitlesArr;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *placeholderArr;
@property (nonatomic, strong) NSMutableDictionary *contentDic;
@end

@implementation CGRentDefineVC

- (void)viewDidLoad {
    [self setHiddenHeaderRefresh:YES];
    self.bottomH = bottomHeight;
    [super viewDidLoad];
    self.title = currentTitle;
    [self prepareForData];
    [self createUI];
}

- (void)prepareForData
{
    
    self.sectionTitlesArr = @[@"低区",@"中区",@"高区"];
    self.titleArr = @[@[@"租金≤"],@[@"租金≤",@"租金≥"],@[@"租金≥"]];
    self.placeholderArr = @[@[@"请输入最低租金"],@[@"请输入最低租金",@"请输入最高租金"],@[@"请输入最低租金"]];
    
    self.contentDic = [NSMutableDictionary dictionary];
    NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *index2 = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *index3 = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *index4 = [NSIndexPath indexPathForRow:0 inSection:2];
    self.contentDic[index1] = @"";
    self.contentDic[index2] = @"";
    self.contentDic[index3] = @"";
    self.contentDic[index4] = @"";
    
}

- (void)createUI
{
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(0, SCREEN_HEIGHT - NAV_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT, SCREEN_WIDTH, 45);
    [bottomBtn setTitle:bottomText forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = FONT17;
    [bottomBtn setBackgroundColor:MAIN_COLOR];
    [bottomBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(bottomContainBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 2)
    {
        return 1;
    }
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGRentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CGRentCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    cell.titleLab.text = self.titleArr[indexPath.section][indexPath.row];
    cell.numTF1.text = self.contentDic[indexPath];
    cell.numTF1.placeholder = self.placeholderArr[indexPath.section][indexPath.row];
    [cell.numTF1 addTarget:self action:@selector(textfieldEditing:) forControlEvents:UIControlEventEditingChanged];
//    cell.numTF1.tag = indexPath.section *10 + indexPath.row;
    return cell;
    
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.0001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.frame = CGRectMake(15, 0, 100, 40);
    titleLab.text = self.sectionTitlesArr[section];
    titleLab.font = FONT16;
    titleLab.textColor = COLOR3;
    [view addSubview:titleLab];
    
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}

- (void)bottomContainBtnClick
{
    NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *index2 = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *index3 = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *index4 = [NSIndexPath indexPathForRow:0 inSection:2];
    if ([self.contentDic[index1] isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入低区最低租金" toView:self.view];
        return;
    }
    if ([self.contentDic[index2] isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入中区最低租金" toView:self.view];
        return;
    }
    if ([self.contentDic[index3] isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入中区最高租金" toView:self.view];
        return;
    }
    if ([self.contentDic[index4] isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入高区最低租金" toView:self.view];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"ucenter"] = @"app";
    param[@"setRent"] = @"act";
    param[@"pro_id"] = self.pro_id;
    param[@"lower_price"] = self.contentDic[index1];
    param[@"med_lower_price"] = self.contentDic[index2];
    param[@"med_high_price"] = self.contentDic[index3];
    param[@"high_price"] = self.contentDic[index4];
    [MBProgressHUD showMsg:@"" toView:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUDForView:self.view];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               [self.navigationController popViewControllerAnimated:YES];
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

// call this method when textfield is editing
- (void)textfieldEditing:(UITextField *)textField
{
    
    CGRentCell *cell = (CGRentCell *)textField.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    self.contentDic[index] = textField.text;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
