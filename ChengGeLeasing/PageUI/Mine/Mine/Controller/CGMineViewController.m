//
//  CGMineViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineViewController.h"
#import "CGMineCell.h"
#import "CGMineSettingViewController.h"
#import "CGMineMessageViewController.h"
#import "CGMineAllCustomerViewController.h"
#import "CGMineTeamViewController.h"
#import "CGMineInfoViewController.h"
#import "CGUserModel.h"
#import "CGSpotlightView.h"
#import "CGEntManagerVC.h"
#import "CGXuFeiView.h"
#import "CGRenewPayVC.h"
#import "CGUpgradeVersionVC.h"

/**
 Word
 */
static NSString *const cellTitleText1 = @"项目及团队管理";
static NSString *const cellTitleText2 = @"我的全部客户";
static NSString *const cellTitleText3 = @"通知待办";
static NSString *const cellTitleText4 = @"VIP企业账户管理";
static NSString *const cellTitleText5 = @"设置";

@interface CGMineViewController () {
    NSMutableDictionary *titleDic;
    
    //用户信息对象
    CGUserModel *userInfo;
}

@property (nonatomic, strong) CGMineTopView *topView;
@property (nonatomic, strong) NSArray *spotlightArr;
@property (nonatomic, strong) NSString *wholeMemberNum;
@property (nonatomic, strong) NSString *endTimeStr;
@property (nonatomic, strong) KLCPopup *popup;
@end

@implementation CGMineViewController

/**
 * 懒加载
 */
-(NSArray *)spotlightArr
{
    
    if (!_spotlightArr)
    {
        _spotlightArr = @[
                          @[@{@"pic":@"mine_page1_pic1",@"frame":NSStringFromCGRect(CGRectMake(0, 190+59, 190, 60)),@"type":@"1"},
                            @{@"pic":@"mine_page1_pic2",@"frame":NSStringFromCGRect(CGRectMake(0, 190+105, 190, 60)),@"type":@"1"},
                            @{@"pic":@"mine_page1_arrow1",@"frame":NSStringFromCGRect(CGRectMake(70,120,100, 130)),@"type":@"1"},
                            @{@"pic":@"mine_page1_pic4",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-240/2, 80, 240, 20)),@"type":@"3"},
                            @{@"pic":@"mine_page1_arrow2",@"frame":NSStringFromCGRect(CGRectMake(70, 190+105+70,100, 130)),@"type":@"1"},
                            @{@"pic":@"mine_page1_pic3",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-185/2, 190+105+70+140, 185, 20)),@"type":@"1"},
                            @{@"pic":@"public_know",@"frame":NSStringFromCGRect(CGRectMake(SCREEN_WIDTH/2-130/2,190+105+70+180,130, 35)),@"type":@"2"},],];
        
    }
    return _spotlightArr;
    ;
}

/**
 *  顶部视图
 */
- (CGMineTopView *)topView
{
    if(!_topView)
    {
        _topView = [[CGMineTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, JXMineHeaderViewHeight)];
        [_topView setDelegate:self];
    }
    return _topView;
}

- (void)viewDidLoad {
    [self setBottomH:49];
    [self setLeftButtonItemHidden:YES];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    
    //创建“顶部视图”
    self.tableView.tableHeaderView = [self topView];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"mine"])
    {
//        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"mine"];
//        CGSpotlightView *spotlightVie = [[CGSpotlightView alloc]initWithFrame:self.view.bounds];
//        spotlightVie.dataArr =[self.spotlightArr mutableCopy];
//        [self.view addSubview:spotlightVie];
//        [[[UIApplication sharedApplication] keyWindow]addSubview:spotlightVie];
        
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshMyInfo:) name:@"refreshMyInfo" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //获取用户信息
    [self getUserInfo];
    [self.tableView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getVipConfigInfo];
    });
    
    
}

- (void)refreshMyInfo:(NSNotification *)noti
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //获取用户信息
        [self getUserInfo];
        [self.tableView reloadData];
    });
}

- (void)createCellContents
{
    //设置数据源
    titleDic = [NSMutableDictionary dictionary];
    
    //区块一
    NSMutableArray *titleArr1 = [NSMutableArray array];
    [titleArr1 addObject:@[@"mine_icon_team",cellTitleText1,@"0"]];
    [titleArr1 addObject:@[@"mine_icon_customer",cellTitleText2,@"0"]];
    [titleArr1 addObject:@[@"mine_icon_message",cellTitleText3,@"1"]];
    [titleDic setObject:titleArr1 forKey:@"0"];
    
    // 根据版本号 判断是否显示
    NSString *versionCode = [CGURLManager manager].auth_ios;
    if ([versionCode isEqualToString:APP_Version])
    {
        
        NSMutableArray *titleArr3 = [NSMutableArray array];
        [titleArr3 addObject:@[@"mine_icon_setting",cellTitleText5,@"0"]];
        [titleDic setObject:titleArr3 forKey:@"1"];
    }
    else
    {
        if (![[HelperManager CreateInstance] isLogin:NO completion:nil])
        {
            NSMutableArray *titleArr3 = [NSMutableArray array];
            [titleArr3 addObject:@[@"mine_icon_setting",cellTitleText5,@"0"]];
            [titleDic setObject:titleArr3 forKey:@"1"];
        }
        else
        {
            if ([HelperManager CreateInstance].isFree)
            {
                //区块三
                NSMutableArray *titleArr3 = [NSMutableArray array];
                [titleArr3 addObject:@[@"mine_icon_setting",cellTitleText5,@"0"]];
                [titleDic setObject:titleArr3 forKey:@"1"];
                
            }
            else
            {
                //区块二
                NSMutableArray *titleArr2 = [NSMutableArray array];
                [titleArr2 addObject:@[@"VIPaccout",cellTitleText4,@"0"]];
                [titleDic setObject:titleArr2 forKey:@"1"];
                
                //区块三
                NSMutableArray *titleArr3 = [NSMutableArray array];
                [titleArr3 addObject:@[@"mine_icon_setting",cellTitleText5,@"0"]];
                [titleDic setObject:titleArr3 forKey:@"2"];
            }
        }
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [titleDic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *titleArr = titleDic[@(section).stringValue];
    return titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifier = @"CGMineCell";
    CGMineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGMineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }

    
    CGUserModel *userInfo = [CGUserModel new];
    [cell setMineCellModel:userInfo indexPath:indexPath titleDic:titleDic];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:nil]) return;
    if (indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
            {
                //项目及团队管理
                CGMineTeamViewController *teamView = [[CGMineTeamViewController alloc] init];
                teamView.endDataTime = self.endTimeStr;
                teamView.account_id = userInfo.business_id;
                [self.navigationController pushViewController:teamView animated:YES];
            }
                break;
            case 1:
            {
                //我的全部客户
                CGMineAllCustomerViewController *allView = [[CGMineAllCustomerViewController alloc] init];
                [self.navigationController pushViewController:allView animated:YES];
            }
                break;
            case 2:
            {
                //通知待办
                CGMineMessageViewController *messageView = [[CGMineMessageViewController alloc] init];
                [self.navigationController pushViewController:messageView animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 1)
    {
        NSString *versionCode = [CGURLManager manager].auth_ios;
        if ([versionCode isEqualToString:APP_Version])
        {
            //设置
            CGMineSettingViewController *settingView = [[CGMineSettingViewController alloc] init];
            [self.navigationController pushViewController:settingView animated:YES];
        }
        else
        {
            if ([HelperManager CreateInstance].isFree)
            {
                //设置
                CGMineSettingViewController *settingView = [[CGMineSettingViewController alloc] init];
                [self.navigationController pushViewController:settingView animated:YES];
            }
            else
            {
                // VIP企业账户管理
                CGEntManagerVC *vc = [CGEntManagerVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
    }
    else
    {
        //设置
        CGMineSettingViewController *settingView = [[CGMineSettingViewController alloc] init];
        [self.navigationController pushViewController:settingView animated:YES];
    }
    
}

/**
 *  编辑按钮委托代理
 */
- (void)CGMineTopViewEditInfoClick:(NSInteger)tIndex {
    NSLog(@"编辑按钮委托代理");
    
    //登录验证
    if(![[HelperManager CreateInstance] isLogin:NO completion:^(NSInteger tIndex) {
        //获取信息
        [self getUserInfo];
    }]) return;
    
    
    switch (tIndex) {
        case 0: {
            //编辑信息
            CGMineInfoViewController *infoView = [[CGMineInfoViewController alloc] init];
            infoView.userInfo = userInfo;
            infoView.callBack = ^(CGUserModel *model) {
                NSLog(@"用户信息回调成功");
                
                userInfo = model;
                
                //设置头部信息
                [_topView setMineTopModel:userInfo];
                
            };
            [self.navigationController pushViewController:infoView animated:YES];
            
            break;
        }
        case 1: {
            //点击头像放大
            NSMutableArray *imgArr = [NSMutableArray array];
            [imgArr removeAllObjects];
            ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
            photo.photoURL = [NSURL URLWithString:userInfo.avatar];
            [imgArr addObject:photo];
            
            // 图片游览器
            ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
            // 淡入淡出效果
            pickerBrowser.status = UIViewAnimationAnimationStatusFade;
            // 数据源/delegate
            pickerBrowser.photos = imgArr;
            // 能够删除
            pickerBrowser.delegate = self;
            // 当前选中的值
            pickerBrowser.currentIndex = 0;
            // 展示控制器
            [pickerBrowser showPickerVc:self];
            
            break;
        }
            
        default:
            break;
    }
}

/**
 *  获取用户信息
 */
- (void)getUserInfo {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getMyInfo" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].user_id forKey:@"user_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSLog(@"---获取用户信息%@",json);
            NSDictionary *dataDic = [json objectForKey:@"data"];
            userInfo = [CGUserModel mj_objectWithKeyValues:dataDic];
            
            self.wholeMemberNum = dataDic[@"member_num"];
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dataDic[@"end_time"] integerValue]];
            self.endTimeStr = [format stringFromDate:date];
            
            //预先清除
            [[HelperManager CreateInstance] clearAcc];
            //设置本地缓存
            [self setUserDefaultInfo:dataDic];
            
            [titleDic removeAllObjects];
            [self createCellContents];
            [self.topView setMineTopModel:userInfo];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
}
/**
 获取VIP配置信息
 */
- (void)getVipConfigInfo
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"ucenter";
    param[@"act"] = @"getVipConfig";
    
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               NSDictionary *dict = [json objectForKey:@"data"];
                               NSArray *listArr = dict[@"list"];
                               
                               NSDictionary *dic1 = [listArr firstObject];
                               if ([dic1[@"vip_id"] isEqualToString:@"1"])
                               {
                                   [self saveFreeConfig:dic1];
                               }
                               else
                               {
                                   [self saveVipConfig:dic1];
                               }
                               NSDictionary *dic2 = [listArr lastObject];
                               if ([dic2[@"vip_id"] isEqualToString:@"1"])
                               {
                                   [self saveFreeConfig:dic2];
                               }
                               else
                               {
                                   [self saveVipConfig:dic2];
                               }
                               
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
- (void)saveFreeConfig:(NSDictionary *)dict
{
    NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
    [us setObject:dict[@"cate_num"] forKey:@"free_cate_num"];
    [us setObject:dict[@"name"] forKey:@"free_name"];
    [us setObject:dict[@"pos_num"] forKey:@"free_pos_num"];
    [us setObject:dict[@"price"] forKey:@"free_price"];
    [us setObject:dict[@"pro_num"] forKey:@"free_pro_num"];
    [us setObject:dict[@"sky_drive_num"] forKey:@"free_sky_drive_num"];
    [us setObject:dict[@"user_num"] forKey:@"free_user_num"];
    [us setObject:dict[@"vip_id"] forKey:@"free_vip_id"];
    [us synchronize];
}

- (void)saveVipConfig:(NSDictionary *)dict
{
    NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
    [us setObject:dict[@"cate_num"] forKey:@"vip_cate_num"];
    [us setObject:dict[@"name"] forKey:@"vip_name"];
    [us setObject:dict[@"pos_num"] forKey:@"vip_pos_num"];
    [us setObject:dict[@"price"] forKey:@"vip_price"];
    [us setObject:dict[@"pro_num"] forKey:@"vip_pro_num"];
    [us setObject:dict[@"sky_drive_num"] forKey:@"vip_sky_drive_num"];
    [us setObject:dict[@"user_num"] forKey:@"vip_user_num"];
    [us setObject:dict[@"vip_id"] forKey:@"vip_vip_id"];
    [us synchronize];
}
// 点击VIP标志和剩余时间 弹出弹窗
- (void)showXuFeiWindow
{
    
    NSString *versionCode = [CGURLManager manager].auth_ios;
    if ([versionCode isEqualToString:APP_Version])
    {
        
        return;
    }
    
    
    //    会员已过期，没有权限操作
    NSArray *endTimeArr = [self.endTimeStr componentsSeparatedByString:@"-"];
    NSString *wholeStr = [NSString stringWithFormat:@"您的VIP企业版\n将于%@年%@月%@日到期\n请尽快续费。",endTimeArr[0],endTimeArr[1],endTimeArr[2]];
    CGXuFeiView *view = [[CGXuFeiView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 275, 240) contentStr:wholeStr];
    view.clickCallBack = ^(NSInteger tIndex) {
        [self.popup dismiss:YES];
        if (tIndex == 0 || tIndex == 1)
        {
            return ;
        }
        else
        {
            CGRenewPayVC *vc = [CGRenewPayVC new];
            vc.wholeSeats = self.wholeMemberNum;
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    self.popup = [KLCPopup popupWithContentView:view
                                       showType:KLCPopupShowTypeGrowIn
                                    dismissType:KLCPopupDismissTypeGrowOut
                                       maskType:KLCPopupMaskTypeDimmed
                       dismissOnBackgroundTouch:NO
                          dismissOnContentTouch:NO];
    [self.popup show];
    

}

- (void)showUpdateWindow
{
    NSString *versionCode = [CGURLManager manager].auth_ios;
    if ([versionCode isEqualToString:APP_Version])
    {
        
        return;
    }
    
    // 判断是否是曾经的vip 还是 从来都不是vip
    if (userInfo.business_id == nil || [userInfo.business_id isEqualToString:@""])  // 从来不是
    {
        CGUpgradeVersionVC *updateVC = [CGUpgradeVersionVC new];
        [self.navigationController pushViewController:updateVC animated:YES];
    }
    else  // 曾经是vip
    {
        
        CGRenewPayVC *vc = [CGRenewPayVC new];
        vc.wholeSeats = self.wholeMemberNum;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

@end
