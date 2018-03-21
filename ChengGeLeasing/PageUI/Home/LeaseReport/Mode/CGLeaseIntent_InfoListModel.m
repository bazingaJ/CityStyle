//
//  CGLeaseIntent_InfoListModel.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/18.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLeaseIntent_InfoListModel.h"

@implementation CGLeaseIntent_InfoListModel

/**
 *  单元格高度简报详情
 */
- (CGFloat)cellHeight {
    CGFloat textH = 0;
    if(!IsStringEmpty(self.intro))
    {
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
    return textH;
}


@end
