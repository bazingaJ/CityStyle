//
//  CGSelectAddCustomerViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/19.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGSelectAddCustomerViewController.h"
#import "CGKeyBoardFilterView.h"
#import "CGCustomerSearchView.h"
@interface CGSelectAddCustomerViewController ()

@property (nonatomic, strong) CGKeyBoardFilterView *keyBoardFilterView;

@property (nonatomic, strong) CGCustomerSearchView *searchView;

@property (nonatomic, strong) NSString *keywords; //搜索关键词

@property (nonatomic, strong) NSString *simple_keywords; //快捷字母搜索 全部 为 all 数字 为 num 其他为 大写字母    ( 非必传 )

@end

@implementation CGSelectAddCustomerViewController

-(CGCustomerSearchView *)searchView
{
    if (!_searchView)
    {
        _searchView = [[CGCustomerSearchView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        _searchView.btnTitleColor = WHITE_COLOR;
        [_searchView setUpSearchView];
        _searchView.backgroundColor = UIColorFromRGBWith16HEX(0x2E374F);
        WS(weakSelf);
        _searchView.callBack = ^(NSString *str)
        {
          weakSelf.keywords = str;
          [weakSelf.dataArr removeAllObjects];
          [weakSelf getDataList:YES];
            
        };
        [self.view addSubview:_searchView];
    }
    return _searchView;
}

-(CGKeyBoardFilterView *)keyBoardFilterView
{
    if (!_keyBoardFilterView)
    {
        _keyBoardFilterView = [[CGKeyBoardFilterView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 130)];
        _keyBoardFilterView.backgroundColor = WHITE_COLOR;
        WS(weakSelf);
        _keyBoardFilterView.callBack = ^(NSString *str)
        {
            weakSelf.simple_keywords = str;
            [weakSelf.dataArr removeAllObjects];
            [weakSelf getDataList:YES];
        };
    }
    return _keyBoardFilterView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"选择添加";
    
    self.simple_keywords = @"all";
    
    //创建"搜索框"
    [self searchView];
    
    //创建"键盘筛选"
    [self keyBoardFilterView];
    
    //设置表
    CGRect rect = self.tableView.frame;
    rect.size.height = SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT -45;
    rect.origin.y = 45;
    self.tableView.frame = rect;
    [self.tableView setTableHeaderView:[self keyBoardFilterView]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID =@"CGSelectAddCustomerViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    CGSelectAddCustomerModel *model = self.dataArr[indexPath.row];
    
    //创建"头像"
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12.5, 50, 50)];
    if (!IsStringEmpty(model.logo))
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    }
    else
    {
        imageView.image = [UIImage avatarWithName:model.first_letter];
    }
    imageView.backgroundColor = UIColorFromRGBWith16HEX(0xBCCDE8);
    imageView.layer.cornerRadius =5;
    imageView.clipsToBounds = YES;
    [cell.contentView addSubview:imageView];
    
    //创建"客户名字"
    UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right+15, 15, SCREEN_WIDTH-imageView.right-30, 20)];
    lbMsg.text = model.name;
    lbMsg.font = FONT16;
    lbMsg.textColor = COLOR3;
    [cell.contentView addSubview:lbMsg];
    
    //创建"分类"
    UILabel *lbMsg1 =[[UILabel alloc]initWithFrame:CGRectMake(lbMsg.left, lbMsg.bottom+5, 100, 20)];
    lbMsg1.font =FONT13;
    lbMsg1.textColor = COLOR9;
    lbMsg1.text = model.cate_name;
    [cell.contentView addSubview:lbMsg1];
    
    //创建"所属项目"
    UILabel *lbMsg2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-150, 0, 140, 75)];
    lbMsg2.textColor = COLOR9;
    lbMsg2.font = FONT14;
//    lbMsg2.text = @"南京金鹰奥莱城";
    lbMsg2.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:lbMsg2];
    
    //创建"线"
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 74.5, SCREEN_WIDTH, .5)];
    lineView.backgroundColor = LINE_COLOR;
    [cell.contentView addSubview:lineView];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.dataArr.count) return;
    CGSelectAddCustomerModel *model = self.dataArr[indexPath.row];
    if (self.callBack)
    {
        self.callBack(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getDataList:(BOOL)isMore
{
    NSString *act;
    if (self.type ==1)
    {
        //招租事项
        act = @"getRelationCustList";
    }
    else if (self.type ==2)
    {
        //新签合同
        act = @"getRelationCustListWithSign";
    }
    else if (self.type ==3)
    {
        //经营事项
        act = @"getRelationCustListWithOperate";
    }
    else if (self.type ==4)
    {
        //获取客户列表
        act = @"getCustList";
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:act forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.pos_id forKey:@"pos_id"];
    [param setValue:self.keywords forKey:@"keywords"];
    [param setValue:self.simple_keywords forKey:@"simple_keywords"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
    {
        NSString *code = json[@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            NSArray *listArr = json[@"data"][@"list"];
            for (NSDictionary *itemDic in listArr)
            {
                [self.dataArr addObject:[CGSelectAddCustomerModel mj_objectWithKeyValues:itemDic]];
            }
            //当前总数
            NSString *dataNum = [json[@"data"] objectForKey:@"count"];
            if(!IsStringEmpty(dataNum))
            {
                self.totalNum = [dataNum intValue];
            }
            else
            {
                self.totalNum = 0;
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
