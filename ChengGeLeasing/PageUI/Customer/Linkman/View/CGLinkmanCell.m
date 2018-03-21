//
//  CGLinkmanCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLinkmanCell.h"

@implementation CGLinkmanCell

- (void)setLinkmanModel:(CGLinkmanModel *)model indexPath:(NSIndexPath *)indexPath {
    if(!model) return;
    
    NSMutableArray *titleArr = [NSMutableArray array];
    //联系人姓名
    NSString *nameStr = @"";
    if(!IsStringEmpty(model.name)) {
        nameStr = model.name;
    }
    [titleArr addObject:@[@"linkman_icon_name",nameStr,@"1"]];
    
    //手机号码
    NSString *mobileStr = @"";
    if(!IsStringEmpty(model.mobile)) {
        mobileStr = model.mobile;
    }
    [titleArr addObject:@[@"linkman_icon_mobile",mobileStr,@"2"]];
    
    //性别
    NSString *genderName = @"";
    if(!IsStringEmpty(model.gender_name)) {
        genderName = model.gender_name;
    }
    [titleArr addObject:@[@"linkman_icon_sex",genderName,@"0"]];
    
    //职位
    if(!IsStringEmpty(model.job)) {
        [titleArr addObject:@[@"linkman_icon_position",model.job,@"0"]];
    }
    
    //邮箱
    if(!IsStringEmpty(model.email)) {
        [titleArr addObject:@[@"linkman_icon_email",model.email,@"0"]];
    }
    
    //详细地址
    if(!IsStringEmpty(model.email)) {
        [titleArr addObject:@[@"linkman_icon_location",model.address,@"0"]];
    }
    
    for (int i=0; i<[titleArr count]; i++) {
        NSArray *itemArr = [titleArr objectAtIndex:i];
        
        NSString *contentStr = itemArr[1];
        
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(10, 10+35*i, SCREEN_WIDTH-20, 35)];
        [btnFunc setTitle:contentStr forState:UIControlStateNormal];
        [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT15];
        [btnFunc setImage:[UIImage imageNamed:itemArr[0]] forState:UIControlStateNormal];
        [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btnFunc.titleLabel setNumberOfLines:2];
        if(!IsStringEmpty(contentStr)) {
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            [style setLineSpacing:5.0f];
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];
            [btnFunc.titleLabel setAttributedText:attStr];
        }
        [self.contentView addSubview:btnFunc];

        if([itemArr[2]integerValue]==1) {
            //编辑
            
            UIButton *btnFunc2 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 5, 60, 25)];
            [btnFunc2 setTitle:@"编辑" forState:UIControlStateNormal];
            [btnFunc2 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            [btnFunc2.titleLabel setFont:FONT15];
            [btnFunc2 setImage:[UIImage imageNamed:@"linkman_icon_edit"] forState:UIControlStateNormal];
            [btnFunc2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            [btnFunc2 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            [btnFunc2 addTouch:^{
                NSLog(@"编辑");
                
                if([self.delegate respondsToSelector:@selector(CGLinkmanCellEditClick:indexPath:)]) {
                    [self.delegate CGLinkmanCellEditClick:model indexPath:indexPath];
                }
                
            }];
            [self.contentView addSubview:btnFunc2];
            
        }else if([itemArr[2]integerValue]==2) {
            //拨打电话
            
            UIButton *btnFunc3 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 45, 30, 35)];
            [btnFunc3 setImage:[UIImage imageNamed:@"tel_icon_blue"] forState:UIControlStateNormal];
            [btnFunc3 addTouch:^{
                NSLog(@"拨打电话");
                
                NSString *telStr = mobileStr;
                if(IsStringEmpty(telStr)) {
                    [MBProgressHUD showError:@"暂无电话" toView:nil];
                    return ;
                }
                NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel://%@",telStr];
                UIWebView *callWebView = [[UIWebView alloc] init];
                [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [self.contentView addSubview:callWebView];
                
            }];
            [self.contentView addSubview:btnFunc3];
            
        }
        
    }
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
