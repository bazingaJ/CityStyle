//
//  YWFilePreviewView.m
//  YWFilePreviewDemo
//
//  Created by dyw on 2017/3/16.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import "YWFilePreviewView.h"
#import <QuickLook/QuickLook.h>

@interface YWFilePreviewView () <QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@property (nonatomic, strong) QLPreviewController *previewController;
@property (nonatomic, strong) NSArray *filePathArr;

@end

@implementation YWFilePreviewView

#pragma mark - life cycle
- (void)awakeFromNib{
    [super awakeFromNib];
    self.frame = kWindow.bounds;
    self.previewController = [[QLPreviewController alloc] init];
    self.previewController.dataSource = self;
    self.previewController.delegate = self;
}

-(void)layoutSubviews{
    self.previewController.view.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT);
    [self addSubview:self.previewController.view];
}

#pragma mark - private methods

#pragma mark - public methods
/** 预览多个文件 单个数组只传一个就好 */
+ (void)previewFileWithPaths:(NSURL *)fileURL {
    YWFilePreviewView *previewView = [[NSBundle mainBundle] loadNibNamed:@"YWFilePreviewView" owner:nil options:nil].lastObject;
    previewView.filePathArr = @[fileURL];
    previewView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [kWindow addSubview:previewView];
    [UIView animateWithDuration:0.25 animations:^{
        previewView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [previewView.previewController reloadData];
    }];
}


#pragma mark - request methods

#pragma mark - QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return self.filePathArr.count;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    //NSURL *url = [NSURL fileURLWithPath:self.filePathArr[index]];
    return self.filePathArr[index];
}

- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id<QLPreviewItem>)item inSourceView:(UIView *__autoreleasing  _Nullable *)view{
    return kWindow.bounds;
}

#pragma mark - event response
- (IBAction)backButtonClick:(id)sender {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)moreButtonClick:(id)sender {
    
    NSLog(@"更多按钮点击");
    
}


#pragma mark - getters and setters

@end
