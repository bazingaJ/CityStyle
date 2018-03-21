//
//  CGCustomerModel.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGCustomerModel.h"

@implementation CGCustomerModel

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
 *  供电要求(数组)
 */
- (NSMutableArray *)electric {
    if(!_electric) {
        _electric = [NSMutableArray array];
    }
    return _electric;
}

/**
 *  燃气要求(数组)
 */
- (NSMutableArray *)gas {
    if(!_gas) {
        _gas = [NSMutableArray array];
    }
    return _gas;
}

/**
 *  面积要求
 */
- (void)setArea:(NSString *)area {
    _area = area;
    
    NSArray *itemArr = [_area componentsSeparatedByString:@","];
    if(itemArr.count>=1) {
        self.min_area = itemArr[0];
    }
    if(itemArr.count==2) {
        self.max_area = itemArr[1];
    }
    
}

/**
 *  面积段(暖通)
 */
- (void)setWarming_area:(NSString *)warming_area {
    _warming_area = warming_area;
    
    NSArray *itemArr = [_warming_area componentsSeparatedByString:@","];
    if(itemArr.count>=1) {
        self.warming_min_area = itemArr[0];
    }
    if(itemArr.count==2) {
        self.warming_max_area = itemArr[1];
    }
    
}

@end
