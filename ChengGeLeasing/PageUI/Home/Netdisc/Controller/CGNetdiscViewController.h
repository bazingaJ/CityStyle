//
//  CGNetdiscViewController.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/27.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGNetdiscCell.h"

@interface CGNetdiscViewController : BaseTableViewController<SWTableViewCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) KLCPopup *popup;

@end
