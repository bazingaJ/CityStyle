//
//  CGFloorSheetView.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2018/1/25.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "CGFloorSheetView.h"
#import "CGFloorModel.h"

static NSString * const CGFloorSheetViewCellID = @"CGFloorSheetViewCell";

@implementation CGFloorSheetView

/**
 *  懒加载“collectionView”
 */
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0,  10);
        flowLayout.itemSize = CGSizeMake((self.frame.size.width-10*5)/4, 30);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, self.yPosition-HOME_INDICATOR_HEIGHT-90) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.contentInset = UIEdgeInsetsZero;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CGFloorSheetViewCellID];
        [_backView addSubview:_collectionView];
        
    }
    return _collectionView;
}

/**
 *  懒加载
 */
- (NSMutableArray *)dataArr {
    if(!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

/**
 *  懒加载
 */
- (NSMutableArray *)itemArr {
    if(!_itemArr) {
        _itemArr = [NSMutableArray array];
    }
    return _itemArr;
}

- (id)initWithFrame:(CGRect)frame titleStr:(NSString *)titleStr {
    self = [super initWithFrame:frame];
    if(self) {
        
        //设置frame
        CGRect rect = [UIScreen mainScreen].bounds;
        self.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        //设置面板高度
        self.yPosition = 270;
        
        //创建“View”背景层
        CGRect frame = self.backView.frame;
        frame.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.yPosition);
        frame.origin = CGPointMake(0, self.frame.size.height);
        
        //创建“背景层”
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.userInteractionEnabled = YES;
        _backView.frame = frame;
        [self addSubview:_backView];
        
        //创建“经营业态”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, _backView.frame.size.width-20, 25)];
        [lbMsg setText:titleStr];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT17];
        [_backView addSubview:lbMsg];
        
        //创建“分割线”
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, _backView.frame.size.width, 0.5)];
        [lineView setBackgroundColor:LINE_COLOR];
        [_backView addSubview:lineView];
        
        //创建“collectionView”
        [self collectionView];
        
        //创建“确定”按钮事件
        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, _backView.frame.size.height-HOME_INDICATOR_HEIGHT-45, _backView.frame.size.width, 45)];
        [btnFunc setTitle:@"确定" forState:UIControlStateNormal];
        [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT17];
        [btnFunc setBackgroundColor:MAIN_COLOR];
        [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:btnFunc];
        
        //弹层
        [self showAlert];
        
    }
    return self;
}

/**
 *  Sections
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/**
 *  Items
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

///**
// *  定义每个UICollectionViewCell 的大小
// */
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(60, 80);
//}
//
////定义每个Section 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(15, 15, 5, 15);//分别为上、左、下、右
//}
//
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={self.frame.size.width,10};
    return size;
}
//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size={self.frame.size.width,10};
    return size;
}
////每个section中不同的行之间的行间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}
//
////每个item之间的间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 100;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CGFloorSheetViewCellID forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat tWidth = (self.frame.size.width-10*5)/4;
    
    CGFloorModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    
    //创建“业态标题”
    UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tWidth, 30)];
    [btnFunc setTitle:model.floor_name forState:UIControlStateNormal];
    [btnFunc.titleLabel setFont:FONT13];
    if([self.itemArr containsObject:model.floor_id]) {
        //选中
        [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnFunc setBackgroundColor:MAIN_COLOR];
        [btnFunc setSelected:YES];
        model.is_selected = YES;
    }else{
        //未选中
        [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
        [btnFunc setBackgroundColor:[UIColor whiteColor]];
        [btnFunc.layer setBorderWidth:1];
        [btnFunc.layer setBorderColor:LINE_COLOR.CGColor];
        [btnFunc setSelected:NO];
        model.is_selected = NO;
    }
    [btnFunc.layer setCornerRadius:3.0];
    [btnFunc addTouch:^{
        NSLog(@"点击业态");
        
        if(!self.isMultiple) {
            
            //清除已选中所有状态
            for (int i=0; i<self.dataArr.count; i++) {
                CGFloorModel *model = [self.dataArr objectAtIndex:i];
                model.is_selected = NO;
                [self.itemArr removeObject:model.floor_id];
            }
            [self.collectionView reloadData];
            
        }
        
        btnFunc.selected = !btnFunc.selected;
        [btnFunc setSelected:btnFunc.selected];
        if(btnFunc.isSelected) {
            [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnFunc setBackgroundColor:MAIN_COLOR];
            model.is_selected = YES;
            [self.itemArr addObject:model.floor_id];
        }else{
            [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
            [btnFunc setBackgroundColor:[UIColor whiteColor]];
            model.is_selected = NO;
            [self.itemArr removeObject:model.floor_id];
        }
        
    }];
    [cell.contentView addSubview:btnFunc];
    
    return cell;
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CGFormatModel *model;
    //    if(self.cateArr.count) {
    //        model = [self.cateArr objectAtIndex:indexPath.row];
    //    }
    //    if(!model) return;
    //
    //    if(self.callBack) {
    //        self.callBack(model.id, model.name);
    //        [self dismiss];
    //    }
    
}
////取消选择了某个cell
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    [cell setBackgroundColor:[UIColor redColor]];
//}

/**
 *  确定按钮点击事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"确定");
    
    [self.itemArr removeAllObjects];
    NSMutableArray *nameArr = [NSMutableArray array];
    for (int i=0; i<self.dataArr.count; i++) {
        CGFloorModel *model = [self.dataArr objectAtIndex:i];
        if(!model.is_selected) continue;
        
        [self.itemArr addObject:model.floor_id];
        [nameArr addObject:model.floor_name];
    }
    NSString *cateId = [self.itemArr componentsJoinedByString:@","];
    NSString *cateName = [nameArr componentsJoinedByString:@","];
    if(self.callBack) {
        self.callBack(cateId, cateName);
        [self dismiss];
    }
    
}

//显示弹出层
- (void)show {
    [UIView animateWithDuration:.23 animations:^{
        CGRect frame = _backView.frame;
        frame.origin.y -= self.yPosition;
        _backView.frame = frame;
    }];
}

//关闭弹出层
- (void)dismiss {
    [UIView animateWithDuration:.23 animations:^{
        CGRect frame = self.backView.frame;
        frame.origin.y += self.yPosition;
        self.backView.frame = frame;
        [self removeFromSuperview];
    } completion:^(BOOL complete){
        //[self.delegate EYWalletPaySheetSheetPressed:self index:self.index];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self topToDismiss];
}

- (void)showAlert {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

- (void)topToDismiss {
    self.index = -1;
    [self dismiss];
}

/**
 *  获取业态列表
 */
- (void)getFloorList {
    
    [self.dataArr removeAllObjects];
    NSArray *itemArr = @[@"-2F",@"-1F",@"1F",@"2F",@"3F",@"4F",@"5F",@"5F以上"];
    for (int i=0; i<[itemArr count]; i++) {
        CGFloorModel *model = [CGFloorModel new];
        model.floor_id = [NSString stringWithFormat:@"%zd",i+1];
        model.floor_name = itemArr[i];
        [self.dataArr addObject:model];
    }
    [self.collectionView reloadData];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
