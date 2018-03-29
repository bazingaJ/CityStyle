//
//  CGMineTeamMemberContactCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineTeamMemberContactCell.h"

@implementation CGMineTeamMemberContactCell

- (void)setContactModel:(CGContactModel *)model pro_id:(NSString *)pro_id {
    
    //创建“头像”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 55, 55)];
    [imgView.layer setCornerRadius:4.0];
    [imgView.layer setMasksToBounds:YES];
    if (!IsStringEmpty(model.avatar))
    {
        [imgView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    }
    else
    {
       [imgView setImage:[UIImage imageNamed:@"contact_icon_avatar"]];
    }
    [self.contentView addSubview:imgView];
    
    //创建“成员名称”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, SCREEN_WIDTH-120, 20)];
    [lbMsg setText:model.name];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [self.contentView addSubview:lbMsg];
    
    //创建“邀请”按钮
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 25, 60, 25)];
    if (IsStringEmpty(model.user_id))
    {
        [btnFunc setTitle:@"邀请" forState:UIControlStateNormal];
        [btnFunc setBackgroundColor:MAIN_COLOR];
        [btnFunc setTag:100];
    }
    if (model.isAdd && !IsStringEmpty(model.user_id))
    {
        [btnFunc setUserInteractionEnabled:NO];
        [btnFunc setTitle:@"已添加" forState:UIControlStateNormal];
        [btnFunc setBackgroundColor:[UIColor grayColor]];
    }
    if (!model.isAdd && !IsStringEmpty(model.user_id))
    {
        [btnFunc setTitle:@"添加" forState:UIControlStateNormal];
        [btnFunc setBackgroundColor:MAIN_COLOR];
        [btnFunc setTag:200];
    }
    [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT15];
    [btnFunc.layer setCornerRadius:4.0];
    [self.contentView addSubview:btnFunc];
    
    [btnFunc addTouch:^{
     
        if (btnFunc.tag ==100)
        {
            if([self.delegate respondsToSelector:@selector(CGMineTeamMemberContactCellClick:model:)])
            {
                [self.delegate CGMineTeamMemberContactCellClick:btnFunc model:model];
            }
        }
        if(btnFunc.tag==200 && !self.isAdd)
        {
            //添加团队成员
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:@"ucenter" forKey:@"app"];
            [param setValue:@"addNewUser" forKey:@"act"];
            [param setValue:model.user_id forKey:@"member"];
            [param setValue:pro_id forKey:@"pro_id"];
            [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                NSString *msg = [json objectForKey:@"msg"];
                NSString *code = [json objectForKey:@"code"];
                if([code isEqualToString:SUCCESS]) {
                    model.isAdd = YES;
                    [btnFunc setUserInteractionEnabled:NO];
                    [btnFunc setTitle:@"已添加" forState:UIControlStateNormal];
                    [btnFunc setBackgroundColor:[UIColor grayColor]];
                    
                    if([self.delegate respondsToSelector:@selector(CGMineTeamMemberContactCellClick:model:)]) {
                        [self.delegate CGMineTeamMemberContactCellClick:btnFunc model:model];
                    }
                }else{
                    [MBProgressHUD showError:msg toView:nil];
                }
            } failure:^(NSError *error) {
                
            }];
            
        }
         if(btnFunc.tag==200 && self.isAdd)
        {
            if([self.delegate respondsToSelector:@selector(CGMineTeamMemberContactCellClick:model:)])
            {
                model.isAdd = YES;
                [btnFunc setUserInteractionEnabled:NO];
                [btnFunc setTitle:@"已添加" forState:UIControlStateNormal];
                [btnFunc setBackgroundColor:[UIColor grayColor]];
                [self.delegate CGMineTeamMemberContactCellClick:btnFunc model:model];
            }
        }
        
    }];
    
    
    
//    if([model.isIn isEqualToString:@"1"]) {
//       
//        if(IsStringEmpty(model.id)) {
//            [btnFunc setTitle:@"邀请" forState:UIControlStateNormal];
//            [btnFunc setBackgroundColor:MAIN_COLOR];
//            [btnFunc setTag:100];
//        }else if([model.isIn isEqualToString:@"3"]) {
//            if(model.isAdd) {
//                [btnFunc setUserInteractionEnabled:NO];
//                [btnFunc setTitle:@"已添加" forState:UIControlStateNormal];
//                [btnFunc setBackgroundColor:[UIColor grayColor]];
//            }else{
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
//                        
//                        if([self.delegate respondsToSelector:@selector(CGMineTeamMemberContactCellClick:model:)]) {
//                            [self.delegate CGMineTeamMemberContactCellClick:btnFunc model:model];
//                        }
//                        
//                    }else{
//                        [MBProgressHUD showError:msg toView:nil];
//                    }
//                } failure:^(NSError *error) {
//                    NSLog(@"%@",[error description]);
//                }];
//                
//            }else{
//                if([self.delegate respondsToSelector:@selector(CGMineTeamMemberContactCellClick:model:)])
//                {
////                    model.isAdd = YES;
////                    [btnFunc setUserInteractionEnabled:NO];
////                    [btnFunc setTitle:@"已添加" forState:UIControlStateNormal];
////                    [btnFunc setBackgroundColor:[UIColor grayColor]];
//                    [self.delegate CGMineTeamMemberContactCellClick:btnFunc model:model];
//                }
//            }
//            
//        }];
//        [self.contentView addSubview:btnFunc];
//    }
    
    //创建“手机号码”
    UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(75, 45, SCREEN_WIDTH-120, 20)];
    [lbMsg2 setText:model.mobileStr];
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
