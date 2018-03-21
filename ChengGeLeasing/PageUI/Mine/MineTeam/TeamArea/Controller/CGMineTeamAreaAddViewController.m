//
//  CGMineTeamAreaAddViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamAreaAddViewController.h"

@interface CGMineTeamAreaAddViewController () {
    NSString *nameStr;
}

@property (nonatomic, strong) UITextField *tbxContent;

@end

@implementation CGMineTeamAreaAddViewController

- (void)viewDidLoad {
    [self setRightButtonItemTitle:@"保存"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"新增区域";
    
    self.view.backgroundColor = BACK_COLOR;
    
    if(self.areaInfo) {
        nameStr = self.areaInfo.name;
    }
    
    //创建“背景层”
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    [backView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:backView];
    
    //创建“区域数据框”
    self.tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 25)];
    [self.tbxContent setPlaceholder:@"例如F-001、珠江路5号"];
    [self.tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
    [self.tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
    [self.tbxContent setTextColor:COLOR3];
    [self.tbxContent setTextAlignment:NSTextAlignmentLeft];
    [self.tbxContent setFont:FONT16];
    [self.tbxContent setText:nameStr];
    [self.tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [backView addSubview:self.tbxContent];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //弹出键盘
    [self.tbxContent becomeFirstResponder];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)textFieldDidChange:(UITextField *)textField {
    nameStr = textField.text;
}

/**
 *  保存按钮事件
 */
- (void)rightButtonItemClick {
    NSLog(@"保存");
    [self.view endEditing:YES];
    
    //区域名称验证
    if(IsStringEmpty(nameStr)) {
        [MBProgressHUD showError:@"请输入区域名称" toView:self.view];
        return;
    }else if([NSString stringContainsEmoji:nameStr]) {
        [MBProgressHUD showError:@"区域名称不能包含表情" toView:self.view];
        return;
    }if([nameStr length]>30) {
        [MBProgressHUD showError:@"区域名称不能超过30个字符" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMsg:@"保存中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"editPosGroup" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [param setValue:self.areaInfo.id forKey:@"group_id"];//修改时用
    [param setValue:nameStr forKey:@"name"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"新增区域成功" toView:self.view];
            
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
