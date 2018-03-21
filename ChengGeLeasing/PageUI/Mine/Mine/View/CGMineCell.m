//
//  CGMineCell.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGMineCell.h"

@implementation CGMineCell

- (void)setMineCellModel:(CGUserModel *)model indexPath:(NSIndexPath *)indexPath titleDic:(NSMutableDictionary *)titleDic {
    if(!model) return;
    
    NSArray *titleArr = [titleDic objectForKey:[NSString stringWithFormat:@"%zd",indexPath.section]];
    NSArray *itemArr = [titleArr objectAtIndex:indexPath.row];
    
    //创建“图标”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10.5, 22, 24)];
    [imgView setImage:[UIImage imageNamed:itemArr[0]]];
    [imgView sizeToFit];
    imgView.centerY = 22.5;
    [self.contentView addSubview:imgView];
    
    //创建“标题”
    UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, SCREEN_WIDTH-60, 25)];
    [lbMsg setText:itemArr[1]];
    [lbMsg setTextColor:COLOR3];
    [lbMsg setTextAlignment:NSTextAlignmentLeft];
    [lbMsg setFont:FONT16];
    [lbMsg sizeToFit];
    [lbMsg setCenterY:22.5];
    [self.contentView addSubview:lbMsg];
    
    //数字
    if([itemArr[2] integerValue]==1)
    {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:@"ucenter" forKey:@"app"];
        [param setValue:@"getNoRedNum" forKey:@"act"];
        [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
        {
            NSString *code = json[@"code"];
            if ([code isEqualToString:SUCCESS])
            {
                NSString *num = json[@"data"][@"num"];
                if (IsStringEmpty(num) || [num isEqualToString:@"0"]) return;
                UILabel *lbNum = [[UILabel alloc] initWithFrame:CGRectMake(lbMsg.right+5, 10, 15, 15)];
                [lbNum setText:num];
                [lbNum setTextColor:[UIColor whiteColor]];
                [lbNum setTextAlignment:NSTextAlignmentCenter];
                [lbNum setFont:FONT10];
                [lbNum setBackgroundColor:RED_COLOR];
                [lbNum.layer setCornerRadius:7.5];
                [lbNum.layer setMasksToBounds:YES];
                [self.contentView addSubview:lbNum];
            }
        } failure:^(NSError *error) {
            
        }];
    }
    
    //创建“右侧尖头”
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20, 17.5, 5.5, 10)];
    [imgView2 setImage:[UIImage imageNamed:@"mine_arrow_right"]];
    [self.contentView addSubview:imgView2];
    
    //创建“分割线”
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
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
