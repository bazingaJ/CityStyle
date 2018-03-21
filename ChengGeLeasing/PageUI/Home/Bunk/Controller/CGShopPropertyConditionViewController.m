//
//  CGShopPropertyConditionViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGShopPropertyConditionViewController.h"
#import "CGBunkModel.h"
@interface CGShopPropertyConditionViewController ()

@property (nonatomic, strong) CGBunkModel *model;

@end

@implementation CGShopPropertyConditionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = self.tableView.frame;
    rect.size.height = SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT -45;
    self.tableView.frame = rect;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0)
    {
        return 6;
    }
    else if (section ==1)
    {
        return 3;
    }
    else if (section ==2)
    {
        return 6;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==3)
    {
        return 200;
    }
    if (indexPath.section ==0)
    {
        if (indexPath.row ==5)
        {
            return self.model.cellH;
        }
    }
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    headView.backgroundColor =WHITE_COLOR;
    
    //创建"标题"lbMsg
    UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, 0, 80, 45)];
    lbMsg.textColor = COLOR3;
    lbMsg.font = FONT17;
    lbMsg.text = @[@"基本信息",@"位置信息",@"建筑信息",@"物业条件"][section];
    lbMsg.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:lbMsg];
    
    //创建"按钮"
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(lbMsg.right+5, 0, 30, 45);
    if (section ==0)
    {
        [btn setTitle:@"*" forState:UIControlStateNormal];
        [btn setTitleColor:RED_COLOR forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -26, 0, 0)];
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"mine_addunit_show_icon"] forState:UIControlStateNormal];
    }
    [headView addSubview:btn];
    
    //创建"线'
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, .5)];
    lineView.backgroundColor = LINE_COLOR;
    [headView addSubview:lineView];
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGEditUnitViewController";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    if (indexPath.section == 0)
    {
        //创建'标题"
        UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 45)];
        lbMsg.text = @[@"铺位名称",@"铺位面积",@"所在区域",@"报价参考",@"期望业态",@"备注信息"][indexPath.row];
        lbMsg.font = FONT16;
        lbMsg.textColor = COLOR3;
        [cell.contentView addSubview:lbMsg];
        
        //创建"内容'
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(lbMsg.right+15, 0, SCREEN_WIDTH-lbMsg.right -30, 45)];
        textField.textColor = COLOR3;
        textField.font = FONT16;
        textField.userInteractionEnabled = NO;
        [cell.contentView addSubview:textField];
        
        if (indexPath.row ==0)
        {
            textField.text = self.model.name;
        }
        else if (indexPath.row ==1)
        {
            textField.text = self.model.area;
        }
        else if (indexPath.row ==2)
        {
             textField.text = self.model.group_name;
        }
        else if (indexPath.row ==3)
        {
            textField.text = self.model.quotation;
        }
        else if (indexPath.row ==4)
        {
            textField.text = self.model.want_cate_name;
        }
        else if (indexPath.row ==5)
        {
            NSString *contentStr = self.model.note;
            UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(95+15, 10, SCREEN_WIDTH-95-30, self.model.cellH-20)];
            [lbMsg setTextColor:COLOR6];
            [lbMsg setTextAlignment:NSTextAlignmentLeft];
            [lbMsg setFont:FONT14];
            [lbMsg setNumberOfLines:0];
            if(!IsStringEmpty(contentStr)) {
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:5.0f];
                [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
                [lbMsg setAttributedText:attStr];
            }
            else
            {
                lbMsg.text = @"暂无";
            }
            [cell.contentView addSubview:lbMsg];
        }
        
        if (indexPath.row<5)
        {
            //创建"线"
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(95, 44.5, SCREEN_WIDTH, .5)];
            lineView.backgroundColor = LINE_COLOR;
            [cell.contentView addSubview:lineView];
        }
       
    }
    else if (indexPath.section ==1)
    {
        
        UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 45)];
        lbMsg.text = @[@"地区",@"详细地址",@"所在商圈"][indexPath.row];
        lbMsg.font = FONT16;
        lbMsg.textColor = COLOR3;
        [cell.contentView addSubview:lbMsg];
        
        //创建"内容'
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(lbMsg.right+15, 0, SCREEN_WIDTH-lbMsg.right -30, 45)];
        textField.textColor = COLOR3;
        textField.font = FONT16;
        textField.userInteractionEnabled = NO;
        [cell.contentView addSubview:textField];
        //创建"线"
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(95, 44.5, SCREEN_WIDTH, .5)];
        lineView.backgroundColor = LINE_COLOR;
        [cell.contentView addSubview:lineView];
        
        if (indexPath.row == 0)
        {
            if (IsStringEmpty(self.model.area_name))
            {
                 textField.text = @"暂无";
            }
            else
            {
                textField.text = self.model.area_name;
            }
        }
        else if (indexPath.row ==1)
        {
            if (IsStringEmpty(self.model.address))
            {
                textField.text = @"暂无";
            }
            else
            {
                textField.text = self.model.address;
            }
        }
        else if (indexPath.row ==2)
        {
            if (IsStringEmpty(self.model.business))
            {
                textField.text = @"暂无";
            }
            else
            {
                textField.text = self.model.business;
            }
 
        }
        
        
    }
    else if (indexPath.section ==2)
    {
        UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 45)];
        lbMsg.text = @[@"建筑面积",@"使用面积",@"楼层",@"面宽",@"进深",@"层高"][indexPath.row];
        lbMsg.font = FONT16;
        lbMsg.textColor = COLOR3;
        [cell.contentView addSubview:lbMsg];
        
        //创建"内容'
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(lbMsg.right+15, 0, SCREEN_WIDTH-lbMsg.right -30, 45)];
        textField.textColor = COLOR3;
        textField.font = FONT16;
        textField.userInteractionEnabled =NO;
        [cell.contentView addSubview:textField];
        //创建"线"
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(95, 44.5, SCREEN_WIDTH, .5)];
        lineView.backgroundColor = LINE_COLOR;
        [cell.contentView addSubview:lineView];
        
        if (indexPath.row ==0)
        {
            if ([self.model.covered_area isEqualToString:@"0"] || IsStringEmpty(self.model.covered_area))
            {
                textField.text = @"暂无";
            }
            else
            {
                textField.text = self.model.covered_area;
            }
            
        }
        else if (indexPath.row ==1)
        {
            if ([self.model.net_area isEqualToString:@"0"] || IsStringEmpty(self.model.net_area))
            {
                textField.text = @"暂无";
            }
            else
            {
                textField.text = self.model.net_area;
            }
        }
        else if (indexPath.row ==2)
        {
            if ([self.model.floor isEqualToString:@"0"] || IsStringEmpty(self.model.floor))
            {
                textField.text = @"暂无";
            }
            else
            {
                textField.text = self.model.floor;
            }
        }
        else if (indexPath.row ==3)
        {
            if ([self.model.width isEqualToString:@"0"] || IsStringEmpty(self.model.width))
            {
                textField.text = @"暂无";
            }
            else
            {
                textField.text = self.model.width;
            }
        }
        else if (indexPath.row ==4)
        {
            if ([self.model.depth isEqualToString:@"0"] || IsStringEmpty(self.model.depth))
            {
                textField.text = @"暂无";
            }
            else
            {
                textField.text = self.model.depth;
            }
        }
        else if (indexPath.row ==5)
        {
            if ([self.model.height isEqualToString:@"0"] || IsStringEmpty(self.model.height))
            {
                textField.text = @"暂无";
            }
            else
            {
                textField.text = self.model.height;
            }
        }
    }
    else
    {
        CGFloat width = 60;
        CGFloat height = width +20;
        CGFloat spacing = (SCREEN_WIDTH -60*5)/6;
        NSMutableArray * imgArr = [NSMutableArray array];
        [imgArr addObject:@[@"bunk_huo_normal",@"bunk_huo_selected",@"可明火",@"1"]];
        [imgArr addObject:@[@"bunk_tianranqi_normal",@"bunk_tianranqi_selected",@"天然气管道",@"2"]];
        [imgArr addObject:@[@"bunk_meiqi_normal",@"bunk_meiqi_selected",@"煤气罐",@"3"]];
        [imgArr addObject:@[@"bunk_dianya_normal",@"bunk_dianya_selected",@"380伏",@"4"]];
        [imgArr addObject:@[@"bunk_shangshui_normal",@"bunk_shangshui_selected",@"上水",@"5"]];
        [imgArr addObject:@[@"bunk_xiashui_normal",@"bunk_xiashui_selected",@"下水",@"6"]];
        [imgArr addObject:@[@"bunk_yanguan_normal",@"bunk_yanguan_selected",@"烟管道",@"7"]];
        [imgArr addObject:@[@"bunk_guandao_normal",@"bunk_guandao_selected",@"排污管道",@"8"]];
        [imgArr addObject:@[@"bunk_park_normal",@"bunk_park_selected",@"停车位",@"9"]];
        [imgArr addObject:@[@"bunk_waibai_normal",@"bunk_waibai_selected",@"外摆区",@"10"]];
        NSInteger itemNum = [imgArr count];
        CGFloat tWidth = (SCREEN_WIDTH-20)/5;
        for (int i=0; i<2; i++) {
            for (int k=0; k<5; k++) {
                NSInteger tIndex = 5*i+k;
                if(tIndex>itemNum-1) continue;
                
                NSArray *itemArr = [imgArr objectAtIndex:tIndex];
                
                BOOL isContain = [self.model.propertyArr containsObject:itemArr[3]];
                
                //创建“背景层”
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10+tWidth*k, 100*i, tWidth-1, 99)];
                [btnFunc setTag:tIndex];
                [btnFunc setSelected:isContain];
//                [btnFunc addTarget:self action:@selector(btnFuncItemClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btnFunc];
                
                UIImage *img = nil;
                if(isContain) {
                    img = [UIImage imageNamed:itemArr[1]];
                }else{
                    img = [UIImage imageNamed:itemArr[0]];
                }
                CGFloat tW = img.size.width;
                CGFloat tH = img.size.height;
                
                //创建“图标”
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((tWidth-tW)/2, 20, tW, tH)];
                [imgView setImage:img];
                [btnFunc addSubview:imgView];
                
                //创建“标题”
                UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, tWidth, 20)];
                [lbMsg setText:itemArr[2]];
                if(isContain) {
                    [lbMsg setTextColor:RED_COLOR];
                }else{
                    [lbMsg setTextColor:COLOR9];
                }
                [lbMsg setTextAlignment:NSTextAlignmentCenter];
                [lbMsg setFont:FONT13];
                [btnFunc addSubview:lbMsg];
                
            }
        }
    }
    
    return cell;
}

//区域铺位状态内 获取铺位详情
-(void)getDataList:(BOOL)isMore
{
    NSMutableDictionary *param =[NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getPosDetailInfo" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:self.pos_id forKey:@"pos_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
    {
        NSString *code = json[@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            self.model = [CGBunkModel mj_objectWithKeyValues:json[@"data"]];
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error)
    {
        [self endDataRefresh];
    }];
}
@end
