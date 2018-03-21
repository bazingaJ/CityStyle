//
//  CGBusinessMattersModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGBusinessMattersModel.h"

@implementation CGBusinessMattersModel

/**
 *  行高
 */
- (CGFloat)cellH {
    CGFloat textH = 0;
    if(!IsStringEmpty(self.intro)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:5.0];
        NSDictionary *attribute = @{NSFontAttributeName:FONT14,NSParagraphStyleAttributeName:style};
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
 *  签约铺位ID(多个逗分隔)
 */
-(void)setPos_list:(NSArray *)pos_list {
    _pos_list = pos_list;
    
    NSMutableArray *tempNameArr =[NSMutableArray array];
    NSMutableArray *tempIdArr =[NSMutableArray array];
    for (NSDictionary *itemDic in _pos_list)
    {
        [tempNameArr addObject:itemDic[@"name"]];
        [tempIdArr addObject:itemDic[@"id"]];
    }
    _pos_id = [tempIdArr componentsJoinedByString:@","];
    _pos_name = [tempNameArr componentsJoinedByString:@","];
}

@end
