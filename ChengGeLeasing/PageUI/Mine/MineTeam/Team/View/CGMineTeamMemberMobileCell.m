//
//  CGMineTeamMemberMobileCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/16.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamMemberMobileCell.h"

@implementation CGMineTeamMemberMobileCell

- (void)setTeamMemberModel:(CGTeamMemberModel *)model pro_id:(NSString *)pro_id {
    if(!model) return;
    
    //创建“头像”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 55, 55)];
    [imgView.layer setCornerRadius:4.0];
    [imgView.layer setMasksToBounds:YES];
    [imgView setImage:[UIImage imageNamed:@"contact_icon_avatar"]];
    [self.contentView addSubview:imgView];
    
    //创建“成员名称”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, SCREEN_WIDTH-120, 20)];
    [lbMsg setText:model.name];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    
    
    //创建"添加"或者已添加按钮
     UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 25, 60, 25)];
    if (model.isAdd)
    {
        //已添加
        [btnFunc setUserInteractionEnabled:NO];
        [btnFunc setTitle:@"已添加" forState:UIControlStateNormal];
        [btnFunc setBackgroundColor:[UIColor grayColor]];
    }
    else
    {
        //未添加
        [btnFunc setTitle:@"添加" forState:UIControlStateNormal];
        [btnFunc setBackgroundColor:MAIN_COLOR];
        btnFunc.tag =200;
    }
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT15];
    [btnFunc.layer setCornerRadius:4.0];
    [self.contentView addSubview:btnFunc];
    
    [btnFunc addTouch:^{
        
        if (!model.isAdd && !self.isAdd)
        {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:@"ucenter" forKey:@"app"];
            [param setValue:@"addNewUser" forKey:@"act"];
            [param setValue:model.id forKey:@"member"];
            [param setValue:pro_id forKey:@"pro_id"];
            [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                NSString *msg = [json objectForKey:@"msg"];
                NSString *code = [json objectForKey:@"code"];
                if([code isEqualToString:SUCCESS]) {
                    model.isAdd = YES;
                    [btnFunc setUserInteractionEnabled:NO];
                    [btnFunc setTitle:@"已添加" forState:UIControlStateNormal];
                    [btnFunc setBackgroundColor:[UIColor grayColor]];
                    
                    if([self.delegate respondsToSelector:@selector(CGMineTeamMemberMobileCellClick:model:)]) {
                        [self.delegate CGMineTeamMemberMobileCellClick:btnFunc model:model];
                    }
                }
                else
                {
                    [MBProgressHUD showError:msg toView:nil];
                }
            } failure:^(NSError *error) {
                NSLog(@"%@",[error description]);
            }];
            
        }
        else
        {
            model.isAdd = YES;
            [btnFunc setUserInteractionEnabled:NO];
            [btnFunc setTitle:@"已添加" forState:UIControlStateNormal];
            [btnFunc setBackgroundColor:[UIColor grayColor]];
            if([self.delegate respondsToSelector:@selector(CGMineTeamMemberMobileCellClick:model:)]) {
                [self.delegate CGMineTeamMemberMobileCellClick:btnFunc model:model];
            }
        }
        
    }];
    
    
//    //创建“邀请”按钮
//    if(![model.isIn isEqualToString:@"1"]) {
//        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 25, 60, 25)];
//        if(IsStringEmpty(model.isIn))
//        {
//            [btnFunc setTitle:@"邀请" forState:UIControlStateNormal];
//            [btnFunc setBackgroundColor:MAIN_COLOR];
//            [btnFunc setTag:100];
//        }
//        else if([model.isIn isEqualToString:@"2"])
//        {
//            
//            NSLog(@"是否已添加:%d",model.isAdd);
//            if(model.isAdd)
//            {
//                [btnFunc setUserInteractionEnabled:NO];
//                [btnFunc setTitle:@"已添加" forState:UIControlStateNormal];
//                [btnFunc setBackgroundColor:[UIColor grayColor]];
//            }
//            else
//            {
//                
//                [btnFunc setTitle:@"添加" forState:UIControlStateNormal];
//                [btnFunc setBackgroundColor:MAIN_COLOR];
//            }
//            [btnFunc setTag:200];
//        }
//        [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btnFunc.titleLabel setFont:FONT15];
//        [btnFunc.layer setCornerRadius:4.0];
//        [btnFunc addTouch:^{
//            NSLog(@"点击邀请");
//            
//            if(btnFunc.tag==200 && !self.isAdd) {
//                //添加团队成员
//                
//                NSMutableDictionary *param = [NSMutableDictionary dictionary];
//                [param setValue:@"ucenter" forKey:@"app"];
//                [param setValue:@"addNewUser" forKey:@"act"];
//                [param setValue:model.id forKey:@"member"];
//                [param setValue:pro_id forKey:@"pro_id"];
//                [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
//                    NSString *msg = [json objectForKey:@"msg"];
//                    NSString *code = [json objectForKey:@"code"];
//                    if([code isEqualToString:SUCCESS]) {
//                        model.isAdd = YES;
//                        [btnFunc setUserInteractionEnabled:NO];
//                        [btnFunc setTitle:@"已添加" forState:UIControlStateNormal];
//                        [btnFunc setBackgroundColor:[UIColor grayColor]];
//                        model.isAdd =YES;
//                        
//                        if([self.delegate respondsToSelector:@selector(CGMineTeamMemberMobileCellClick:model:)]) {
//                            [self.delegate CGMineTeamMemberMobileCellClick:btnFunc model:model];
//                        }
//                        
//                    }
//                    else
//                    {
//                        [MBProgressHUD showError:msg toView:nil];
//                    }
//                } failure:^(NSError *error) {
//                    NSLog(@"%@",[error description]);
//                }];
//                
//            }
//            else
//            {
//                if([self.delegate respondsToSelector:@selector(CGMineTeamMemberMobileCellClick:model:)]) {
//                    model.isAdd = YES;
//                    [btnFunc setUserInteractionEnabled:NO];
//                    [btnFunc setTitle:@"已添加" forState:UIControlStateNormal];
//                    [btnFunc setBackgroundColor:[UIColor grayColor]];
//                    [self.delegate CGMineTeamMemberMobileCellClick:btnFunc model:model];
//                }
//            }
//            
//        }];
//        [self.contentView addSubview:btnFunc];
//    }
    
    //创建“手机号码”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(75, 45, SCREEN_WIDTH-120, 20)];
    [lbMsg2 setText:model.mobile];
    [lbMsg2 setTextColor:COLOR9];
    [lbMsg2 setTextAlignment:NSTextAlignmentLeft];
    [lbMsg2 setFont:FONT14];
    [self.contentView addSubview:lbMsg2];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 74.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:LINE_COLOR];
    [self.contentView addSubview:lineView];
    
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