//
//  CGShopLeaseItemViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGShopLeaseItemViewController.h"
#import "CGShopLeaseItemCell.h"
#import "CGLeaseMattersAddViewController.h"
#import "CGCustomerDetailViewController.h"
@interface CGShopLeaseItemViewController ()

@property (nonatomic, strong) CGShopBusinessMattersModel *model;

@end

@implementation CGShopLeaseItemViewController



//创建"底部按钮"
- (void)createBottomBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-90, SCREEN_WIDTH, 45);
    btn.backgroundColor = UIColorFromRGBWith16HEX(0x789BD4);
    [btn setTitle:@"添加招租事项" forState:UIControlStateNormal];
    [btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    //创建"底部按钮
//    if ([self.is_mine isEqualToString:@"2"])
//    {
//        self.tableView.height =SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT -45;
//    }
//    else
//    {
//        [self createBottomBtn];
//         self.tableView.height =SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT -45-45;
//    }
   

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //获取数据
    [self.tableView.mj_header beginRefreshing];
}

-(void)addBtnClick
{
    CGLeaseMattersAddViewController *addLeaseView =[[CGLeaseMattersAddViewController alloc]init];
    addLeaseView.type =1;
    addLeaseView.pos_id = self.pos_id;
    [self.navigationController pushViewController:addLeaseView animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0)
    {
        return 4;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0)
    {
        return 10;
    }
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {
        return 45;
    }else if(indexPath.section==1) {
        //当前租户
        return 120;
    }
    else if (indexPath.section ==2)
    {
        return self.model.sectionH2;
    }
    else if (indexPath.section ==3)
    {
        return self.model.sectionH3;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView;
    
    if (section >0)
    {
        headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
 
        //创建"蓝色竖条"
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 23/2, 5, 22)];
        lineView.backgroundColor = UIColorFromRGBWith16HEX(0x7D9ACE);
        [headView addSubview:lineView];
        
        //创建"标题"
        UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 45)];
        lbMsg.font = FONT15;
        lbMsg.textColor = COLOR3;
        lbMsg.text = @[@"当前租户",@"意向租户",@"历史租户"][section-1];
        [headView addSubview:lbMsg];
    }
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGShopBusinessMattersCell";
    CGShopLeaseItemCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell =[[CGShopLeaseItemCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.callBackRelodData = ^{
        [self.tableView reloadData];
    };
    
    //跳转招租事项列表
    cell.callCollectionBack = ^(CGShopBusinessMattersIntentModel *intentModel, CGShopBusinessMattersHistoryListModel *historyModel, CGShopBusinessMattersModel *matterModel, NSInteger tag) {
      
        CGCustomerDetailViewController *detailView = [[CGCustomerDetailViewController alloc] init];
        //客户详情
        if (tag ==100)
        {
            //意向租户
            [detailView setTitle:intentModel.name];
            detailView.cust_id = intentModel.id;
            detailView.isMine = intentModel.is_own;
            detailView.cust_cover = intentModel.logo;
            if ([intentModel.intent isEqualToString:@"90"] ||[intentModel.intent isEqualToString:@"100"]) {
                detailView.isSign = YES;
            }
        }
        else if(tag==200)
        {
            //历史租户
            [detailView setTitle:historyModel.name];
            detailView.cust_id = historyModel.id;
            detailView.isMine = historyModel.is_own;
            detailView.cust_cover = historyModel.logo;
            if ([historyModel.intent isEqualToString:@"90"] ||[historyModel.intent isEqualToString:@"100"])
            {
                detailView.isSign = YES;
            }
        }else if(tag==300) {
            //当前租户
            [detailView setTitle:matterModel.sign_cust_name];
            detailView.cust_id = matterModel.sign_cust_id;
            detailView.isMine = self.is_mine;
            detailView.cust_cover = matterModel.sign_cust_logo;
            if ([matterModel.sign_cust_intent isEqualToString:@"90"] ||[matterModel.sign_cust_intent isEqualToString:@"100"])
            {
                detailView.isSign = YES;
            }
        }
        [self.navigationController pushViewController:detailView animated:YES];
    };
    
    [cell setModel:self.model withIndexPath:indexPath];
    
    return cell;
}

//获取招租事项详情
- (void)getDataList:(BOOL)isMore
{
    NSMutableDictionary *param =[NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getPosIntentInfo" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.pos_id forKey:@"pos_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = json[@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            self.model = [CGShopBusinessMattersModel mj_objectWithKeyValues:json[@"data"]];
            
            if([self.is_mine isEqualToString:@"1"]) {
                //是自己的
                
                if(![self.model.operate_status isEqualToString:@"1"]) {
                    [self createBottomBtn];
                    self.tableView.height = SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-90;
                }
                
            }else{
                //不是自己的
                self.tableView.height = SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45;
            }
            
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error)
    {
        [self endDataRefresh];
    }];
}
@end
