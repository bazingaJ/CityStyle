//
//  CGMemberContactVC.m
//  ChengGeLeasing
//
//  Created by yunduopu-ios-2 on 2018/3/27.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGMemberContactVC.h"
#import "CGMineSearchBarView.h"
#import "CGMineTeamMemberContactCell.h"
#import <MessageUI/MessageUI.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBookDefines.h>
#import <AddressBook/ABRecord.h>
#import "CGTeamMemberModel.h"
#import "CGContactCell.h"

@interface CGMemberContactVC ()<CGMineSearchBarViewDelegate,
                                MFMessageComposeViewControllerDelegate,
                                JXContactDelegate>
{
    //搜索关键词
    NSString *keywordsStr;
}
@property (nonatomic, strong) CGMineSearchBarView *searchView;
@end

@implementation CGMemberContactVC

- (void)viewDidLoad {
    
    [self setTopH:45];
    [super viewDidLoad];
    self.title = @"手机通讯录";
    //创建“搜索框”
    [self searchView];
    if ([[UIDevice currentDevice].systemVersion floatValue]>=9.0)
    {
        CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authorizationStatus == CNAuthorizationStatusNotDetermined)
        {
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (!granted)
                {
                    NSLog(@"授权失败, error=%@", error);
                }
            }];
        }
    }
}

/**
 *  返回按钮事件
 */
- (void)leftButtonItemClick {
    
    [super leftButtonItemClick];
    [self.searchView.searchBar resignFirstResponder];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 75.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"CGContactCell1";
    
    CGContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CGContactCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    
    CGContactModel *model = [self.dataArr objectAtIndex:indexPath.row];
    cell.delegate = self;
    cell.model = model;
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.searchView.searchBar resignFirstResponder];
}

/**
 *  搜索委托代理
 */
- (void)CGMineSearchBarViewClick:(NSString *)searchStr
{
    NSLog(@"搜索委托代理");
    
    keywordsStr = searchStr;
    
    //获取数据源
    [self.dataArr removeAllObjects];
    
    //清空界面
    [self.tableView beginUpdates];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    
    //刷新
    [self getDataList:NO];
    
}

/**
 *  邀请委托代理
 */
- (void)CGMineTeamMemberMobileCellClick:(UIButton *)btnFunc model:(CGTeamMemberModel *)model {
    NSLog(@"邀请委托代理");
    
    switch (btnFunc.tag) {
        case 100: {
            //邀请
            //程序内调用系统发短信
            [self showMessageView:[NSArray arrayWithObjects:model.mobile, nil] title:model.name body:@"我邀请你加入商业不动产租赁管家——城格租赁 ，点击链接下载http://t.cn/RXidqzh"];
            
            break;
        }
        case 200: {
            //添加
//            [self.selecteArr addObject:model];
            break;
        }
            
        default:
            break;
    }
    
}
/**
 *  获取数据源
 */
- (void)getDataList:(BOOL)isMore {
    
    CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (authorizationStatus == CNAuthorizationStatusAuthorized)
    {
        NSLog(@"没有授权...");
    }
    
    // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    NSMutableArray *mobileArr = [NSMutableArray array];
    
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        NSString *givenName = contact.givenName;
        NSString *familyName = contact.familyName;
        NSArray *telName = contact.phoneNumbers;
        NSLog(@"givenName=%@, familyName=%@, telephone=%@", givenName, familyName,telName);
        
        NSString *nameStr = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
        
        CGContactModel *model = [CGContactModel new];
        model.name = nameStr;
        
        NSArray *phoneNumbers = contact.phoneNumbers;
        for (CNLabeledValue *labelValue in phoneNumbers) {
            
            // 获取电话号码的KEY
            //NSString *phoneLabel = labelValue.label;
            
            // 获取电话号码
            CNPhoneNumber *phoneNumer = labelValue.value;
            NSString *phoneValue = phoneNumer.stringValue;
            
            model.mobileStr = phoneValue;
            model.mobile = [phoneValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
            [mobileArr addObject:model.mobile];
            [self.dataArr addObject:model];
        }
    }];
    [self.tableView reloadData];
    //根据根据判断状态
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"mailList" forKey:@"act"];
    [param setValue:[mobileArr componentsJoinedByString:@","] forKey:@"mobile"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
     {
         NSString *code = [json objectForKey:@"code"];
         if([code isEqualToString:SUCCESS])
         {
             NSArray *dataList = [json objectForKey:@"data"];
             if(dataList && dataList.count>=1) {

                 for (int i=0; i<dataList.count; i++)
                 {
                     NSDictionary *dataDic =  [dataList objectAtIndex:i];

                     for (CGContactModel *model in self.dataArr)
                     {
                         model.mobile = [model.mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
                         if ([model.mobile isEqualToString:dataDic[@"mobile"]])
                         {
                             model.isIn =@"1";
                             model.user_id = dataDic[@"id"];
                             model.name = dataDic[@"name"];
                             model.avatar = dataDic[@"avatar"];
                         }
                     }
                 }
    
////                 循环是否添加
//                 for (CGContactModel *model in self.dataArr)
//                 {
//                     for (CGTeamMemberModel *selectedModel in self.selecteArr)
//                     {
//                         if (!IsStringEmpty(model.user_id))
//                         {
//                             if ([selectedModel.user_id isEqualToString:model.user_id])
//                             {
//                                 model.isAdd =YES;
//                             }
//                         }
//
//                     }
//                 }

                 [self.tableView reloadData];
             }
         }
     } failure:^(NSError *error) {

     }];

        NSDictionary *dataDic = [HttpRequestEx getSyncWidthURL:SERVICE_URL param:param];
        NSString *code = [dataDic objectForKey:@"code"];
        if([code isEqualToString:SUCCESS])
        {
            NSArray *dataList = [dataDic objectForKey:@"data"];
            if(dataList && dataList.count>=1) {
    
                for (NSDictionary *dataDic in dataList)
                {
                    [self.dataArr addObject:[CGContactModel mj_objectWithKeyValues:dataDic]];
                }
    
                CGContactModel *contactModel = [CGContactModel mj_objectWithKeyValues:dataList[0]];
    //            model.id = contactModel.id;
    //            model.isIn = contactModel.isIn;
    //            model.avatar = contactModel.avatar;
    //            model.id = contactModel.id;
            }
        }
    
    
    [self.tableView reloadData];
    [self endDataRefresh];
}
-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent: {
            NSLog(@"信息传送成功");
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"信息传送成功" toView:self.view];
            });
            
            break;
        }
        case MessageComposeResultFailed: {
            NSLog(@"信息传送失败");
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"信息传送失败" toView:self.view];
            });
            
            break;
        }
        case MessageComposeResultCancelled: {
            NSLog(@"信息被用户取消传送");
            
            break;
        }
            
        default:
            break;
    }
    
}

// 邀请按钮点击事件
- (void)invateBtnClick:(UIButton *)button
{
    
}

/**
 *  懒加载搜索框
 */
- (CGMineSearchBarView *)searchView {
    if(!_searchView) {
        _searchView = [[CGMineSearchBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [_searchView setDelegate:self];
        [self.view addSubview:_searchView];
    }
    return _searchView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
