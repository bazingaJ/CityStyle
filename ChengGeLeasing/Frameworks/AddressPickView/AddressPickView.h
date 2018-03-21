//
//  AddressPickView.h
//  Kivii
//
//  Created by 相约在冬季 on 16/8/5.
//  Copyright © 2016年 Kivii. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AdressBlock) (NSString *cityIds, NSString *nameStr);

@interface DistrictModel : NSObject

@property (nonatomic, strong) NSString *district_id;
@property (nonatomic, strong) NSString *district_name;

@end

@interface CityModel : NSObject

@property (nonatomic, strong) NSString *city_id;
@property (nonatomic, strong) NSString *city_name;
@property (nonatomic, strong) NSArray *district_list;

@end

@interface ProvinceModel : NSObject

@property (nonatomic, strong) NSString *province_id;
@property (nonatomic, strong) NSString *province_name;
@property (nonatomic, strong) NSArray  *city_list;

@end

@interface AddressPickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

//单利模式
+ (instancetype)CreateInstance;
//回调
@property (nonatomic, copy) AdressBlock block;

@property(nonatomic, strong) NSDictionary *pickerDic;
@property(nonatomic, strong) NSArray *provinceArr;
@property(nonatomic, strong) NSArray *cityArr;
@property(nonatomic, strong) NSArray *districtArr;
@property(nonatomic, strong) UIView *bottomView;//包括导航视图和地址选择视图
@property(nonatomic, strong) UIPickerView *pickView;//地址选择视图
@property(nonatomic, strong) UIView *navigationView;//上面的导航视图

@end



