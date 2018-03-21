//
//  CGShopBusinessMattersViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGShopBusinessMattersViewController.h"
#import "CGShopBusinessMattersCell.h"
#import "CGBusinessMattersAddViewController.h"
#import "CGBusinessMattersDetailViewController.h"
#import "CGCustomerDetailViewController.h"
@interface CGShopBusinessMattersViewController ()
{
    UIButton *btn;
}

@property (nonatomic, strong) CGShopBusinessMattersModel *model;

@end

@implementation CGShopBusinessMattersViewController

//创建"底部按钮"
- (void)createBottomBtn
{
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-90, SCREEN_WIDTH, 45);
    btn.backgroundColor = UIColorFromRGBWith16HEX(0x789BD4);
    [btn setTitle:@"添加经营事项" forState:UIControlStateNormal];
    [btn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    //经营状态 1空置 2稳赢 3预动 4退铺
//
//    if ([self.is_mine isEqualToString:@"2"])
//    {
//        //不是自己的
//        self.tableView.height =SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT -45;
//    }
//    else
//    {
//        //创建"经营事项"
//        [self createBottomBtn];
//        self.tableView.height =SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT -45-45;
//    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //获取数据详情
    [self.tableView.mj_header beginRefreshing];
}

//添加经营事项
-(void)addBtnClick
{
    CGBusinessMattersAddViewController *addBusinessMattersView = [[CGBusinessMattersAddViewController alloc]init];
    addBusinessMattersView.pos_id =self.pos_id;
    addBusinessMattersView.type = 1;
    [self.navigationController pushViewController:addBusinessMattersView animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0)
    {
        return 4;
    }
    else if (section ==1)
    {
         return 1;
    }
    return self.model.operate_list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0)
    {
     return 10;
    }
    else if (section ==1)
    {
      return 45;
    }
    else if (section ==2)
    {
        if (self.model.operate_list.count)
        {
             return 125;
        }
        else
        {
             return 85;
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {
        return 45;
    }
    else if (indexPath.section ==1)
    {
        return self.model.sectionH2;
    }
    else if (indexPath.section ==2)
    {
        CGShopBusinessMattersOperateListModel *operateModel = self.model.operate_list[indexPath.row];
        return operateModel.cellHeight;
    }
    return 0;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView;
    
    if (section >0)
    {
        if (section ==1)
        {
             headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        }
        else if (section==2)
        {
            headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125)];
        }
       
        //创建"蓝色竖条"
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 23/2, 5, 22)];
        lineView.backgroundColor = UIColorFromRGBWith16HEX(0x7D9ACE);
        [headView addSubview:lineView];
        
        //创建"标题"
        UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 45)];
        lbMsg.font = FONT15;
        lbMsg.textColor = COLOR3;
        lbMsg.text = @[@"历史租户",@"当前经营动态"][section-1];
        [headView addSubview:lbMsg];
        
        if (section ==2)
        {
            
            if (self.model.operate_list.count)
            {
                CGShopBusinessMattersOperateListModel *model = self.model.operate_list[0];
                UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 70)];
                bgView.backgroundColor = WHITE_COLOR;
                bgView.userInteractionEnabled = YES;
                [bgView addTouch:^{
                    
                    CGCustomerDetailViewController *detailView = [[CGCustomerDetailViewController alloc] init];
                    //客户详情
                    //待完善
                    [detailView setTitle:model.cust_name];
                    detailView.cust_id = model.cust_id;
                    detailView.type =2;
                    detailView.isMine = model.is_own;
                    detailView.cust_cover = model.cust_logo;
                    if ([model.intent isEqualToString:@"90"] ||[model.intent isEqualToString:@"100"]) {
                        detailView.isSign = YES;
                    }
                    [self.navigationController pushViewController:detailView animated:YES];
                    
                }];
                [headView addSubview:bgView];
                
                //创建"头像"
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 50, 50)];
                if (!IsStringEmpty(model.cust_logo))
                {
                    [imageView sd_setImageWithURL:[NSURL URLWithString:model.cust_logo]];
                    imageView.layer.borderWidth =.5;
                    imageView.layer.borderColor = LINE_COLOR.CGColor;
                }
                else
                {
                    imageView.image =[UIImage avatarWithName:model.cust_first_letter];
                }
                imageView.backgroundColor = UIColorFromRGBWith16HEX(0xBCCDE8);
                imageView.layer.cornerRadius = 5;
                imageView.clipsToBounds = YES;
                [bgView addSubview:imageView];
                
                //创建"标题"
                UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + 5, 0, SCREEN_WIDTH -imageView.right-5-55, 70)];
                lbMsg.textColor = COLOR3;
                lbMsg.text = model.cust_name;
                lbMsg.font = FONT16;
                [bgView addSubview:lbMsg];
            }
            
            else
            {
                UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 40)];
                lbMsg.textColor = COLOR9;
                lbMsg.font = FONT15;
                lbMsg.backgroundColor = WHITE_COLOR;
                lbMsg.textAlignment = NSTextAlignmentCenter;
                lbMsg.text = @"暂无经营动态";
                [headView addSubview:lbMsg];
            }
        }
    }
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGShopBusinessMattersCell";
    CGShopBusinessMattersCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell =[[CGShopBusinessMattersCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    cell.callBackRelodData = ^{
        [self.tableView reloadData];
    };
    
    cell.callBackHistory = ^(CGShopBusinessMattersHistoryListModel *historyModel)
    {
        CGCustomerDetailViewController *detailView = [[CGCustomerDetailViewController alloc] init];
        [detailView setTitle:historyModel.name];
        detailView.cust_id = historyModel.id;
        detailView.isMine = historyModel.is_own;
        detailView.cust_cover = historyModel.logo;
        if ([historyModel.intent isEqualToString:@"90"] ||[historyModel.intent isEqualToString:@"100"]) {
            detailView.isSign = YES;
        }
        [self.navigationController pushViewController:detailView animated:YES];
    };
    
    [cell setModel:self.model withIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGShopBusinessMattersOperateListModel *operateModel = self.model.operate_list[indexPath.row];
    //跳转至详情
    CGBusinessMattersDetailViewController *detailView = [[CGBusinessMattersDetailViewController alloc] init];
    detailView.business_id = operateModel.id;
    [self.navigationController pushViewController:detailView animated:YES];
}

//获取经营事项详情
-(void)getDataList:(BOOL)isMore
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getPosOperateInfo" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.pos_id forKey:@"pos_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
    {
        NSString *code = json[@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            self.model = [CGShopBusinessMattersModel mj_objectWithKeyValues:json[@"data"]];
            
            //经营状态 1空置 2稳赢 3预动 4退铺
            if([self.is_mine isEqualToString:@"1"]) {
                //是自己的
                
                if(![self.model.operate_status isEqualToString:@"1"]) {
                    //创建"经营事项"
                    [self createBottomBtn];
                    self.tableView.height = SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-90;
                }
                
            }else {
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
