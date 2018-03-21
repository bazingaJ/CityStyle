//
//  CGFindModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/14.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGFindModel.h"

@implementation CGFindModel

/**
 *  标题高度
 */
- (CGFloat)cellH {
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
    return textH;
}


@end
