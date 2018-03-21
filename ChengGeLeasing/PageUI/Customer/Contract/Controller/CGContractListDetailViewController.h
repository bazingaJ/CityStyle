//
//  CGContractListDetailViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPhotoPickerBrowserViewController.h"

@interface CGContractListDetailViewController : BaseTableViewController<ZLPhotoPickerBrowserViewControllerDelegate>

/**
 *  合同ID
 */
@property (nonatomic, strong) NSString *contract_id;

@end
