//
//  CGDropDownMenu.h
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/22.
//  Copyright © 2017年 印特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGDropDownMenu : UIView

/**
 *  顶部高度
 */
@property (nonatomic, assign) CGFloat topH;
/**
 *  显示标识
 */
@property (nonatomic, assign) BOOL isShow;
/**
 *  隐藏
 */
- (void)dismiss;
/**
 *  特殊情况项目及业态处理
 */
@property (nonatomic, assign) BOOL isSP;

/**
 *  初始化
 */
- (id)initWithFrame:(CGRect)frame titleArr:(NSMutableArray *)titleArr;
/**
 *  业态
 */
@property (nonatomic, strong) NSMutableArray *formatArr;
/**
 *  业态
 */
@property (nonatomic, strong) NSMutableArray *xiangmuArr;
/**
 *  类型
 */
@property (nonatomic, strong) NSMutableArray *typeArr;
/**
 *  团队分组
 */
@property (nonatomic, strong) NSMutableArray *teamArr;
/**
 *  团队成员
 */
@property (nonatomic, strong) NSMutableArray *teamMemberArr;
/**
 *  意向区域
 */
@property (nonatomic, strong) NSMutableArray *intentionAreaArr;
/**
 *  字母选择回调
 */
@property (nonatomic, copy) void(^callAZBack)(NSString *letter);
/**
 *  类型选择回调
 */
@property (nonatomic, copy) void(^callTypeBack)(NSString *typd_id,NSString *type_name);
/**
 *  业态选择回调
 */
@property (nonatomic, copy) void(^callFormatListBack)(NSString *first_cate,NSString *second_cate,NSString *third_cate);
/**
 *  业态选择回调(九宫格)
 */
@property (nonatomic, copy) void(^callFormatBack)(NSString *cate_id,NSString *cate_name);
/**
 *  意向度回调
 */
@property (nonatomic, copy) void(^callIntentionBack)(NSString *intentionStr);
/**
 *  业务员回调
 */
@property (nonatomic, copy) void(^callTeamMemberBack)(NSString *member_id,NSString *member_name);
/**
 *  项目回调
 */
@property (nonatomic, copy) void(^callTeamXiangmuBack)(NSString *pro_id,NSString *pro_name);
/**
 *  时间回调
 */
@property (nonatomic, copy) void(^callTimeBack)(NSString *time_id,NSString *time_name);
/**
 *  意向区域回调
 */
@property (nonatomic, copy) void(^callTeamAreaBack)(NSString *area_id,NSString *area_name);
/**
 *  按签约面积回调
 */
@property (nonatomic, copy) void(^callSignAreaBack)(NSString *sign_id,NSString *sign_name);

@end
