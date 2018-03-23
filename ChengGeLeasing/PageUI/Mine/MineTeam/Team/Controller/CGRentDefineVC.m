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
    cell.numTF1.placeholder = self.placeholderArr[indexPath.section][indexPath.row];
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
    
    [MBProgressHUD showMessage:@"确定" toView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
