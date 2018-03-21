//
//  CGMineAllCustomerViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineAllCustomerViewController.h"
#import "RCSegmentView.h"
#import "CGMineXiangmuCustomerViewController.h"
#import "CGMineChuBeiCustomerViewController.h"
#import "CGMineCustomerAddViewController.h"
#import "CGFindViewController.h"

@interface CGMineAllCustomerViewController () {
    NSInteger segmentIndex;
    NSString * chuBeiKeHuID;
}

@property (nonatomic, strong) CGMineXiangmuCustomerViewController *xiangmuCus;
@property (nonatomic, strong) CGMineChuBeiCustomerViewController *chubeiCus;

@end

@implementation CGMineAllCustomerViewController

/**
 *  项目客户
 */
- (CGMineXiangmuCustomerViewController *)xiangmuCus {
    if(!_xiangmuCus) {
        _xiangmuCus = [[CGMineXiangmuCustomerViewController alloc] init];
    }
    return _xiangmuCus;
}

/**
 *  储备客户
 */
- (CGMineChuBeiCustomerViewController *)chubeiCus {
    if(!_chubeiCus) {
        _chubeiCus = [[CGMineChuBeiCustomerViewController alloc] init];
    }
    return _chubeiCus;
}

- (void)viewDidLoad {
    [self setRightButtonItemImageName:@"mine_add_customer"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的全部客户";
    
    //设置默认值
    segmentIndex = 0;
    
    NSArray *controllers = @[[self xiangmuCus],[self chubeiCus]];
    
    NSArray *titleArr =@[@"项目客户",@"储备客户"];
    RCSegmentView *segmentView = [[RCSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT) controllers:controllers titleArray:titleArr ParentController:self with:0];
    segmentView.segmentScrollV.scrollEnabled = NO;
    segmentView.callBack = ^(NSInteger tIndex)
    {
        NSLog(@"当前索引:%zd",tIndex);
        segmentIndex = tIndex;
    };
    [self.view addSubview:segmentView];
    
    //获取储备客户id
    [self getChuBeiKeHuID];

}

/**
 *  返回按钮事件
 */
- (void)leftButtonItemClick {
    [super leftButtonItemClick];
    
    if(segmentIndex==0)
    {
        //项目客户
        [self.xiangmuCus.topView dismiss];
    }
    else if(segmentIndex==1)
    {
        //储备客户
        [self.chubeiCus.topView dismiss];
    }
}

/**
 *  新增客户
 */
- (void)rightButtonItemClick
{
    NSLog(@"新增客户");
    UIAlertController *alertController = [[UIAlertController alloc] init];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"新增客户" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"新增客户");
        
        CGMineCustomerAddViewController *addView = [[CGMineCustomerAddViewController alloc] init];
        if (segmentIndex ==1)
        {
//            说明是储备客户
            addView.chuBeiKeHuID = chuBeiKeHuID;
        }
        [self.navigationController pushViewController:addView animated:YES];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从品牌资源库添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"从品牌资源库添加");
        
        CGFindViewController *findView = [[CGFindViewController alloc] init];
        findView.title = @"品牌资源库";
        findView.isAdd = YES;
        if (segmentIndex ==1)
        {
            //            说明是储备客户
            findView.chuBeiKeHuID = chuBeiKeHuID;
        }
        [self.navigationController pushViewController:findView animated:YES];

        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)getChuBeiKeHuID
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getTrunkCateList" forKey:@"act"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
    {
        NSString *code = json[@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            chuBeiKeHuID = json[@"data"][@"pro_id"];
        }
        
    } failure:^(NSError *error) {
        
    }];

}

@end
