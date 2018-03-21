//
//  CGCropImageViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/26.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGCropImageViewController.h"
#import "TKImageView.h"

#define CROP_PROPORTION_IMAGE_WIDTH 30.0f
#define CROP_PROPORTION_IMAGE_SPACE 48.0f
#define CROP_PROPORTION_IMAGE_PADDING 20.0f

@interface CGCropImageViewController () {
    NSArray *proportionImageNameArr;
    NSArray *proportionImageNameHLArr;
    NSArray *proportionArr;
    NSMutableArray *proportionBtnArr;
    CGFloat currentProportion;
}

@property (nonatomic, strong) TKImageView *tkImageView;

@end

@implementation CGCropImageViewController

- (void)viewDidLoad {
    [self setRightButtonItemTitle:@"确定"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpTKImageView];
    
    //设置裁剪参数
    proportionArr = @[@0, @1, @(4.0/3.0), @(3.0/4.0), @(16.0/9.0), @(9.0/16.0)];
    currentProportion = [proportionArr[_tIndex] floatValue];
    _tkImageView.cropAspectRatio = currentProportion;
    
}

/**
 *  确定按钮事件
 */
- (void)rightButtonItemClick {
    NSLog(@"确定");
    //裁剪
    UIImage *cropImg = [_tkImageView currentCroppedImage];
    if(self.callImageBack) {
        self.callImageBack(cropImg);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)setUpTKImageView {
    
    _tkImageView = [[TKImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _tkImageView.toCropImage = _image;
    _tkImageView.showMidLines = YES;
    _tkImageView.needScaleCrop = YES;
    _tkImageView.showCrossLines = YES;
    _tkImageView.cornerBorderInImage = NO;
    _tkImageView.cropAreaCornerWidth = 44;
    _tkImageView.cropAreaCornerHeight = 44;
    _tkImageView.minSpace = 30;
    _tkImageView.cropAreaCornerLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaBorderLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaCornerLineWidth = 6;
    _tkImageView.cropAreaBorderLineWidth = 4;
    _tkImageView.cropAreaMidLineWidth = 20;
    _tkImageView.cropAreaMidLineHeight = 6;
    _tkImageView.cropAreaMidLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaCrossLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaCrossLineWidth = 4;
    _tkImageView.initialScaleFactor = .8f;
    [self.view addSubview:_tkImageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
