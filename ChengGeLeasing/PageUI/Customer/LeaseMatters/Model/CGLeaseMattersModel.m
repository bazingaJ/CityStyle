//
//  CGLeaseMattersModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLeaseMattersModel.h"

@implementation CGLeaseMattersModel

/**
 *  行高
 */
- (CGFloat)cellH {
    CGFloat textH = 0;
    if(!IsStringEmpty(self.intro)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:5.0];
        NSDictionary *attribute = @{NSFontAttributeName:FONT16,NSParagraphStyleAttributeName:style};
        CGSize retSize = [self.intro boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT)
                                                 options:\
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                              attributes:attribute
                                                 context:nil].size;
        textH = retSize.height+20;
    }
    return textH<=60 ? 60 : textH;
}


-(void)setChoose_pos_list:(NSArray *)choose_pos_list
{
    _choose_pos_list = choose_pos_list;
    
    NSMutableArray *tempNameArr =[NSMutableArray array];
    NSMutableArray *tempIdArr =[NSMutableArray array];
    for (NSDictionary *itemDic in _choose_pos_list)
    {
        [tempNameArr addObject:itemDic[@"pos_name"]];
        [tempIdArr addObject:itemDic[@"pos_id"]];
    }
    _pos_id = [tempIdArr componentsJoinedByString:@","];
    _pos_name = [tempNameArr componentsJoinedByString:@","];
}

-(void)setPosition:(NSArray *)position
{
    _position =[CGPositionExModel mj_objectArrayWithKeyValuesArray:position];
}


/**
 *  附件
 */
- (NSMutableArray *)images {
    if(!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

@end
