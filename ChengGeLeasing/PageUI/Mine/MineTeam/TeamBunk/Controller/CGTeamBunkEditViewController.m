//
//  CGTeamBunkEditViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGTeamBunkEditViewController.h"
#import "AddressPickView.h"
#import "CGCustomerFormatView.h"
#import "CGMineTeamAreaSelectedViewController.h"
#import "CGQuotationSheetView.h"
#import "CGAddNoteViewController.h"

@interface CGTeamBunkEditViewController () {
    NSMutableDictionary *titleDic;
    
    //标题头
    NSArray *itemArr;
    
    //物业
    NSMutableArray *imgArr;
    
    //铺位对象
    CGBunkModel *bunkModel;
}

@end

@implementation CGTeamBunkEditViewController

- (void)viewDidLoad {
    [self setRightButtonItemTitle:@"保存"];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = IsStringEmpty(self.pos_id) ? @"添加铺位" : @"编辑铺位";
    
    //初始化
    if(!bunkModel) {
        bunkModel = [CGBunkModel new];
    }
    
    //设置头标题
    itemArr = @[@"基本信息",@"信息位置",@"建筑信息",@"物业条件"];
    
    //设置数据源
    titleDic = [NSMutableDictionary dictionary];
    
    //备注：标题/描述/单位/是否可编辑/键盘类型/索引值
    //第一区块
    NSMutableArray *titleArr1 = [NSMutableArray array];
    [titleArr1 addObject:@[@"铺位名称",@"例如F-001、珠江路5号",@"",@"0",@"0",@"100"]];
    [titleArr1 addObject:@[@"铺位面积",@"请输入铺位面积",@"m²",@"0",@"1",@"101"]];
    [titleArr1 addObject:@[@"所在区域",@"请选择",@"",@"1",@"0",@"102"]];
    [titleArr1 addObject:@[@"报价参考",@"请输入报价参考",@"元/平方米/天",@"0",@"1",@"103"]];
    [titleArr1 addObject:@[@"期望业态",@"请选择期望业态",@"",@"1",@"0",@"104"]];
     [titleArr1 addObject:@[@"备注",@"请输入备注",@"",@"1",@"0",@"105"]];
    [titleDic setValue:titleArr1 forKey:@"0"];
    
    //第二区块
    NSMutableArray *titleArr2 = [NSMutableArray array];
    [titleArr2 addObject:@[@"地区",@"请选择",@"",@"1",@"0",@"200"]];
    [titleArr2 addObject:@[@"详细地址",@"请输入详细地址",@"",@"0",@"0",@"201"]];
    [titleArr2 addObject:@[@"所在商圈",@"请输入所在商圈",@"",@"0",@"0",@"202"]];
    [titleDic setValue:titleArr2 forKey:@"1"];
    
    //第三区块
    NSMutableArray *titleArr3 = [NSMutableArray array];
    [titleArr3 addObject:@[@"建筑面积",@"请输入建筑面积",@"m²",@"0",@"1",@"300"]];
    [titleArr3 addObject:@[@"使用面积",@"请输入使用面积",@"m²",@"0",@"1",@"301"]];
    [titleArr3 addObject:@[@"楼层",@"请输入楼层",@"",@"0",@"1",@"302"]];
    [titleArr3 addObject:@[@"面宽",@"请输入面宽",@"m",@"0",@"1",@"303"]];
    [titleArr3 addObject:@[@"进深",@"请输入进深",@"m",@"0",@"1",@"304"]];
    [titleArr3 addObject:@[@"层高",@"请输入层高",@"m",@"0",@"1",@"305"]];
    [titleDic setValue:titleArr3 forKey:@"2"];
    
    //物业条件
    imgArr = [NSMutableArray array];
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
    
    //备注：
    //1、添加时获取系统最新铺位信息
    //2、编辑时需要获取当前铺位信息
    if(!IsStringEmpty(self.pos_id)) {
        //获取铺位详情
        [self getBunkInfo];
    }else {
        //获取系统最新铺位信息
        [self getLastBunkInfo];
    }
    
}

/**
 *  保存数据
 */
- (void)rightButtonItemClick {
    [self.view endEditing:YES];
    
    //铺位名称验证
    NSString *nameStr = bunkModel.name;
    if(IsStringEmpty(nameStr)) {
        [MBProgressHUD showError:@"请输入铺位名称" toView:self.view];
        return;
    }else if([NSString stringContainsEmoji:nameStr]) {
        [MBProgressHUD showError:@"铺位名称不能包含表情" toView:self.view];
        return;
    }if([nameStr length]>30) {
        [MBProgressHUD showError:@"铺位名称不能超过30个字符" toView:self.view];
        return;
    }
    
    //铺位面积验证
    if(IsStringEmpty(bunkModel.area)) {
        [MBProgressHUD showError:@"请输入铺位面积" toView:self.view];
        return;
    }else if([bunkModel.area floatValue]<=0) {
        [MBProgressHUD showError:@"请输入铺位面积" toView:self.view];
        return;
    }
    
    //区域验证
    if(IsStringEmpty(bunkModel.group_id)) {
        [MBProgressHUD showError:@"请选择区域" toView:self.view];
        return;
    }
    
    //报价报价验证
    if(IsStringEmpty(bunkModel.quotation)) {
        [MBProgressHUD showError:@"请输入报价参考" toView:self.view];
        return;
    }
    
    //期望业态验证
    if(IsStringEmpty(bunkModel.want_cate_id)) {
        [MBProgressHUD showError:@"请选择期望业态" toView:self.view];
        return;
    }
    
//    //备注验证
//    if(IsStringEmpty(bunkModel.note)) {
//        [MBProgressHUD showError:@"请输入备注" toView:self.view];
//        return;
//    }
    
    //    //地区验证
    //    if(IsStringEmpty(bunkModel.province_id) ||
    //       IsStringEmpty(bunkModel.city_id) ||
    //       IsStringEmpty(bunkModel.area_id)) {
    //        [MBProgressHUD showError:@"请选择地区" toView:self.view];
    //        return;
    //    }
//    //地区验证
//    if(IsStringEmpty(bunkModel.province_id) ||
//       IsStringEmpty(bunkModel.city_id) ||
//       IsStringEmpty(bunkModel.area_id)) {
//        [MBProgressHUD showError:@"请选择地区" toView:self.view];
//        return;
//    }
//    
//    //详细地址验证
//    if(IsStringEmpty(bunkModel.address)) {
//        [MBProgressHUD showError:@"请输入详细地址" toView:self.view];
//        return;
//    }
//    
//    //商圈验证
//    if(IsStringEmpty(bunkModel.business)) {
//        [MBProgressHUD showError:@"请输入所在商圈" toView:self.view];
//        return;
//    }
//    
//    //建筑面积验证
//    if(IsStringEmpty(bunkModel.covered_area)) {
//        [MBProgressHUD showError:@"请输入建筑面积" toView:self.view];
//        return;
//    }else if([bunkModel.covered_area floatValue]<=0) {
//        [MBProgressHUD showError:@"请输入建筑面积" toView:self.view];
//        return;
//    }
//    
//    //使用面积验证
//    if(IsStringEmpty(bunkModel.net_area)) {
//        [MBProgressHUD showError:@"请输入使用面积" toView:self.view];
//        return;
//    }else if([bunkModel.net_area floatValue]<=0) {
//        [MBProgressHUD showError:@"请输入使用面积" toView:self.view];
//        return;
//    }
//    
//    //楼层验证
//    if(IsStringEmpty(bunkModel.floor)) {
//        [MBProgressHUD showError:@"请输入楼层" toView:self.view];
//        return;
//    }
//    
//    //面宽验证
//    if(IsStringEmpty(bunkModel.width)) {
//        [MBProgressHUD showError:@"请输入面宽" toView:self.view];
//        return;
//    }else if([bunkModel.width floatValue]<=0) {
//        [MBProgressHUD showError:@"请输入面宽" toView:self.view];
//        return;
//    }
//    
//    //进深验证
//    if(IsStringEmpty(bunkModel.depth)) {
//        [MBProgressHUD showError:@"请输入进深" toView:self.view];
//        return;
//    }else if([bunkModel.depth floatValue]<=0) {
//        [MBProgressHUD showError:@"请输入进深" toView:self.view];
//        return;
//    }
//    
//    //层高验证
//    if(IsStringEmpty(bunkModel.height)) {
//        [MBProgressHUD showError:@"请输入层高" toView:self.view];
//        return;
//    }else if([bunkModel.height floatValue]<=0) {
//        [MBProgressHUD showError:@"请输入层高" toView:self.view];
//        return;
//    }
//    
//    //物业验证
//    if(!bunkModel.propertyArr.count || IsStringEmpty(bunkModel.property)) {
//        [MBProgressHUD showError:@"请选择物业条件" toView:self.view];
//        return;
//    }
    
    [MBProgressHUD showMsg:@"保存中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"setPos" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [param setValue:self.pos_id forKey:@"pos_id"];
    [param setValue:bunkModel.name forKey:@"name"];
    [param setValue:bunkModel.area forKey:@"area"];
    [param setValue:bunkModel.group_id forKey:@"group_id"];
    [param setValue:bunkModel.quotation forKey:@"quotation"];
    [param setValue:bunkModel.quotation_unit forKey:@"quotation_unit"];
    [param setValue:bunkModel.want_cate_id forKey:@"want_cate_id"];
    [param setValue:bunkModel.province_id forKey:@"province_id"];
    [param setValue:bunkModel.city_id forKey:@"city_id"];
    [param setValue:bunkModel.area_id forKey:@"area_id"];
    [param setValue:bunkModel.address forKey:@"address"];
    [param setValue:bunkModel.business forKey:@"business"];
    [param setValue:bunkModel.covered_area forKey:@"covered_area"];
    [param setValue:bunkModel.net_area forKey:@"net_area"];
    [param setValue:bunkModel.floor forKey:@"floor"];
    [param setValue:bunkModel.width forKey:@"width"];
    [param setValue:bunkModel.depth forKey:@"depth"];
    [param setValue:bunkModel.height forKey:@"height"];
    [param setValue:bunkModel.property forKey:@"property"];
    [param setValue:bunkModel.note forKey:@"note"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"保存成功" toView:self.view];
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if(self.callBack) {
                    self.callBack();
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [MBProgressHUD hideHUD:self.view];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [titleDic count]+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==[titleDic count]) {
        return 1;
    }
    NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",section]];
    return [titleArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==[titleDic count]) {
        return 200;
    }
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    [backView setBackgroundColor:[UIColor clearColor]];
    
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, backView.frame.size.width, 45)];
    [itemView setBackgroundColor:[UIColor whiteColor]];
    [backView addSubview:itemView];
    
    //创建“标题”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake((itemView.frame.size.width-130)/2, 10, 130, 25)];
    [btnFunc setTitle:itemArr[section] forState:UIControlStateNormal];
    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnFunc sizeToFit];
    [btnFunc setCenterY:27.5];
    [itemView addSubview:btnFunc];
    
    //创建“是否必填标志”
    if(section==0) {
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(btnFunc.right, 15, 10, 25)];
        [lbMsg2 setText:@"*"];
        [lbMsg2 setTextColor:[UIColor redColor]];
        [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
        [lbMsg2 setFont:FONT17];
        [itemView addSubview:lbMsg2];
    }
    
    //创建“下划线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, itemView.frame.size.width, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [itemView addSubview:lineView];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGTeamBunkEditViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if(indexPath.section==[titleDic count]) {
        //物业条件
        NSInteger itemNum = [imgArr count];
        CGFloat tWidth = (SCREEN_WIDTH-20)/5;
        for (int i=0; i<2; i++) {
            for (int k=0; k<5; k++) {
                NSInteger tIndex = 5*i+k;
                if(tIndex>itemNum-1) continue;
                
                NSArray *itemArr = [imgArr objectAtIndex:tIndex];
                
                BOOL isContain = [bunkModel.propertyArr containsObject:itemArr[3]];
                
                //创建“背景层”
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10+tWidth*k, 100*i, tWidth-1, 99)];
                [btnFunc setTag:tIndex];
                [btnFunc setSelected:isContain];
                [btnFunc addTarget:self action:@selector(btnFuncItemClick:) forControlEvents:UIControlEventTouchUpInside];
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
        
    }else{
        NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",indexPath.section]];
        NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
        [lbMsg setText:itemArr[0]];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [cell.contentView addSubview:lbMsg];
        
        //创建“内容”
        UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(90, 10, SCREEN_WIDTH-150, 25)];
        [tbxContent setPlaceholder:itemArr[1]];
        [tbxContent setTextAlignment:NSTextAlignmentLeft];
        [tbxContent setTextColor:COLOR3];
        [tbxContent setFont:FONT16];
        [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
        [tbxContent setValue:FONT16 forKeyPath:@"_placeholderLabel.font"];
        [tbxContent setDelegate:self];
        [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
        [tbxContent setTag:[itemArr[5] integerValue]];
        if([itemArr[4] integerValue]) {
            //数字金盘(可输入小数点)
            [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
        }
        if([itemArr[3] integerValue]==1) {
            [tbxContent setEnabled:NO];
            
            //创建“右侧尖头”
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
            [imgView setImage:[UIImage imageNamed:@"mine_arrow_right"]];
            [cell.contentView addSubview:imgView];
        }
        [cell.contentView addSubview:tbxContent];
        
        switch (indexPath.section) {
            case 0: {
                switch ([itemArr[5] integerValue]) {
                    case 100: {
                        //铺位名称
                        [tbxContent setText:bunkModel.name];
                        
                        break;
                    }
                    case 101: {
                        //铺位面积
                        [tbxContent setText:bunkModel.area];
                        
                        break;
                    }
                    case 102: {
                        //所在区域
                        [tbxContent setText:bunkModel.group_name];
                        
                        break;
                    }
                    case 103: {
                        //报价参考
                        [tbxContent setText:bunkModel.quotation];
                        
                        break;
                    }
                    case 104: {
                        //期望业态
                        [tbxContent setText:bunkModel.want_cate_name];
                        
                        break;
                    }
                    case 105: {
                        //期望业态
                        [tbxContent setText:bunkModel.note];
                        
                        break;
                    }
                        
                    default:
                        break;
                }
                
                break;
            }
            case 1: {
                switch ([itemArr[5] integerValue]) {
                    case 200: {
                        //地区
                        [tbxContent setText:bunkModel.area_name];
                        
                        break;
                    }
                    case 201: {
                        //详细地址
                        [tbxContent setText:bunkModel.address];
                        
                        break;
                    }
                    case 202: {
                        //所在商圈
                        [tbxContent setText:bunkModel.business];
                        
                        break;
                    }
                        
                    default:
                        break;
                }
                
                break;
            }
            case 2: {
                switch ([itemArr[5] integerValue]) {
                    case 300: {
                        //建筑面积
                        if(![bunkModel.covered_area isEqualToString:@"0"])
                        {
                            [tbxContent setText:bunkModel.covered_area];
                        }
                        break;
                    }
                    case 301: {
                        //使用面积
                        if(![bunkModel.net_area isEqualToString:@"0"])
                        {
                            [tbxContent setText:bunkModel.net_area];
                        }
                        
                        break;
                    }
                    case 302: {
                        //楼层
                        if(![bunkModel.floor isEqualToString:@"0"])
                        {
                            [tbxContent setText:bunkModel.floor];
                        }
                
                        break;
                    }
                    case 303: {
                        //面宽
                        if(![bunkModel.width isEqualToString:@"0"])
                        {
                            [tbxContent setText:bunkModel.width];
                        }
                        
                        break;
                    }
                    case 304: {
                        //进深
                        if(![bunkModel.depth isEqualToString:@"0"])
                        {
                            [tbxContent setText:bunkModel.depth];
                        }
                        
                        break;
                    }
                    case 305: {
                        //层高
                        if(![bunkModel.height isEqualToString:@"0"])
                        {
                            [tbxContent setText:bunkModel.height];
                        }
                        break;
                    }
                        
                    default:
                        break;
                }
                
                break;
            }
                
            default:
                break;
        }
        
        //创建“单位”
        NSString *unitStr = itemArr[2];
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, 10, 80, 25)];
        [btnFunc setTitle:unitStr forState:UIControlStateNormal];
        if([itemArr[5] integerValue]==103) {
            //报价参考
            if(!IsStringEmpty(bunkModel.quotation_unit_name)) {
                [btnFunc setTitle:bunkModel.quotation_unit_name forState:UIControlStateNormal];
            }
        }
        [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT13];
        [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        if([itemArr[5] integerValue]==103) {
            [btnFunc addTouch:^{
                NSLog(@"选择单位");
                [self.view endEditing:YES];
                
                CGQuotationSheetView *sheetView = [[CGQuotationSheetView alloc] init];
                sheetView.callBack = ^(NSString *unit_id, NSString *unit_name) {
                    NSLog(@"单位ID:%@-单位名称:%@",unit_id,unit_name);
                    bunkModel.quotation_unit = unit_id;
                    bunkModel.quotation_unit_name = unit_name;
                    [btnFunc setTitle:unit_name forState:UIControlStateNormal];
                };
                [sheetView show];
                
            }];
        }
        [cell.contentView addSubview:btnFunc];
        
        //创建“分割线”
        if(indexPath.row<[titleArr count]-1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    
    NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",indexPath.section]];
    NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
    NSInteger rowNum = [itemArr[5] integerValue];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITextField *tbxContent = [cell.contentView viewWithTag:rowNum];
    
    switch (indexPath.section) {
        case 0: {
            switch (rowNum) {
                case 102: {
                    //所在地区
                    CGMineTeamAreaSelectedViewController *areaView = [[CGMineTeamAreaSelectedViewController alloc] init];
                    areaView.pro_id = self.pro_id;
                    areaView.callBack = ^(NSString *group_id, NSString *group_name) {
                        NSLog(@"区域ID:%@-区域名称:%@",group_id,group_name);
                        
                        [tbxContent setText:group_name];
                        
                        bunkModel.group_id = group_id;
                        bunkModel.group_name = group_name;
                        
                    };
                    [self.navigationController pushViewController:areaView animated:YES];

                    break;
                }
                case 104: {
                    //选择业态
                    CGCustomerFormatView *formatView = [[CGCustomerFormatView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270) titleStr:@"期望业态"];
                    formatView.isMultiple = YES;
                    formatView.itemArr = bunkModel.wantCateArr;
                    [formatView getFormatList:self.pro_id];
                    formatView.callBack = ^(NSString *cateId, NSString *cateName) {
                        NSLog(@"业态ID：%@-业态名称：%@",cateId,cateName);
                        
                        [tbxContent setText:cateName];
                        
                        //业态ID集合(逗号相隔)
                        bunkModel.want_cate_id = cateId;
                        bunkModel.want_cate_name = cateName;
                        
                    };
                    [formatView show];
                    
                    break;
                }
                case 105:
                {
                    CGAddNoteViewController *addNoteView = [[CGAddNoteViewController alloc]init];
                    addNoteView.content = bunkModel.note;
                    addNoteView.callBack = ^(NSString *content)
                    {
                        [tbxContent setText:content];
                        bunkModel.note = content;
                    };
                    [self.navigationController pushViewController:addNoteView animated:YES];
                }
                    
                default:
                    break;
            }
            
            break;
        }
        case 1: {
            switch (indexPath.row) {
                case 0: {
                    //地区
                    [self.view endEditing:YES];
                    
                    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    UITextField *tbxContent = [cell.contentView viewWithTag:200];
                    
                    AddressPickView *addressPickView = [AddressPickView CreateInstance];
                    [self.view addSubview:addressPickView];
                    addressPickView.block = ^(NSString *cityIds,NSString *nameStr){
                        NSLog(@"%@ %@",cityIds,nameStr);
                        [tbxContent setText:nameStr];
                        
                        //值存储
                        NSArray *itemArr = [cityIds componentsSeparatedByString:@","];
                        bunkModel.province_id = itemArr[0];
                        bunkModel.city_id = itemArr[1];
                        bunkModel.area_id = itemArr[2];
                        bunkModel.area_name = nameStr;
                    };
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            break;
        }
            
        default:
            break;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)textFieldDidChange:(UITextField *)textField {
    switch (textField.tag) {
        case 100: {
            //铺位名称
            bunkModel.name = textField.text;
            
            break;
        }
        case 101: {
            //铺位面积
            bunkModel.area = textField.text;
            
            break;
        }
        case 103: {
            //报价参考
            bunkModel.quotation = textField.text;
            
            break;
        }
        case 104: {
            //期望业态
            
            break;
        }
        case 201: {
            //详细地址
            bunkModel.address = textField.text;
            
            break;
        }
        case 202: {
            //所在商圈
            bunkModel.business = textField.text;
            
            break;
        }
        case 300: {
            //建筑面积
            bunkModel.covered_area = textField.text;
            
            break;
        }
        case 301: {
            //使用面积
            bunkModel.net_area = textField.text;
            
            break;
        }
        case 302: {
            //楼层
            bunkModel.floor = textField.text;
            
            break;
        }
        case 303: {
            //面宽
            bunkModel.width = textField.text;
            
            break;
        }
        case 304: {
            //进深
            bunkModel.depth = textField.text;
            
            break;
        }
        case 305: {
            //层高
            bunkModel.height = textField.text;
            
            break;
        }
            
        default:
            break;
    }
}

/**
 *  物业选择事件
 */
- (void)btnFuncItemClick:(UIButton *)btnSender {
    NSLog(@"物业选择");
    
    btnSender.selected = !btnSender.selected;
    
    //获取当前数据源
    NSArray *propertyArr = [imgArr objectAtIndex:btnSender.tag];
    
    
    for (UIView *view in btnSender.subviews) {
        if([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imgView = (UIImageView *)view;
            if(btnSender.isSelected) {
                //选中
                [imgView setImage:[UIImage imageNamed:propertyArr[1]]];
                [bunkModel.propertyArr addObject:propertyArr[3]];
            }else{
                //未选中
                [imgView setImage:[UIImage imageNamed:propertyArr[0]]];
                [bunkModel.propertyArr removeObject:propertyArr[3]];
            }
        }
        if([view isKindOfClass:[UILabel class]]) {
            UILabel *lbMsg = (UILabel *)view;
            if(btnSender.isSelected) {
                [lbMsg setTextColor:RED_COLOR];
            }else{
                [lbMsg setTextColor:COLOR9];
            }
        }
    }
    
    //物业集合
    NSString *propertyStr = [bunkModel.propertyArr componentsJoinedByString:@","];
    bunkModel.property = propertyStr;
    NSLog(@"物业条件:%@",bunkModel.property);
    
}

/**
 *  获取铺位详情(编辑时)
 */
- (void)getBunkInfo {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getPosDetail" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [param setValue:self.pos_id forKey:@"pos_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            bunkModel = [CGBunkModel mj_objectWithKeyValues:dataDic];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
}

/**
 *  获取最新铺位信息(添加时)
 */
- (void)getLastBunkInfo {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getPosPresetValue" forKey:@"act"];
    [param setValue:self.pro_id forKey:@"pro_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            NSDictionary *dataDic = [json objectForKey:@"data"];
            bunkModel = [CGBunkModel mj_objectWithKeyValues:dataDic];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
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
