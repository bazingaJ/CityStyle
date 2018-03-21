//
//  AddressPickView.m
//  Kivii
//
//  Created by 相约在冬季 on 16/8/5.
//  Copyright © 2016年 Kivii. All rights reserved.
//

#import "AddressPickView.h"
#import "UIView+Extension.h"

#define navigationViewHeight 44.0f
#define pickViewViewHeight 260.0f
#define buttonWidth 60.0f
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]

@implementation DistrictModel

@end

@implementation CityModel

- (void)setDistrict_list:(NSArray *)district_list {
    if (!district_list.count) return;
    _district_list = [DistrictModel mj_objectArrayWithKeyValuesArray:district_list];
}

@end

@implementation ProvinceModel

-(void)setCity_list:(NSArray *)city_list {
    if (!city_list.count) return;
    _city_list = [CityModel mj_objectArrayWithKeyValuesArray:city_list];
}

@end


@implementation AddressPickView

//创建“单例模式”
+ (instancetype)CreateInstance {
    static AddressPickView *_createInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _createInstance = [[AddressPickView alloc] init];
    });
    [_createInstance showBottomView];
    return _createInstance;
}

//初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_HEIGHT);
        [self addTapGestureRecognizerToSelf];
        [self getPickerData];
        [self createView];
    }
    return self;
}

//添加手势
-(void)addTapGestureRecognizerToSelf {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottomView)];
    [self addGestureRecognizer:tapGes];
}

//获取地址数据信息
- (void)getPickerData {
    self.provinceArr = [ProvinceModel mj_objectArrayWithFilename:@"address.plist"];
    if(self.provinceArr.count) {
        self.cityArr = ((ProvinceModel *)[self.provinceArr objectAtIndex:0]).city_list;
    }
    if(self.cityArr.count) {
        self.districtArr = ((CityModel *)[self.cityArr objectAtIndex:0]).district_list;
    }
}

//创建“地址视图”
- (void)createView {
    
    //弹出弹出视图层
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, navigationViewHeight+pickViewViewHeight+HOME_INDICATOR_HEIGHT)];
    [_bottomView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_bottomView];
    
    //导航视图
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, navigationViewHeight)];
    _navigationView.backgroundColor = BACK_COLOR;
    [_bottomView addSubview:_navigationView];
    
    //这里添加空手势不然点击navigationView也会隐藏,
    UITapGestureRecognizer *tapNavigationView = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [_navigationView addGestureRecognizer:tapNavigationView];
    
    //创建“确定”、“取消”按钮
    CGFloat subWidth = SCREEN_WIDTH-60*2;
    NSArray *titleArr = @[@"取消",@"确定"];
    for (int i = 0; i <titleArr.count ; i++) {
        UIButton *btnFunc = [UIButton buttonWithType:UIButtonTypeSystem];
        btnFunc.frame = CGRectMake((subWidth+buttonWidth)*i, 0, buttonWidth, navigationViewHeight);
        [btnFunc setTitle:titleArr[i] forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:SYSTEM_FONT_SIZE(18.0)];
        btnFunc.tag = i;
        if(i==0) {
            [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
        }else if(i==1) {
            [btnFunc setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        }
        [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationView addSubview:btnFunc];
    }
    
    //创建“控制面板”
    _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, navigationViewHeight, SCREEN_WIDTH, pickViewViewHeight)];
    _pickView.backgroundColor = [UIColor whiteColor];
    _pickView.dataSource = self;
    _pickView.delegate =self;
    [_bottomView addSubview:_pickView];
    
}

-(void)btnFuncClick:(UIButton *)btnSender {
    if (btnSender.tag == 1) {
        ProvinceModel *provinceModel = [self.provinceArr objectAtIndex:[_pickView selectedRowInComponent:0]];
        CityModel *cityModel = [self.cityArr objectAtIndex:[_pickView selectedRowInComponent:1]];
        DistrictModel *districtModel = [self.districtArr objectAtIndex:[_pickView selectedRowInComponent:2]];
        if(self.block) {
            NSString *nameStr = [NSString stringWithFormat:@"%@ %@ %@",provinceModel.province_name,cityModel.city_name,districtModel.district_name];
            NSString *cityIds = [NSString stringWithFormat:@"%@,%@,%@",provinceModel.province_id,cityModel.city_id,districtModel.district_id];
            self.block(cityIds,nameStr);
        }
    }
    [self hiddenBottomView];
}

//显示面板
-(void)showBottomView {
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.top = SCREEN_HEIGHT-navigationViewHeight-pickViewViewHeight-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT;
        self.backgroundColor = windowColor;
    } completion:^(BOOL finished) {
        
    }];
}

//隐藏面板
-(void)hiddenBottomView {
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.top = SCREEN_HEIGHT;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

#pragma mark - UIPicker委托代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _provinceArr.count;
    } else if (component == 1) {
        return _cityArr.count;
    } else {
        return _districtArr.count;
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lable=[[UILabel alloc]init];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont systemFontOfSize:18.0f];
    if (component == 0) {
        ProvinceModel *provinceModel = [self.provinceArr objectAtIndex:row];
        lable.text = provinceModel.province_name;
    } else if (component == 1) {
        CityModel *cityModel = [self.cityArr objectAtIndex:row];
        lable.text = cityModel.city_name;
    } else {
        DistrictModel *districtModel = [self.districtArr objectAtIndex:row];
        lable.text = districtModel.district_name;
    }
    return lable;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat pickViewWidth = SCREEN_WIDTH/3;
    
    return pickViewWidth;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        if (self.provinceArr.count > 0) {
            self.cityArr = ((ProvinceModel *)[self.provinceArr objectAtIndex:row]).city_list;
        } else {
            self.cityArr = nil;
        }
        if (self.cityArr.count > 0) {
            self.districtArr = ((CityModel *)[self.cityArr objectAtIndex:0]).district_list;
        } else {
            self.districtArr = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.provinceArr.count > 0 && self.cityArr.count > 0) {
            self.districtArr = ((CityModel *)[self.cityArr objectAtIndex:row]).district_list;
        } else {
            self.districtArr = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    [pickerView reloadComponent:2];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

