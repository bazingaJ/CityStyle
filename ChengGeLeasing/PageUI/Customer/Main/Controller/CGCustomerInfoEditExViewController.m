//
//  CGCustomerInfoEditExViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/22.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGCustomerInfoEditExViewController.h"
#import "CGCustomerFormatView.h"
#import "CGFloorSheetView.h"
#import "CGCropImageViewController.h"
#import "CGCropImageExViewController.h"

@interface CGCustomerInfoEditExViewController ()<CGCropImageDelegate> {
    //标题
    NSMutableArray *titleArr;
    //基本数据
    NSMutableDictionary *titleDic;
    //头像二进制
    NSData *_avatarData;
    //临时按钮
    UIButton *btnTmp;
}

@end

@implementation CGCustomerInfoEditExViewController

- (void)viewDidLoad {
    [self setBottomH:45];
    [self setHiddenHeaderRefresh:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"编辑客户";
    
    //设置默认值
    if(IsStringEmpty(self.customerModel.piping)) {
        self.customerModel.piping = @"2";//排烟通道
    }
    if(IsStringEmpty(self.customerModel.elevator)) {
        self.customerModel.elevator = @"2";//独立电梯
    }
    
    //设置标题
    titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"选址要求",@"1",@"2"]];
    [titleArr addObject:@[@"工程要求",@"1",@"3"]];
    [titleArr addObject:@[@"承重",@"0",@"4"]];
    [titleArr addObject:@[@"供电",@"0",@"5"]];
    [titleArr addObject:@[@"供水",@"0",@"6"]];
    [titleArr addObject:@[@"排水",@"0",@"7"]];
    [titleArr addObject:@[@"燃气",@"0",@"8"]];
    [titleArr addObject:@[@"暖通",@"0",@"9"]];
    [titleArr addObject:@[@"消防、环评",@"0",@"10"]];
    
    //设置数据源
    //备注：标题/描述/是否必填/单位/是否可编辑/索引
    titleDic = [NSMutableDictionary dictionary];
    
    //第一区块(基本信息)
    NSMutableArray *titleArr1 = [NSMutableArray array];
    [titleArr1 addObject:@[@"客户名称",@"请输入客户名称",@"1",@"",@"0",@"100"]];
    [titleArr1 addObject:@[@"所属团队",@"请选择所属团队",@"0",@"",@"1",@"101"]];
    [titleArr1 addObject:@[@"经营业态",@"请选择经营业态",@"1",@"",@"1",@"102"]];
    [titleArr1 addObject:@[@"官网",@"请输入官网",@"0",@"",@"0",@"103"]];
    [titleDic setValue:titleArr1 forKey:@"1"];
    
    //第二区块(选址要求)
    NSMutableArray *titleArr2 = [NSMutableArray array];
    [titleArr2 addObject:@[@"城市要求",@"请输入城市要求",@"0",@"",@"0",@"200"]];
    [titleArr2 addObject:@[@"商圈要求",@"请输入商圈要求",@"0",@"",@"0",@"201"]];
    [titleArr2 addObject:@[@"楼层",@"请输入楼层",@"0",@"",@"1",@"202"]];
    [titleArr2 addObject:@[@"面宽(不小于)",@"请输入要求面宽",@"0",@"m",@"0",@"203"]];
    [titleArr2 addObject:@[@"进深(不大于)",@"请输入要求进深",@"0",@"m",@"0",@"204"]];
    [titleArr2 addObject:@[@"面积要求",@"最小值",@"0",@"m²",@"0",@"205",@""]];
    [titleArr2 addObject:@[@"相邻喜好业态",@"请选择业态",@"0",@"",@"1",@"206"]];
    [titleDic setValue:titleArr2 forKey:@"2"];
    
    //第三区块(工程要求)
    NSMutableArray *titleArr3 = [NSMutableArray array];
    [titleArr3 addObject:@[@"层高",@"请输入层高",@"0",@"m",@"0",@"300"]];
    [titleDic setValue:titleArr3 forKey:@"3"];
    
    //第四区块(承重)
    NSMutableArray *titleArr4 = [NSMutableArray array];
    [titleArr4 addObject:@[@"厨房",@"请输入承重",@"0",@"KG/m²",@"0",@"400"]];
    [titleArr4 addObject:@[@"其他区",@"请输入其他区",@"0",@"KG/m²",@"0",@"401"]];
    [titleArr4 addObject:@[@"备注",@"请输入备注信息",@"0",@"",@"0",@"402"]];
    [titleDic setValue:titleArr4 forKey:@"4"];
    
    //第五区块(供电)
    NSMutableArray *titleArr5 = [NSMutableArray array];
    NSInteger elecNum = self.customerModel.electric.count;
    if(elecNum<=0) {
        //默认有一个
        [titleArr5 addObject:@[@"面积段",@"最小值",@"0",@"m²",@"0",@"500",@"",@""]];
        [titleArr5 addObject:@[@"供电",@"请输入供电",@"0",@"KW",@"0",@"501",@""]];
    }else {
        
        for (int i=0; i<elecNum; i++) {
            NSDictionary *itemDic = [self.customerModel.electric objectAtIndex:i];
            
            //面积段
            NSString *minStr = @"";
            NSString *maxStr = @"";
            NSString *areaStr = [itemDic objectForKey:@"area"];
            if(IsStringEmpty(areaStr)) {
                areaStr = @"";
            }else{
                //分解
                NSArray *itemArr = [areaStr componentsSeparatedByString:@"-"];
                if(itemArr && [itemArr count]>0) {
                    minStr = itemArr[0];
                    if([itemArr count]>=2) {
                        maxStr = itemArr[1];
                    }
                }
            }
            NSString *voltageStr = [itemDic objectForKey:@"voltage"];
            if(IsStringEmpty(voltageStr)) {
                voltageStr = @"";
            }
            if(i==0) {
                //默认数据
                [titleArr5 addObject:@[@"面积段",@"最小值",@"0",@"m²",@"0",@"500",minStr,maxStr]];
                [titleArr5 addObject:@[@"供电",@"请输入供电",@"0",@"KW",@"0",@"501",voltageStr]];
            }else{
                NSInteger itemNum = 500+[titleArr5 count];
                NSString *tag1 = [NSString stringWithFormat:@"%zd",itemNum];
                NSString *tag2 = [NSString stringWithFormat:@"%zd",itemNum+1];
                NSString *tag3 = [NSString stringWithFormat:@"%zd",itemNum+2];
                
                [titleArr5 addObject:@[@"面积段",@"最小值",@"0",@"m²",@"0",tag1,minStr,maxStr]];
                [titleArr5 addObject:@[@"供电",@"请输入供电",@"0",@"KW",@"0",tag2,voltageStr]];
                [titleArr5 addObject:@[@"删除",@"",@"0",@"",@"3",tag3,@""]];
            }
            
        }
    }
    
    [titleArr5 addObject:@[@"增加面积段",@"",@"0",@"",@"3",@"50000",@""]];
    [titleArr5 addObject:@[@"备注",@"请输入备注信息",@"0",@"",@"0",@"50001",@""]];
    [titleDic setValue:titleArr5 forKey:@"5"];
    
    //第六区块(供水)
    NSMutableArray *titleArr6 = [NSMutableArray array];
    [titleArr6 addObject:@[@"管径DN",@"请输入管径",@"0",@"mm",@"0",@"600"]];
    [titleArr6 addObject:@[@"压力",@"请输入压力",@"0",@"MPa",@"0",@"601"]];
    [titleArr6 addObject:@[@"备注",@"请输入备注信息",@"0",@"",@"0",@"602"]];
    [titleDic setValue:titleArr6 forKey:@"6"];
    
    //第七区块(排水)
    NSMutableArray *titleArr7 = [NSMutableArray array];
    [titleArr7 addObject:@[@"厨房DN",@"请输入直径",@"0",@"mm",@"0",@"700"]];
    [titleArr7 addObject:@[@"卫生间DN",@"请输入直径",@"0",@"mm",@"0",@"701"]];
    [titleArr7 addObject:@[@"隔油层",@"请输入体积",@"0",@"m³",@"0",@"702"]];
    [titleDic setValue:titleArr7 forKey:@"7"];
    
    //第八区块(燃气)
    NSMutableArray *titleArr8 = [NSMutableArray array];
    NSInteger gasNum = self.customerModel.gas.count;
    if(elecNum<=0) {
        //默认有一个
        [titleArr8 addObject:@[@"面积段",@"最小值",@"0",@"m²",@"0",@"800",@"",@""]];
        [titleArr8 addObject:@[@"管径DN",@"请输入管径",@"0",@"mm",@"0",@"801",@""]];
        [titleArr8 addObject:@[@"流量",@"请输入流量",@"0",@"m³/小时",@"0",@"802",@""]];
    }else {
        
        for (int i=0; i<gasNum; i++) {
            NSDictionary *itemDic = [self.customerModel.gas objectAtIndex:i];
            
            //面积段
            NSString *minStr = @"";
            NSString *maxStr = @"";
            NSString *areaStr = [itemDic objectForKey:@"area"];
            if(IsStringEmpty(areaStr)) {
                areaStr = @"";
            }else {
                //分解
                NSArray *itemArr = [areaStr componentsSeparatedByString:@"-"];
                if(itemArr && [itemArr count]>0) {
                    minStr = itemArr[0];
                    if([itemArr count]>=2) {
                        maxStr = itemArr[1];
                    }
                }
            }
            NSString *diameterStr = [itemDic objectForKey:@"diameter"];
            if(IsStringEmpty(diameterStr)) {
                diameterStr = @"";
            }
            NSString *flowStr = [itemDic objectForKey:@"flow"];
            if(IsStringEmpty(flowStr)) {
                flowStr = @"";
            }
            if(i==0) {
                //默认数据
                [titleArr8 addObject:@[@"面积段",@"最小值",@"0",@"m²",@"0",@"800",minStr,maxStr]];
                [titleArr8 addObject:@[@"管径DN",@"请输入管径",@"0",@"mm",@"0",@"801",diameterStr]];
                [titleArr8 addObject:@[@"流量",@"请输入流量",@"0",@"m³/小时",@"0",@"802",flowStr]];
            }else{
                NSInteger itemNum = 800+[titleArr8 count];
                NSString *tag1 = [NSString stringWithFormat:@"%zd",itemNum];
                NSString *tag2 = [NSString stringWithFormat:@"%zd",itemNum+1];
                NSString *tag3 = [NSString stringWithFormat:@"%zd",itemNum+2];
                NSString *tag4 = [NSString stringWithFormat:@"%zd",itemNum+3];
                
                [titleArr8 addObject:@[@"面积段",@"最小值",@"0",@"m²",@"0",tag1,minStr,maxStr]];
                [titleArr8 addObject:@[@"管径DN",@"请输入管径",@"0",@"mm",@"0",tag2,diameterStr]];
                [titleArr8 addObject:@[@"流量",@"请输入流量",@"0",@"m³/小时",@"0",tag3,flowStr]];
                [titleArr8 addObject:@[@"删除",@"",@"0",@"",@"3",tag4,@""]];
            }
            
        }
    }
    [titleArr8 addObject:@[@"增加面积段",@"",@"0",@"",@"3",@"80000",@""]];
    [titleDic setValue:titleArr8 forKey:@"8"];
    
    //第九区块(暖通)
    NSMutableArray *titleArr9 = [NSMutableArray array];
    [titleArr9 addObject:@[@"面积段",@"最小值",@"0",@"m²",@"0",@"900"]];
    [titleArr9 addObject:@[@"预留面积",@"请输入面积",@"0",@"m²",@"0",@"901"]];
    [titleDic setValue:titleArr9 forKey:@"9"];
    
    //第十区块(消防、环评)
    NSMutableArray *titleArr10 = [NSMutableArray array];
    [titleArr10 addObject:@[@"消防",@"请输入消防",@"0",@"",@"0",@"1000"]];
    [titleArr10 addObject:@[@"环评",@"请输入环评",@"0",@"",@"0",@"1001"]];
    [titleArr10 addObject:@[@"备注",@"请输入备注信息",@"0",@"",@"0",@"1002"]];
    [titleArr10 addObject:@[@"排烟通道",@"",@"0",@"",@"2",@"1003"]];
    [titleArr10 addObject:@[@"最小柱距",@"请输入最小柱距",@"0",@"m",@"0",@"1004"]];
    [titleArr10 addObject:@[@"独立电梯",@"",@"0",@"",@"2",@"1005"]];
    [titleDic setValue:titleArr10 forKey:@"10"];
    
    //创建“确定”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
    [btnFunc setTitle:@"确定" forState:UIControlStateNormal];
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT17];
    [btnFunc setBackgroundColor:MAIN_COLOR];
    [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFunc];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [titleDic count]+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return 1;
    }
    NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",section]];
    return [titleArr count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section<=1) {
        return 0.0001;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0) {
        return 70;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section==[titleDic count]) {
        return 10;
    }
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section<=1) return [UIView new];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    
    NSArray *itemArr = [titleArr objectAtIndex:section-2];
    
    //创建“名称”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, backView.frame.size.width-20, 30)];
    [lbMsg setText:itemArr[0]];
    if([itemArr[1] integerValue]==1) {
        //居中
        [lbMsg setTextColor:[UIColor blackColor]];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
    }else{
        //靠做
        [lbMsg setTextColor:COLOR6];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
    }
    [lbMsg setFont:FONT15];
    [backView addSubview:lbMsg];
    
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGCustomerInfoEditExViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if(indexPath.section==0) {
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 120, 20)];
        [lbMsg setText:@"LOGO/头像"];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [cell.contentView addSubview:lbMsg];
        
        //创建“头像”
        NSString *imgURL = self.customerModel.logo;
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 10, 50, 50)];
        [btnFunc.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [btnFunc.imageView setClipsToBounds:YES];
        [btnFunc.layer setCornerRadius:4.0];
        [btnFunc.layer setMasksToBounds:YES];
        [btnFunc.layer setBorderWidth:0.5];
        [btnFunc.layer setBorderColor:MAIN_COLOR.CGColor];
        [btnFunc sd_setImageWithURL:[NSURL URLWithString:imgURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_img_square_list"]];
        [btnFunc addTarget:self action:@selector(btnFuncUploadClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnFunc];
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 69.5, SCREEN_WIDTH, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [cell.contentView addSubview:lineView];
        
        //创建“右侧尖头”
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 30, 5.5, 10)];
        [imgView setImage:[UIImage imageNamed:@"mine_arrow_right"]];
        [cell.contentView addSubview:imgView];
        
    }else{
        
        NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",indexPath.section]];
        NSMutableArray *itemArr = [[titleArr objectAtIndex:indexPath.row] mutableCopy];
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
        [lbMsg setText:itemArr[0]];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT16];
        [lbMsg sizeToFit];
        [lbMsg setCenterY:22.5];
        [cell.contentView addSubview:lbMsg];
        
        //创建“是否必填标志”
        if([itemArr[2] integerValue]==1) {
            UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(lbMsg.right, 10, 10, 25)];
            [lbMsg2 setText:@"*"];
            [lbMsg2 setTextColor:[UIColor redColor]];
            [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
            [lbMsg2 setFont:SYSTEM_FONT_SIZE(17.0)];
            [cell.contentView addSubview:lbMsg2];
        }
        
        NSInteger tag = [itemArr[5] integerValue];
        
        //创建“内容”
        UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH-140, 25)];
        [tbxContent setPlaceholder:itemArr[1]];
        [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
        [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
        [tbxContent setTextColor:COLOR3];
        [tbxContent setTextAlignment:NSTextAlignmentLeft];
        [tbxContent setFont:FONT16];
        [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
        [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [tbxContent setTag:tag];
        [cell.contentView addSubview:tbxContent];
        
        if([[itemArr[5] substringToIndex:1] isEqualToString:@"8"]) {
            [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
        }else if([itemArr[5] integerValue]/100==5) {
            [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
        }
        
        NSInteger canEdit = [itemArr[4] integerValue];
        if(canEdit>=1 && canEdit<=2){
            //不可编辑
            [tbxContent setEnabled:NO];
        }else if(canEdit==3) {
            //增加
            [lbMsg setHidden:YES];
            [tbxContent setHidden:YES];
            
            //创建“增加按钮”
            UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-110)/2, 10, 110, 25)];
            [btnFunc setTitle:itemArr[0] forState:UIControlStateNormal];
            [btnFunc setTitleColor:COLOR9 forState:UIControlStateNormal];
            [btnFunc.titleLabel setFont:FONT15];
            if(![itemArr[0] isEqualToString:@"删除"]) {
                [btnFunc setImage:[UIImage imageNamed:@"customer_card_add"] forState:UIControlStateNormal];
            }
            [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            [btnFunc setTag:tag];
            [btnFunc addTarget:self action:@selector(btnFuncAddClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnFunc];
        }
        
        switch ([itemArr[5] integerValue]) {
            case 100: {
                //客户名称
                [tbxContent setText:self.customerModel.name];
                
                break;
            }
            case 101: {
                //所属团队
                [tbxContent setText:self.customerModel.pro_name];
                
                break;
            }
            case 102: {
                //经营业态
                [tbxContent setText:self.customerModel.cate_name];
                
                break;
            }
            case 103: {
                //官网
                [tbxContent setText:self.customerModel.website];
                
                break;
            }
            case 200: {
                //城市要求
                [tbxContent setText:self.customerModel.city];
                
                break;
            }
            case 201: {
                //商圈要求
                [tbxContent setText:self.customerModel.business];
                
                break;
            }
            case 202: {
                //楼层
                [tbxContent setKeyboardType:UIKeyboardTypeNumberPad];
                [tbxContent setText:self.customerModel.floor];
                
                break;
            }
            case 203: {
                //面宽(不小于)
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:self.customerModel.width];
                
                break;
            }
            case 204: {
                //进深(不大于)
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:self.customerModel.depth];
                
                break;
            }
            case 205: {
                //面积需求
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setWidth:60];
                [tbxContent setText:self.customerModel.min_area];
                
                //创建“横线”
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(tbxContent.right, 22.5, 35, 1)];
                [lineView setBackgroundColor:[UIColor blackColor]];
                [cell.contentView addSubview:lineView];
                
                //创建“内容”
                NSString *maxStr = @"";
                if(!IsStringEmpty(self.customerModel.max_area)) {
                    maxStr = self.customerModel.max_area;
                }
                UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(lineView.right+10, 10, 70, 25)];
                [tbxContent setPlaceholder:@"最大值"];
                [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
                [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
                [tbxContent setTextColor:COLOR3];
                [tbxContent setTextAlignment:NSTextAlignmentLeft];
                [tbxContent setFont:FONT16];
                [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
                [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                [tbxContent setTag:tag*10];
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:maxStr];
                [cell.contentView addSubview:tbxContent];
                
                break;
            }
            case 206: {
                //相邻喜好业态
                [tbxContent setText:self.customerModel.like_cate_name];
                
                break;
            }
            case 300: {
                //层高
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:self.customerModel.height];
                
                break;
            }
            case 400: {
                //厨房(承重)
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:self.customerModel.support_kitchen];
                
                break;
            }
            case 401: {
                //其他区(承重)
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:self.customerModel.support_other];
                
                break;
            }
            case 402: {
                //备注(承重)
                [tbxContent setText:self.customerModel.support_note];
                
                break;
            }
            case 50001: {
                //备注
                [tbxContent setText:self.customerModel.electric_note];
                
                break;
            }
            case 600: {
                //管径DN(供水)
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:self.customerModel.water_diameter];
                
                break;
            }
            case 601: {
                //压力(供水)
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:self.customerModel.water_pressure];
                
                break;
            }
            case 602: {
                //备注(供水)
                [tbxContent setText:self.customerModel.water_note];
                
                break;
            }
            case 700: {
                //厨房DN(排水)
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:self.customerModel.drain_diameter];
                
                break;
            }
            case 701: {
                //卫生间DN(排水)
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:self.customerModel.drain_pressure];
                
                break;
            }
            case 702: {
                //隔油池(排水)
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:self.customerModel.drain_pool];
                
                break;
            }
            case 900: {
                //面积段(暖通)
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setWidth:60];
                [tbxContent setText:self.customerModel.warming_min_area];
                
                //创建“横线”
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(tbxContent.right, 22.5, 35, 1)];
                [lineView setBackgroundColor:[UIColor blackColor]];
                [cell.contentView addSubview:lineView];
                
                //创建“内容”
                NSString *maxStr = @"";
                if(!IsStringEmpty(self.customerModel.warming_max_area)) {
                    maxStr = self.customerModel.warming_max_area;
                }
                UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(lineView.right+10, 10, 70, 25)];
                [tbxContent setPlaceholder:@"最大值"];
                [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
                [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
                [tbxContent setTextColor:COLOR3];
                [tbxContent setTextAlignment:NSTextAlignmentLeft];
                [tbxContent setFont:FONT16];
                [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
                [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                [tbxContent setTag:tag*10];
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:maxStr];
                [cell.contentView addSubview:tbxContent];
                
                break;
            }
            case 901: {
                //预留面积(暖通)
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:self.customerModel.warming_has_area];
                
                break;
            }
            case 1000: {
                //消防
                [tbxContent setText:self.customerModel.fire];
                
                break;
            }
            case 1001: {
                //环评
                [tbxContent setText:self.customerModel.environment];
                
                break;
            }
            case 1002: {
                //备注
                [tbxContent setText:self.customerModel.fire_note];
                
                break;
            }
            case 1003: {
                //排烟通道
                [tbxContent setHidden:YES];
                
                NSMutableArray *titleArr = [NSMutableArray array];
                //需要
                NSString *imgStr1 = @"mine_icon_normal";
                if([self.customerModel.piping isEqualToString:@"1"]) {
                    imgStr1 = @"mine_icon_selected";
                }
                [titleArr addObject:@[imgStr1,@"需要"]];
                //不需要
                NSString *imgStr2 = @"mine_icon_normal";
                if([self.customerModel.piping isEqualToString:@"2"]) {
                    imgStr2 = @"mine_icon_selected";
                }
                [titleArr addObject:@[imgStr2,@"不需要"]];
                for (int i=0; i<2; i++) {
                    NSArray *itemArr = [titleArr objectAtIndex:i];
                    
                    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-170+80*i, 10, 70, 25)];
                    [btnFunc setTitle:itemArr[1] forState:UIControlStateNormal];
                    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
                    [btnFunc.titleLabel setFont:FONT14];
                    [btnFunc setImage:[UIImage imageNamed:itemArr[0]] forState:UIControlStateNormal];
                    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
                    [btnFunc setTag:1000+i];
                    [btnFunc setSelected:NO];
                    if(i==1) {
                        [btnFunc setSelected:YES];
                    }
                    [btnFunc addTouch:^{
                        NSLog(@"选择排烟通道");
                        
                        for (UIView *view in cell.contentView.subviews) {
                            if([view isKindOfClass:[UIButton class]]) {
                                UIButton *btn = (UIButton *)view;
                                [btn setImage:[UIImage imageNamed:@"mine_icon_normal"] forState:UIControlStateNormal];
                                [btn setSelected:NO];
                            }
                        }
                        if(btnFunc.tag==1000) {
                            //需要
                            self.customerModel.piping = @"1";
                        }else if(btnFunc.tag==1001) {
                            //不需要
                            self.customerModel.piping = @"2";
                        }
                        [btnFunc setImage:[UIImage imageNamed:@"mine_icon_selected"] forState:UIControlStateNormal];
                        
                    }];
                    [cell.contentView addSubview:btnFunc];
                    
                }
                
                break;
            }
            case 1004: {
                //最小柱距
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:self.customerModel.range];
                
                break;
            }
            case 1005: {
                //独立电梯
                [tbxContent setHidden:YES];
                
                NSMutableArray *titleArr = [NSMutableArray array];
                //需要
                NSString *imgStr1 = @"mine_icon_normal";
                if([self.customerModel.elevator isEqualToString:@"1"]) {
                    imgStr1 = @"mine_icon_selected";
                }
                [titleArr addObject:@[imgStr1,@"需要"]];
                //不需要
                NSString *imgStr2 = @"mine_icon_normal";
                if([self.customerModel.elevator isEqualToString:@"2"]) {
                    imgStr2 = @"mine_icon_selected";
                }
                [titleArr addObject:@[imgStr2,@"不需要"]];
                for (int i=0; i<2; i++) {
                    NSArray *itemArr = [titleArr objectAtIndex:i];
                    
                    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-170+80*i, 10, 70, 25)];
                    [btnFunc setTitle:itemArr[1] forState:UIControlStateNormal];
                    [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
                    [btnFunc.titleLabel setFont:FONT14];
                    [btnFunc setImage:[UIImage imageNamed:itemArr[0]] forState:UIControlStateNormal];
                    [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
                    [btnFunc setTag:10000+i];
                    [btnFunc setSelected:NO];
                    if(i==1) {
                        [btnFunc setSelected:YES];
                    }
                    [btnFunc addTouch:^{
                        NSLog(@"选择独立电梯");
                        
                        for (UIView *view in cell.contentView.subviews) {
                            if([view isKindOfClass:[UIButton class]]) {
                                UIButton *btn = (UIButton *)view;
                                [btn setImage:[UIImage imageNamed:@"mine_icon_normal"] forState:UIControlStateNormal];
                                [btn setSelected:NO];
                            }
                        }
                        if(btnFunc.tag==10000) {
                            //需要
                            self.customerModel.elevator = @"1";
                        }else if(btnFunc.tag==10001) {
                            //不需要
                            self.customerModel.elevator = @"2";
                        }
                        [btnFunc setImage:[UIImage imageNamed:@"mine_icon_selected"] forState:UIControlStateNormal];
                        
                    }];
                    [cell.contentView addSubview:btnFunc];
                    
                }
                
                break;
            }
                
            default:
                break;
        }
        
        //供电、燃气
        if(indexPath.section==5 || indexPath.section==8) {
            if([itemArr[5] integerValue]!=50001) {
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:itemArr[6]];
            }
            if([itemArr[0] isEqualToString:@"面积段"]) {
                [tbxContent setWidth:60];
                
                //创建“横线”
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(tbxContent.right, 22.5, 35, 1)];
                [lineView setBackgroundColor:[UIColor blackColor]];
                [cell.contentView addSubview:lineView];
                
                //创建“内容”
                UITextField *tbxContent = [[UITextField alloc] initWithFrame:CGRectMake(lineView.right+10, 10, 70, 25)];
                [tbxContent setPlaceholder:@"最大值"];
                [tbxContent setValue:COLOR9 forKeyPath:@"_placeholderLabel.textColor"];
                [tbxContent setValue:FONT15 forKeyPath:@"_placeholderLabel.font"];
                [tbxContent setTextColor:COLOR3];
                [tbxContent setTextAlignment:NSTextAlignmentLeft];
                [tbxContent setFont:FONT16];
                [tbxContent setClearButtonMode:UITextFieldViewModeWhileEditing];
                [tbxContent addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                [tbxContent setKeyboardType:UIKeyboardTypeDecimalPad];
                [tbxContent setText:itemArr[7]];
                [tbxContent setTag:-tag];
                [cell.contentView addSubview:tbxContent];
                
            }
            
        }
    
        if([itemArr[4] integerValue]==1) {
            
            //创建“右侧尖头”
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
            [imgView setImage:[UIImage imageNamed:@"mine_arrow_right"]];
            [cell.contentView addSubview:imgView];
            
        }else{
            
            //创建“单位”
            UILabel *lbMsg3 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 10, 60, 25)];
            [lbMsg3 setText:itemArr[3]];
            [lbMsg3 setTextColor:COLOR3];
            [lbMsg3 setTextAlignment:NSTextAlignmentRight];
            [lbMsg3 setFont:FONT14];
            [cell.contentView addSubview:lbMsg3];
            
        }
        
        //创建“分割线”
        if(indexPath.row<[titleArr count]-1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 44.5, SCREEN_WIDTH-100, 0.5)];
            [lineView setBackgroundColor:LINE_COLOR];
            [cell.contentView addSubview:lineView];
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 1: {
            switch (indexPath.row) {
                case 2: {
                    //选择业态
                    
                    UITextField *tbxContent = [cell.contentView viewWithTag:102];
                    
                    CGCustomerFormatView *formatView = [[CGCustomerFormatView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270) titleStr:@"经营业态"];
                    [formatView getFormatList:self.customerModel.pro_id];
                    formatView.callBack = ^(NSString *cateId, NSString *cateName) {
                        NSLog(@"业态ID：%@-业态名称：%@",cateId,cateName);
                        [tbxContent setText:cateName];
                        
                        self.customerModel.cate_id = cateId;
                        self.customerModel.cate_name = cateName;
                        
                    };
                    [formatView show];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            break;
        }
        case 2: {
            switch (indexPath.row) {
                case 2: {
                    //选择楼层
                    UITextField *tbxContent = [cell.contentView viewWithTag:202];
                    
                    CGFloorSheetView *formatView = [[CGFloorSheetView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270) titleStr:@"楼层"];
                    [formatView setIsMultiple:YES];
                    [formatView getFloorList];
                    formatView.callBack = ^(NSString *floorId, NSString *floorName) {
                        NSLog(@"楼层ID：%@-楼层名称：%@",floorId,floorName);
                        [tbxContent setText:floorName];
                        
                        self.customerModel.floor = floorName;
                        
                    };
                    [formatView show];
                    
                    break;
                }
                case 6: {
                    //选择相邻好业态
                    UITextField *tbxContent = [cell.contentView viewWithTag:206];
                    
                    CGCustomerFormatView *formatView = [[CGCustomerFormatView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270) titleStr:@"经营业态"];
                    [formatView setIsMultiple:YES];
                    [formatView getFormatList:self.customerModel.pro_id];
                    formatView.callBack = ^(NSString *cateId, NSString *cateName) {
                        NSLog(@"业态ID：%@-业态名称：%@",cateId,cateName);
                        [tbxContent setText:cateName];
                        
                        self.customerModel.like_cate_id = cateId;
                        self.customerModel.linkman_name = cateName;
                        
                    };
                    [formatView show];
                    
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
            //客户名称
            self.customerModel.name = textField.text;

            break;
        }
        case 103: {
            //官网
            self.customerModel.website = textField.text;

            break;
        }
        case 200: {
            //城市要求
            self.customerModel.city = textField.text;
            
            break;
        }
        case 201: {
            //商圈要求
            self.customerModel.business = textField.text;
            
            break;
        }
        case 202: {
            //楼层
            self.customerModel.floor = textField.text;
            
            break;
        }
        case 203: {
            //面宽(不小于)
            self.customerModel.width = textField.text;
            
            break;
        }
        case 204: {
            //进深(不大于)
            self.customerModel.depth = textField.text;
            
            break;
        }
        case 205: {
            //面积要求(最小值)
            self.customerModel.min_area = textField.text;
            
            break;
        }
        case 2050: {
            //面积要求(最大值)
            self.customerModel.max_area = textField.text;
            
            break;
        }
        case 300: {
            //层高
            self.customerModel.height = textField.text;
            
            break;
        }
        case 400: {
            //厨房(承重)
            self.customerModel.support_kitchen = textField.text;
            
            break;
        }
        case 401: {
            //其他区(承重)
            self.customerModel.support_other = textField.text;
            
            break;
        }
        case 402: {
            //备注(承重)
            self.customerModel.support_note = textField.text;
            
            break;
        }
        case 50001: {
            //备注(供电)
            self.customerModel.electric_note = textField.text;
            
            break;
        }
        case 600: {
            //管径DN(供水)
            self.customerModel.water_diameter = textField.text;
            
            break;
        }
        case 601: {
            //压力(供水)
            self.customerModel.water_pressure = textField.text;
            
            break;
        }
        case 602: {
            //备注(供水)
            self.customerModel.water_note = textField.text;
            
            break;
        }
        case 700: {
            //厨房DN(排水)
            self.customerModel.drain_diameter = textField.text;
            
            break;
        }
        case 701: {
            //卫生间DN(排水)
            self.customerModel.drain_pressure = textField.text;
            
            break;
        }
        case 702: {
            //隔油层(排水)
            self.customerModel.drain_pool = textField.text;
            
            break;
        }
        case 900: {
            //面积段(暖通最小值)
            self.customerModel.warming_min_area = textField.text;
            
            break;
        }
        case 9000: {
            //面积段(暖通最大值)
            self.customerModel.warming_max_area = textField.text;
            
            break;
        }
        case 901: {
            //预留面积(暖通)
            self.customerModel.warming_has_area = textField.text;
            
            break;
        }
        case 1000: {
            //消防
            self.customerModel.fire = textField.text;
            
            break;
        }
        case 1001: {
            //环评
            self.customerModel.environment = textField.text;
            
            break;
        }
        case 1002: {
            //备注(消防、环评)
            self.customerModel.fire_note = textField.text;
            
            break;
        }
        case 1004: {
            //最小柱距离
            self.customerModel.range = textField.text;
            
            break;
        }

        default:
            break;
    }
    
    NSInteger tag = textField.tag;
    if(tag<0) {
        tag = - textField.tag;
    }
    NSString *tagStr = [NSString stringWithFormat:@"%zd",tag];
    if([[tagStr substringToIndex:1] isEqualToString:@"5"] ||
       [[tagStr substringToIndex:1] isEqualToString:@"8"]) {
        
        NSInteger section = tag/100;
        NSInteger row = tag%100;
        
        NSMutableArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",section]];
        NSMutableArray *itemArr = [[titleArr objectAtIndex:row] mutableCopy];
        if([itemArr count]==8 && textField.tag<0) {
            //最大值
            itemArr[7] = textField.text;
        }else {
            //最小值、其他
            itemArr[6] = textField.text;
        }
        NSLog(@"当前行:%@",itemArr);
        [titleArr removeObjectAtIndex:row];
        [titleArr insertObject:itemArr atIndex:row];
        NSLog(@"当前块:%@",titleArr);
        
    }
    
}

/**
 *  上传头像
 */
- (void)btnFuncUploadClick:(UIButton *)btnSender {
    NSLog(@"上传头像");
    
    btnTmp = btnSender;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    UIAlertController *alertController = [[UIAlertController alloc] init];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"拍照");
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"无法打开相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"从手机相册选择");
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

//UIImagePickerControlDelegate委托事件
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

////获取相机返回的图片
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    [self dismissViewControllerAnimated:YES completion:nil];
//
//    //获取Image
//    UIImage *photoImg = [info objectForKey:UIImagePickerControllerEditedImage];
//    [btnTmp setImage:photoImg forState:UIControlStateNormal];
//
//    _avatarData = UIImageJPEGRepresentation(photoImg,0.7);
//
//}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //关闭页面
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //获取Image
    UIImage *photoImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGCropImageExViewController *clipVC = [[CGCropImageExViewController alloc] initWithImage:photoImg clipSize:CGSizeMake(300, 300)];
    clipVC.clipType = SQUARECLIP;
    clipVC.delegate = self;
    UINavigationController *naviVC = [[UINavigationController alloc]initWithRootViewController:clipVC];
    [self.navigationController presentViewController:naviVC animated:YES completion:nil];
    
}

- (void)clipViewController:(CGCropImageExViewController *)viewC finishClipImage:(UIImage *)editImage {
    [btnTmp setImage:editImage forState:UIControlStateNormal];
    _avatarData = UIImagePNGRepresentation(editImage);
    
}

/**
 *  增加
 */
- (void)btnFuncAddClick:(UIButton *)btnSender {
    NSLog(@"增加按钮事件");
    
    if(btnSender.tag/100==5 ||
       btnSender.tag/100==500) {
        //供电
        
        //获取原数组
        NSMutableArray *dataArr = [titleDic objectForKey:@"5"];
        
        if([btnSender.titleLabel.text isEqualToString:@"删除"]) {
            //删除
            NSMutableArray *itemArr = [NSMutableArray array];
            for (int i=0; i<[dataArr count]; i++) {
                //重新计算内部标签Tag
                NSInteger itemNum = 500+[itemArr count];
                
                NSMutableArray *titleArr2 = [[dataArr objectAtIndex:i] mutableCopy];
                NSInteger tag = [titleArr2[5] integerValue];
                
                //过滤掉被删除的项
                if(tag==btnSender.tag-2 ||
                   tag==btnSender.tag-1 ||
                   tag==btnSender.tag) {
                    continue;
                }
                
                
                //重新设置内部标识
                if(tag<50000) {
                    titleArr2[5] = [NSString stringWithFormat:@"%zd",itemNum];
                }
                [itemArr addObject:titleArr2];
            }
            [titleDic setValue:itemArr forKey:@"5"];
            
        }else{
            //增加
            
            NSMutableArray *itemArr = [NSMutableArray array];
            
            //保留原始数组
            for (int i=0; i<[dataArr count]-2; i++) {
                [itemArr addObject:[dataArr objectAtIndex:i]];
            }
            
            NSInteger itemNum = 500+[itemArr count];
            NSString *tag1 = [NSString stringWithFormat:@"%zd",itemNum];
            NSString *tag2 = [NSString stringWithFormat:@"%zd",itemNum+1];
            NSString *tag3 = [NSString stringWithFormat:@"%zd",itemNum+2];
            
            //新增新数组
            [itemArr addObject:@[@"面积段",@"最小值",@"0",@"m²",@"0",tag1,@"",@""]];
            [itemArr addObject:@[@"供电",@"请输入供电",@"0",@"KW",@"0",tag2,@""]];
            [itemArr addObject:@[@"删除",@"",@"0",@"",@"3",tag3,@""]];
            [itemArr addObject:@[@"增加面积段",@"",@"0",@"",@"3",@"50000",@""]];
            [itemArr addObject:@[@"备注",@"请输入备注信息",@"0",@"",@"0",@"50001",@""]];
            [titleDic setValue:itemArr forKey:@"5"];
            
        }
        
        //刷新
        [self.tableView reloadData];
        
    }else if(btnSender.tag/100==8 ||
             btnSender.tag/100==800) {
        //燃气
        
        //获取原数组
        NSMutableArray *dataArr = [titleDic objectForKey:@"8"];
        
        if([btnSender.titleLabel.text isEqualToString:@"删除"]) {
            //删除
            NSMutableArray *itemArr = [NSMutableArray array];
            for (int i=0; i<[dataArr count]; i++) {
                //重新计算内部标签Tag
                NSInteger itemNum = 800+[itemArr count];
                
                NSMutableArray *titleArr2 = [[dataArr objectAtIndex:i] mutableCopy];
                NSInteger tag = [titleArr2[5] integerValue];
                
                //过滤掉被删除的项
                if(tag==btnSender.tag-3 ||
                   tag==btnSender.tag-2 ||
                   tag==btnSender.tag-1 ||
                   tag==btnSender.tag) {
                    continue;
                }
                
                //重新设置内部标识
                if(tag<80000) {
                    titleArr2[5] = [NSString stringWithFormat:@"%zd",itemNum];
                }
                [itemArr addObject:titleArr2];
            }
            [titleDic setValue:itemArr forKey:@"8"];
            
        }else{
            //增加
            
            NSMutableArray *itemArr = [NSMutableArray array];
            
            //保留原始数组
            for (int i=0; i<[dataArr count]-1; i++) {
                [itemArr addObject:[dataArr objectAtIndex:i]];
            }
            
            NSInteger itemNum = 800+[itemArr count];
            NSString *tag1 = [NSString stringWithFormat:@"%zd",itemNum];
            NSString *tag2 = [NSString stringWithFormat:@"%zd",itemNum+1];
            NSString *tag3 = [NSString stringWithFormat:@"%zd",itemNum+2];
            NSString *tag4 = [NSString stringWithFormat:@"%zd",itemNum+3];
            
            //新增新数组
            [itemArr addObject:@[@"面积段",@"最小值",@"0",@"m²",@"0",tag1,@"",@""]];
            [itemArr addObject:@[@"管径DN",@"请输入管径",@"0",@"mm",@"0",tag2,@""]];
            [itemArr addObject:@[@"流量",@"请输入流量",@"0",@"m³/小时",@"0",tag3,@""]];
            [itemArr addObject:@[@"删除",@"",@"0",@"",@"3",tag4,@""]];
            [itemArr addObject:@[@"增加面积段",@"",@"0",@"",@"3",@"80000",@""]];
            [titleDic setValue:itemArr forKey:@"8"];
            
        }
        
        //刷新
        [self.tableView reloadData];
        
    }
    
}

/**
 *  确定按钮事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"确定");
    [self.view endEditing:YES];
    
    //客户ID验证
    if(IsStringEmpty(self.customerModel.cust_id)) {
        [MBProgressHUD showError:@"客户ID不能为空" toView:self.view];
        return;
    }
    
    //客户名称验证
    NSString *nameStr = self.customerModel.name;
    if(IsStringEmpty(nameStr)) {
        [MBProgressHUD showError:@"请输入客户名称" toView:self.view];
        return;
    }else if([NSString stringContainsEmoji:nameStr]) {
        [MBProgressHUD showError:@"客户名称不能包含表情" toView:self.view];
        return;
    }if([nameStr length]>30) {
        [MBProgressHUD showError:@"客户名称不能超过30个字符" toView:self.view];
        return;
    }
    
    //业态验证
    if(IsStringEmpty(self.customerModel.cate_id)) {
        [MBProgressHUD showError:@"请选择业态" toView:self.view];
        return;
    }
    
    //面积需求
    NSString *minStr = self.customerModel.min_area;
    NSString *maxStr = self.customerModel.max_area;
    if(!IsStringEmpty(minStr) && !IsStringEmpty(maxStr)) {
        if([minStr floatValue]>=[maxStr floatValue]) {
            [MBProgressHUD showError:@"最大值必须大于最小值" toView:self.view];
            return;
        }
    }
    self.customerModel.area = [NSString stringWithFormat:@"%@,%@",minStr,maxStr];
    
    //供电要求
    NSArray *titleArr2 = [titleDic objectForKey:@"5"];
    NSMutableArray *titleArr3 = [NSMutableArray array];
    for (int i=0; i<[titleArr2 count]-2; i++) {
        NSArray *itemArr = [titleArr2 objectAtIndex:i];
        if([itemArr[0] isEqualToString:@"删除"]) {
            continue;
        }
        [titleArr3 addObject:itemArr];
    }
    NSMutableArray *itemArr = [NSMutableArray array];
    for (int i=0; i<[titleArr3 count]; i+=2) {
        //面积段
        NSArray *titleArr4 = [titleArr3 objectAtIndex:i];
        //最大面积>最小面积
        NSString *minStr = titleArr4[6];
        NSString *maxStr = titleArr4[7];
        if(!IsStringEmpty(minStr) && !IsStringEmpty(maxStr)) {
            if([minStr floatValue]>=[maxStr floatValue]) {
                [MBProgressHUD showError:@"最大值必须大于最小值" toView:self.view];
                return;
            }
        }
        
        NSString *areaStr = @"";
        if(!IsStringEmpty(minStr) && !IsStringEmpty(maxStr)) {
            areaStr = [NSString stringWithFormat:@"%@-%@",minStr,maxStr];
        }else {
            if(!IsStringEmpty(minStr)) {
                //最小值
                areaStr = minStr;
            }else if(!IsStringEmpty(maxStr)) {
                //最大值
                areaStr = maxStr;
            }
            
        }
        
        //电压
        NSArray *titleArr5 = [titleArr3 objectAtIndex:i+1];
        NSString *voltageStr = titleArr5[6];
        [itemArr addObject:@{@"area":areaStr,@"voltage":voltageStr}];
        
    }
    
    //燃气要求
    NSArray *titleArr4 = [titleDic objectForKey:@"8"];
    NSMutableArray *titleArr5 = [NSMutableArray array];
    for (int i=0; i<[titleArr4 count]-1; i++) {
        NSArray *itemArr = [titleArr4 objectAtIndex:i];
        if([itemArr[0] isEqualToString:@"删除"]) {
            continue;
        }
        [titleArr5 addObject:itemArr];
    }
    NSMutableArray *itemArr2 = [NSMutableArray array];
    for (int i=0; i<[titleArr5 count]; i+=3) {
        //面积段
        NSArray *titleArr6 = [titleArr5 objectAtIndex:i];
        //最大面积>最小面积
        NSString *minStr = titleArr6[6];
        NSString *maxStr = titleArr6[7];
        if(!IsStringEmpty(minStr) && !IsStringEmpty(maxStr)) {
            if([minStr floatValue]>=[maxStr floatValue]) {
                [MBProgressHUD showError:@"最大值必须大于最小值" toView:self.view];
                return;
            }
        }
        
        NSString *areaStr = @"";
        if(!IsStringEmpty(minStr) && !IsStringEmpty(maxStr)) {
            areaStr = [NSString stringWithFormat:@"%@-%@",minStr,maxStr];
        }else {
            if(!IsStringEmpty(minStr)) {
                //最小值
                areaStr = minStr;
            }else if(!IsStringEmpty(maxStr)) {
                //最大值
                areaStr = maxStr;
            }
            
        }
        //管径DN
        NSArray *titleArr7 = [titleArr5 objectAtIndex:i+1];
        NSString *diameterStr = titleArr7[6];
        //流量
        NSArray *titleArr8 = [titleArr5 objectAtIndex:i+2];
        NSString *flowStr = titleArr8[6];
        [itemArr2 addObject:@{@"area":areaStr,@"diameter":diameterStr,@"flow":flowStr}];
    }
    
    //暖通(面积段)
    NSString *minWStr = self.customerModel.warming_min_area;
    NSString *maxWStr = self.customerModel.warming_max_area;
    if(!IsStringEmpty(minWStr) && !IsStringEmpty(maxWStr)) {
        if([minWStr floatValue]>=[maxWStr floatValue]) {
            [MBProgressHUD showError:@"最大值必须大于最小值" toView:self.view];
            return;
        }
    }
    self.customerModel.warming_area = [NSString stringWithFormat:@"%@,%@",minWStr,maxWStr];
    
    //客户头像
    NSMutableArray *imgArr = [NSMutableArray array];
    if(_avatarData) {
        [imgArr addObject:@[@"logo",_avatarData]];
    }
    
    [MBProgressHUD showMsg:@"保存中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"customer" forKey:@"app"];
    [param setValue:@"editCustInfo" forKey:@"act"];
    [param setValue:self.customerModel.cust_id forKey:@"cust_id"];
    [param setValue:nameStr forKey:@"name"];
    [param setValue:self.customerModel.cate_id forKey:@"cate_id"];
    [param setValue:self.customerModel.website forKey:@"website"];
    [param setValue:self.customerModel.need_area forKey:@"need_area"];
    [param setValue:self.customerModel.years forKey:@"years"];
    [param setValue:self.customerModel.property forKey:@"property"];
    [param setValue:self.customerModel.city forKey:@"city"];
    [param setValue:self.customerModel.business forKey:@"business"];
    [param setValue:self.customerModel.floor forKey:@"floor"];
    [param setValue:self.customerModel.width forKey:@"width"];
    [param setValue:self.customerModel.depth forKey:@"depth"];
    [param setValue:self.customerModel.area forKey:@"area"];
    [param setValue:self.customerModel.like_cate_id forKey:@"like_cate_id"];
    [param setValue:self.customerModel.height forKey:@"height"];
    [param setValue:self.customerModel.support_kitchen forKey:@"support_kitchen"];
    [param setValue:self.customerModel.support_other forKey:@"support_other"];
    [param setValue:self.customerModel.support_note forKey:@"support_note"];
    //供电要求(数组)(["area"=>"面积段","voltage"=>"电压"] 非必填但是需要传空值)
    [param setValue:itemArr forKey:@"electric"];
    [param setValue:self.customerModel.electric_note forKey:@"electric_note"];
    [param setValue:self.customerModel.water_diameter forKey:@"water_diameter"];
    [param setValue:self.customerModel.water_pressure forKey:@"water_pressure"];
    [param setValue:self.customerModel.water_note forKey:@"water_note"];
    [param setValue:self.customerModel.drain_diameter forKey:@"drain_diameter"];
    [param setValue:self.customerModel.drain_pressure forKey:@"drain_pressure"];
    [param setValue:self.customerModel.drain_pool forKey:@"drain_pool"];
    //燃气要求(数组) (["area"=>"面积段","diameter"=>"管径","flow"=>"流量"] 非必填但是需要传空值)
    [param setValue:itemArr2 forKey:@"gas"];
    [param setValue:self.customerModel.warming_area forKey:@"warming_area"];
    [param setValue:self.customerModel.warming_has_area forKey:@"warming_has_area"];
    [param setValue:self.customerModel.fire forKey:@"fire"];
    [param setValue:self.customerModel.environment forKey:@"environment"];
    [param setValue:self.customerModel.fire_note forKey:@"fire_note"];
    [param setValue:self.customerModel.piping forKey:@"piping"];//1需要 2不需要
    [param setValue:self.customerModel.range forKey:@"range"];
    [param setValue:self.customerModel.elevator forKey:@"elevator"];//1需要 2不需要
    [HttpRequestEx postWithImageURL:SERVICE_URL params:param imgArr:imgArr success:^(id json) {
        [MBProgressHUD hideHUD:self.view];
        NSString *msg = [json objectForKey:@"msg"];
        NSString *code = [json objectForKey:@"code"];
        if([code isEqualToString:SUCCESS]) {
            [MBProgressHUD showSuccess:@"保存成功" toView:self.view];
            
            NSDictionary *dataDic = [json objectForKey:@"data"];
            CGCustomerModel *customerInfo = [CGCustomerModel mj_objectWithKeyValues:dataDic];
            
            //延迟一秒返回
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if(self.callBack) {
                    self.callBack(customerInfo);
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
