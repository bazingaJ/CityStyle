//
//  CGMineSettingViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineSettingViewController.h"
#import "CGMineSettingCell.h"
#import "CGMineUpdatePwdViewController.h"
#import "CGAboutUsViewController.h"

@interface CGMineSettingViewController () {
    NSMutableArray *titleArr;
}

@end

@implementation CGMineSettingViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    //设置数据源
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"mine_icon_updPwd",@"修改密码"]];
    [titleArr addObject:@[@"mine_icon_about",@"关于"]];
    
    //创建“退出”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    [btnFunc setTitle:@"退出" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [titleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGMineSettingCell";
    CGMineSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGMineSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
    [cell setMineSettingCell:itemArr];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            //修改密码
            CGMineUpdatePwdViewController *updateView = [[CGMineUpdatePwdViewController alloc] init];
            [self.navigationController pushViewController:updateView animated:YES];
            
            break;
        }
        case 1: {
            //关于
            CGAboutUsViewController *webView = [[CGAboutUsViewController alloc] init];
            [self.navigationController pushViewController:webView animated:YES];
//            NSString *about_url = [CGURLManager manager].about_url;
//            if(IsStringEmpty(about_url)) {
//                [MBProgressHUD showError:@"关于地址不能为空" toView:self.view];
//                return;
//            }
//
//            CGWKWebViewController *webView = [[CGWKWebViewController alloc] init];
//            [webView setTitle:@"关于"];
//            [webView setUrl:about_url];
//            [self.navigationController pushViewController:webView animated:YES];
            
            break;
        }
            
        default:
            break;
    }
}

/**
 *  退出
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"退出");
    
    UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"警告" message:@"您确定退出吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //清除用户本地账号信息
        [[HelperManager CreateInstance] clearAcc];
        
        //推送,用户退出,别名去掉
        [JPUSHService setAlias:@"" callbackSelector:nil object:self];
        
        //退出后跳转至首页
        [APP_DELEGATE enterMainVC];
    }];
    [aler addAction:cancelAction];
    [aler addAction:okAction];
    [self presentViewController:aler animated:YES completion:nil];
    
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
