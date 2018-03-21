//
//  CGWorkBriefingViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/12.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGWorkBriefingViewController.h"
#import "CGWorkBriefingModel.h"
#import "CGDropDownMenu.h"
#import "CGWorkBriefingCell.h"

@interface CGWorkBriefingViewController ()

@property (nonatomic, strong) NSString *cate_id;
@property (nonatomic, strong) NSString *date_id;
@property (nonatomic, strong) NSString *member_id;
//@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) CGDropDownMenu *dropDownMenu;

@end

@implementation CGWorkBriefingViewController

//-(NSMutableArray *)dataArr
//{
//    if (!_dataArr)
//    {
//        _dataArr = [NSMutableArray array];
//    }
//    return _dataArr;
//}
//
////创建"招租报表"
//-(void)setUpView
//{
//    NSArray *imageArr =@[@"home_newcustnum_workbriefing_icon",
//                         @"home_newlxr_workbriefing_icon",
//                         @"home_newsign_workbriefing_icon",
//                         @"home_newsx_workbriefing_icon",
//                         @"home_bfkhs_workbriefing_icon",
//                         @"home_yxkhbh_workbriefing_icon"];
//    NSArray *titleArr =@[@"新增客户数",
//                         @"新增联系人",
//                         @"新签约客户",
//                         @"新增事项",
//                         @"拜访客户数",
//                         @"意向变化客户"];
//    //创建"背景"
//    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(10, 55, SCREEN_WIDTH-20, 320)];
//    bgView.layer.cornerRadius = 5;
//    bgView.clipsToBounds =YES;
//    bgView.backgroundColor = WHITE_COLOR;
//    [self.view addSubview:bgView];
//
//    for (int i=0; i<6; i++)
//    {
//        UIView *itemView =[[UIView alloc]initWithFrame:CGRectMake(i%2*(bgView.width/2), i/2*106, bgView.width/2, 106)];
//        itemView.backgroundColor = [UIColor whiteColor];
//        [bgView addSubview:itemView];
//
//        //创建"图标"
//        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 30, 106)];
//        imageView.contentMode = UIViewContentModeCenter;
//        imageView.image = [UIImage imageNamed:imageArr[i]];
//        [itemView addSubview:imageView];
//
//        //创建"大写客户数"
//        UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right +15, 25, 0, 25)];
//        lbMsg.font = SYSTEM_FONT_SIZE(40);
//        lbMsg.textColor = COLOR3;
//        lbMsg.tag = 20+i;
//        [itemView addSubview:lbMsg];
//
//        //创建个数
//        UILabel *lbMsg2 =[[UILabel alloc]initWithFrame:CGRectMake(lbMsg.right+10, 45, 20, 15)];
//        lbMsg2.font = FONT15;
//        lbMsg2.textColor = COLOR3;
//        lbMsg2.tag = 30+i;
//        [itemView addSubview:lbMsg2];
//
//        //创建"标题"
//        UILabel *lbMsg3 = [[UILabel alloc]initWithFrame:CGRectMake(lbMsg.left, 70, 140, 20)];
//        lbMsg3.text = titleArr[i];
//        lbMsg3.textColor = COLOR3;
//        lbMsg3.font = FONT15;
//        [itemView addSubview:lbMsg3];
//    }
//}

- (void)viewDidLoad {
    [self setTopH:45];
    [super viewDidLoad];

    self.title = @"工作简报";
    
    if ([self.fromWhere isEqualToString:@"1"]) {
        //创建“筛选框”
        NSMutableArray *titleArr = [NSMutableArray array];
        [titleArr addObject:@[@"全部时间",@"3000"]];
        [titleArr addObject:@[@"全部业态",@"301"]];
        self.dropDownMenu = [[CGDropDownMenu alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) titleArr:titleArr];
        WS(weakSelf);
        self.dropDownMenu.callTimeBack = ^(NSString *time_id, NSString *time_name) {
            NSLog(@"当前时间：%@-%@",time_id,time_name);
            weakSelf.date_id = time_id;
            //[weakSelf getLetReportWithBulletin];
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        self.dropDownMenu.callFormatBack = ^(NSString *cate_id, NSString *cate_name) {
            NSLog(@"业态回调成功：%@-%@",cate_id,cate_name);
            weakSelf.cate_id = cate_id;
            //[weakSelf getLetReportWithBulletin];
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        [self.view addSubview:self.dropDownMenu];
    }else{
        //创建“筛选框”
        NSMutableArray *titleArr = [NSMutableArray array];
        [titleArr addObject:@[@"全部时间",@"3000"]];
        [titleArr addObject:@[@"全部业态",@"301"]];
        [titleArr addObject:@[@"业务员",@"200"]];
        WS(weakSelf);
        self.dropDownMenu = [[CGDropDownMenu alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) titleArr:titleArr];
        self.dropDownMenu.callTimeBack = ^(NSString *time_id, NSString *time_name) {
            NSLog(@"当前时间：%@-%@",time_id,time_name);
            weakSelf.date_id = time_id;
            //[weakSelf getLetReportWithBulletin];
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        self.dropDownMenu.callFormatBack = ^(NSString *cate_id, NSString *cate_name) {
            NSLog(@"业态回调成功：%@-%@",cate_id,cate_name);
            weakSelf.cate_id = cate_id;
            //[weakSelf getLetReportWithBulletin];
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        self.dropDownMenu.callTeamMemberBack = ^(NSString *member_id, NSString *member_name) {
            NSLog(@"业务员回调成功:%@-%@",member_id,member_name);
            weakSelf.member_id = member_id;
            //[weakSelf getLetReportWithBulletin];
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        [self.view addSubview:self.dropDownMenu];
    }
    
    //[self setUpView];
    
//    //获取数据
//    [self getLetReportWithBulletin];
}

-(void)leftButtonItemClick
{
    [super leftButtonItemClick];
    [self.dropDownMenu dismiss];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGWorkBriefingCell";
    CGWorkBriefingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGWorkBriefingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGWorkBriefingModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setWorkBriefingModel:model];
    
    return cell;
}

//- (void)relodData {
//    for (int i=0; i<6; i++)
//    {
//        UILabel *lbMsg =(UILabel*)[self.view viewWithTag:20+i];
//        CGWorkBriefingModel *model =[self.dataArr objectAtIndex:i];
//        [lbMsg setText:model.count];
//        [lbMsg sizeToFit];
//
//        UILabel *lbMsg1 = (UILabel*)[self.view viewWithTag:30+i];
//        lbMsg1.frame = CGRectMake(lbMsg.right+5, 45, 20, 15);
//        lbMsg1.text = @"个";
//    }
//}

////获取工作简报
//-(void)getLetReportWithBulletin
//{
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:@"home" forKey:@"app"];
//    [param setValue:@"getLetReportWithBulletin" forKey:@"act"];
//    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
//    [param setValue:self.fromWhere forKey:@"type"];
//    [param setValue:self.date_id forKey:@"timeInterval"];
//    [param setValue:self.cate_id forKey:@"cate_id"];
//    [param setValue:self.member_id forKey:@"member"];
//    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
//    {
//        NSString *code =[json objectForKey:@"code"];
//        if ([code isEqualToString:SUCCESS])
//        {
//            self.dataArr = [CGWorkBriefingModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
//            [self relodData];
//        }
//        else
//        {
//            [MBProgressHUD showError:json[@"msg"] toView:self.view];
//        }
//    } failure:^(NSError *error)
//    {
//
//    }];
//}

/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getLetReportWithBulletin" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.fromWhere forKey:@"type"];
    [param setValue:self.date_id forKey:@"timeInterval"];
    [param setValue:self.cate_id forKey:@"cate_id"];
    [param setValue:self.member_id forKey:@"member"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code =[json objectForKey:@"code"];
        if ([code isEqualToString:SUCCESS]) {
            NSArray *dataList = [CGWorkBriefingModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            
            NSMutableArray *titleArr = [NSMutableArray array];
            [titleArr addObject:@[@"home_newcustnum_workbriefing_icon",@"新增客户数",@"1"]];
            [titleArr addObject:@[@"home_newsign_workbriefing_icon",@"新签约客户",@"3"]];
            [titleArr addObject:@[@"home_bfkhs_workbriefing_icon",@"拜访客户数",@"5"]];
            [titleArr addObject:@[@"home_newsx_workbriefing_icon",@"新增事项",@"4"]];
            [titleArr addObject:@[@"home_newlxr_workbriefing_icon",@"新增联系人",@"2"]];
            [titleArr addObject:@[@"home_yxkhbh_workbriefing_icon",@"意向变化客户",@"6"]];
            for (int k=0; k<[titleArr count]; k++) {
                NSArray *itemArr = [titleArr objectAtIndex:k];
                for (int i=0; i<dataList.count; i++) {
                    CGWorkBriefingModel *model = [dataList objectAtIndex:i];
                    if([model.type isEqualToString:itemArr[2]]) {
                        model.icon = itemArr[0];
                        //是否选择了时间
                        if(!IsStringEmpty(self.date_id) && [self.date_id integerValue]>0) {
                            model.isTime = YES;
                        }
                        //是否选择了业务员
                        if(!IsStringEmpty(self.member_id) && [self.member_id integerValue]>0) {
                            model.isMem = YES;
                        }
                        if([self.fromWhere isEqualToString:@"1"]) {
                            //我的
                            model.isMine = YES;
                        }
                        [self.dataArr addObject:model];
                        break;
                    }
                }
            }
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        [self endDataRefresh];
    }];
}

@end
