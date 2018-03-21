//
//  CGContractModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGContractModel.h"

@implementation CGContractModel

/**
 *  单元格高度(递增方式)
 */
- (CGFloat)cellH {
    CGFloat textH = 0;
    if(!IsStringEmpty(self.rent_increase)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:5.0];
        NSDictionary *attribute = @{NSFontAttributeName:FONT14,NSParagraphStyleAttributeName:style};
        CGSize retSize = [self.rent_increase boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT)
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

/**
 *  单元格高度(备注信息)
 */
- (CGFloat)cellH2 {
    CGFloat textH = 0;
    if(!IsStringEmpty(self.note)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:5.0];
        NSDictionary *attribute = @{NSFontAttributeName:FONT14,NSParagraphStyleAttributeName:style};
        CGSize retSize = [self.note boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT)
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

/**
 *  单元格高度(终止详情)
 */
- (CGFloat)cellH3 {
    CGFloat textH = 0;
    if(!IsStringEmpty(self.destroy_note)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:5.0];
        NSDictionary *attribute = @{NSFontAttributeName:FONT14,NSParagraphStyleAttributeName:style};
        CGSize retSize = [self.destroy_note boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT)
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


/**
 *  附件
 */
- (NSMutableArray *)images {
    if(!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

/**
 *  终止时上传的附件
 */
- (NSMutableArray *)destroy_images {
    if(!_destroy_images) {
        _destroy_images = [NSMutableArray array];
    }
    return _destroy_images;
}

/**
 *  铺位列表
 */
- (void)setPosition:(NSArray *)position
{
    _position = [CGPositionExModel mj_objectArrayWithKeyValuesArray:position];
}

/**
 * 选择的铺位列表
 */
- (void)setChoose_pos_list:(NSArray *)choose_pos_list
{
    _choose_pos_list = choose_pos_list;
    
    NSMutableArray *tempNameArr =[NSMutableArray array];
    NSMutableArray *tempIdArr =[NSMutableArray array];
    NSMutableArray *tempAreaArr =[NSMutableArray array];
    for (NSDictionary *itemDic in _choose_pos_list)
    {
        [tempNameArr addObject:itemDic[@"pos_name"]];
        [tempIdArr addObject:itemDic[@"pos_id"]];
        [tempAreaArr addObject:itemDic[@"pos_area"]];
    }
    
    float z = 0;
    for (int i=0; i<[tempAreaArr count]; i++)
    {
        float a = [[tempAreaArr objectAtIndex:i]floatValue];
        z += a;
    }
    _area = [NSString stringWithFormat:@"%.2f",z];
    _pos_ids = [tempIdArr componentsJoinedByString:@","];
    _pos_name = [tempNameArr componentsJoinedByString:@","];
}
@end
