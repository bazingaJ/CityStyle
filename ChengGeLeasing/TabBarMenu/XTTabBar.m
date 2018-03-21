//
//  XTTabBar.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/8.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "XTTabBar.h"

@implementation XTTabBar

- (instancetype)init {
    self = [super init];
    if(self) {
        
        UIButton *btnCenter = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnCenter setImage:[UIImage imageNamed:@"tabbar_icon_popup"] forState:UIControlStateNormal];
        btnCenter.bounds = CGRectMake(0, 0, 64, 49);
        self.btnCenter = btnCenter;
        [self addSubview:btnCenter];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.btnCenter.center = CGPointMake(self.bounds.size.width * 0.5, 24.5);
    
    int index = 0;
    CGFloat wigth = self.bounds.size.width / 5;
    for (UIView* sub in self.subviews) {
        if ([sub isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            sub.frame = CGRectMake(index * wigth, 0, wigth, 49);
            index++;
            if (index == 2) {
                index++;
            }
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isHidden == NO) {
        
        CGPoint newPoint = [self convertPoint:point toView:self.btnCenter];
        
        if ( [self.btnCenter pointInside:newPoint withEvent:event]) {
            return self.btnCenter;
        }else{
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {
        return [super hitTest:point withEvent:event];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
