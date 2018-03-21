//
//  CGBunkModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGBunkModel.h"

@implementation CGBunkModel

/**
 *  期望业态ID数组集合（自定义）
 */
- (NSMutableArray *)wantCateArr {
    
    if(!IsStringEmpty(self.want_cate_id)) {
        NSMutableArray *formatArr = [[self.want_cate_id componentsSeparatedByString:@","] mutableCopy];
        return formatArr;
    }
    return [NSMutableArray array];
    
}

/**
 *  包含的物业条件(自定义)
 */
- (NSMutableArray *)propertyArr {
    
    if(!_propertyArr) {
        _propertyArr = [NSMutableArray array];
        if(!IsStringEmpty(self.property)) {
            NSArray *itemArr = [self.property componentsSeparatedByString:@","];
            for (int i=0; i<[itemArr count]; i++) {
                [_propertyArr addObject:itemArr[i]];
            }
        }
    }
    return _propertyArr;
    
}

/**
 *  标题高度
 */
- (CGFloat)cellH {
    CGFloat textH = 0;
    if(!IsStringEmpty(self.note)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:5.0];
        NSDictionary *attribute = @{NSFontAttributeName:FONT14,NSParagraphStyleAttributeName:style};
        CGSize retSize = [self.note boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-95-30, MAXFLOAT)
                                                 options:\
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                              attributes:attribute
                                                 context:nil].size;
        textH = retSize.height+20;
    }
    return textH<45?45:textH;
}

@end
