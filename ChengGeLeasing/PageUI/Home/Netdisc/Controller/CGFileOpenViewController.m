//
//  CGFileOpenViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/2/9.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGFileOpenViewController.h"

@interface CGFileOpenViewController ()<UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) UIDocumentInteractionController *documentController;

@end

@implementation CGFileOpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建“图表”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, 25, 60, 80)];
    [imgView setImage:[UIImage imageNamed:@"empty_file_white"]];
    [self.view addSubview:imgView];
    
    //创建“文件名称”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 125, SCREEN_WIDTH-20, 20)];
    [lbMsg setText:self.title];
    [lbMsg setTextColor:[UIColor blackColor]];
    [lbMsg setTextAlignment:NSTextAlignmentCenter];
    [lbMsg setFont:FONT17];
    [self.view addSubview:lbMsg];
    
    //创建”按钮“
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(20, 160, SCREEN_WIDTH-40, 45)];
    [btnFunc setTitle:@"用其他应用打开" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT18];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc.layer setCornerRadius:4.0];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
    for (int i=0; i<2; i++) {
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 220+20*i, SCREEN_WIDTH-20, 20)];
        if(i==0) {
            [lbMsg setText:@"城格租赁暂不可以打开此类文件"];
        }else if(i==1) {
            [lbMsg setText:@"可使用其他应用打开并预览"];
        }
        [lbMsg setTextColor:COLOR9];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setFont:FONT14];
        [self.view addSubview:lbMsg];
    }

}

/**
 *  打开按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"打开");
    
    //NSString *cachePath = [[NSBundle mainBundle] pathForResource:@"铺装.dwg" ofType:nil ];
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:self.fileURL]];
    self.documentController.delegate = self;
    BOOL canOpen = [self.documentController presentOpenInMenuFromRect:self.view.bounds
                                                               inView:self.view
                                                             animated:YES];
    // 返回NO说明没有可以打开该文件的应用
    if (!canOpen) {
        UIAlertController * aler = [UIAlertController alertControllerWithTitle:@"提醒" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"返回");
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定");
            
        }];
        [aler addAction:cancelAction];
        [aler addAction:okAction];
        [self presentViewController:aler animated:YES completion:nil];
    }
    
}

#pragma mark- UIDocumentInteractionController 代理方法
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
    
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return self.view;
    
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
    return self.view.bounds;
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application {
    //将要发送的应用
    
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application {
    //已经发送的应用
}


- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller {
    
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
