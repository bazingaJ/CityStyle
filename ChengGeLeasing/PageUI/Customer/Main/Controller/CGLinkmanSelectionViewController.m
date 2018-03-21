//
//  CGLinkmanSelectionViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLinkmanSelectionViewController.h"

@interface CGLinkmanSelectionViewController ()

@end

@implementation CGLinkmanSelectionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"选择联系人";
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGLinkmanSelectionViewController";
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
    
    CGLinkmanModel *model = self.dataArr[indexPath.row];
    //创建"头像"
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(15, 12.5, 50, 50)];
    imageView.image = [UIImage imageNamed:@"contact_icon_avatar"];
    [cell.contentView addSubview:imageView];
    
    //创建"名字"
    UILabel *lbMsg1 = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right+15, 0, SCREEN_WIDTH-100, 75)];
    lbMsg1.textColor = COLOR3;
    lbMsg1.font = FONT16;
    lbMsg1.text = model.name;
    [cell.contentView addSubview:lbMsg1];
    
    //创建"线"
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(80, 74.5, SCREEN_WIDTH-80, .5)];
    lineView.backgroundColor = LINE_COLOR;
    [cell.contentView addSubview:lineView];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.dataArr.count) return;
    CGLinkmanModel *model = self.dataArr[indexPath.row];
    if (self.callBack)
    {
        self.callBack(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  获取数据
 */
- (void)getDataList:(BOOL)isMore {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"getLinkmanList" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.cust_id forKey:@"cust_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            if(dataDic && [dataDic count]>0) {
                NSArray *dataArr = [dataDic objectForKey:@"list"];
                for (NSDictionary *itemDic in dataArr) {
                    [self.dataArr addObject:[CGLinkmanModel mj_objectWithKeyValues:itemDic]];
                }
                
                //当前总数
                NSString *dataNum = [dataDic objectForKey:@"count"];
                if(!IsStringEmpty(dataNum)) {
                    self.totalNum = [dataNum intValue];
                }else{
                    self.totalNum = 0;
                }
            }
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [self endDataRefresh];
    }];
    
}

@end
