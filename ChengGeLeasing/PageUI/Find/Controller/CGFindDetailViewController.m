//
//  CGFindDetailViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGFindDetailViewController.h"
#import "RCSegmentExView.h"
#import "CGFindBrandContactViewController.h"
#import "CGFindBrandDetailViewController.h"
#import "CGFindAddToCustomerViewController.h"

@interface CGFindDetailViewController ()

@property (nonatomic, strong) CGFindBrandContactViewController *contactView;
@property (nonatomic, strong) CGFindBrandDetailViewController *detailView;

@end

@implementation CGFindDetailViewController

/**
 *  联系人
 */
- (CGFindBrandContactViewController *)contactView {
    if(!_contactView) {
        _contactView = [[CGFindBrandContactViewController alloc] init];
        _contactView.find_id = self.findModel.brand_id;
    }
    return _contactView;
}

/**
 *  品牌档案
 */
- (CGFindBrandDetailViewController *)detailView {
    if(!_detailView) {
        _detailView = [[CGFindBrandDetailViewController alloc] init];
        _detailView.find_id = self.findModel.brand_id;
    }
    return _detailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"品牌详情";
    
    //创建“顶部视图”
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    [backView setBackgroundColor:NAV_COLOR];
    [self.view addSubview:backView];
    
    //创建“头像”
    NSString *imgURL = self.findModel.img_url;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [imgView setClipsToBounds:YES];
    [imgView.layer setCornerRadius:4.0];
    [imgView.layer setMasksToBounds:YES];
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
    [backView addSubview:imgView];
    
    //创建“名称”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(70, 25, backView.frame.size.width-120, 20)];
    [lbMsg setText:self.findModel.name];
    [lbMsg setTextColor:[UIColor whiteColor]];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [backView addSubview:lbMsg];
    
    //创建“加为客户”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(backView.frame.size.width-40, 25, 30, 20)];
    [btnFunc setImage:[UIImage imageNamed:@"customer_add_white"] forState:UIControlStateNormal];
    [btnFunc addTouch:^{
        NSLog(@"加为客户");
        
        //登录验证
        if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
        
        CGFindAddToCustomerViewController *customerView = [[CGFindAddToCustomerViewController alloc] init];
        customerView.old_id = self.findModel.brand_id;
        [self.navigationController pushViewController:customerView animated:YES];
        
    }];
    [backView addSubview:btnFunc];
    
    NSArray *controllers = @[[self contactView],[self detailView]];
    
    NSArray *titleArr =@[@"联系人",@"品牌档案"];
    RCSegmentExView *segmentView = [[RCSegmentExView alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-70) controllers:controllers titleArray:titleArr ParentController:self with:0];
    segmentView.segmentScrollV.scrollEnabled = NO;
    [self.view addSubview:segmentView];
    
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
