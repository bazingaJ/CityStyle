//
//  CGOperatingDynamicDetailsViewController.h
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGOperatingDynamicDetailsViewController : UIViewController

@property (nonatomic ,assign) NSInteger fromWhere;

- (void)reloadDynamicList;

@end
