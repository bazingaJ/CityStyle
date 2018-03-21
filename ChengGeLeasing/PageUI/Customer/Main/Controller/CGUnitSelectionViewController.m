//
//  CGUnitSelectionViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/20.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGUnitSelectionViewController.h"
#import "CGUnitSelectionCollectionViewCell.h"

@interface CGUnitSelectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic ,strong) UICollectionView *collectionView;

@end

@implementation CGUnitSelectionViewController

-(NSMutableArray *)dataArr
{
    if (!_dataArr)
    {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
//懒加载
-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(66 , 66);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 12, 12, 12);
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumLineSpacing = 12;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.userInteractionEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CGUnitSelectionCollectionViewCell class] forCellWithReuseIdentifier:@"CGUnitSelectionCollectionViewCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CGsigningUnitCollectionViewHeader"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CGsigningUnitCollectionViewFooter"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)viewDidLoad
{
    [self setRightButtonItemTitle:@"保存"];
    
    [super viewDidLoad];
    
    self.title = @"选择铺位";
    
    [self collectionView];
    
//    if (!self.sign_arr)
//    {
//        //请求数据
//        [self getPosListByTenant];
//    }
//    else
//    {
//        self.dataArr =[CGSigningUnitModel mj_objectArrayWithKeyValuesArray:self.sign_arr];
//        [self.collectionView reloadData];
//    }
}

-(void)rightButtonItemClick
{
    NSMutableArray *posNameArr = [NSMutableArray array];
    NSMutableArray *posIdArr = [NSMutableArray array];
    NSMutableArray *posAreaArr = [NSMutableArray array];
    for (CGPositionExModel *model in self.dataArr)
    {
        for (CGPositionPosListModel *posModel in model.pos_list)
        {
            if ([posModel.is_choose isEqualToString:@"1"])
            {
                [posNameArr addObject:posModel.pos_name];
                [posIdArr addObject:posModel.pos_id];
                [posAreaArr addObject:posModel.pos_area];
            }
        }
    }
    
    if (self.callBack)
    {
        self.callBack([posIdArr componentsJoinedByString:@","], [posNameArr componentsJoinedByString:@","],[posAreaArr componentsJoinedByString:@","]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  self.dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CGPositionExModel *model = [self.dataArr objectAtIndex:section];
    return model.pos_list.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {SCREEN_WIDTH, 30};
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = {SCREEN_WIDTH, 10};
    return size;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        UICollectionReusableView *backView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CGsigningUnitCollectionViewHeader" forIndexPath:indexPath];
        reusableView = backView;
        
        for (UIView *view  in reusableView.subviews)
        {
            [view removeFromSuperview];
        }
        CGPositionExModel *model = self.dataArr[indexPath.section];
        //创建楼层
        UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 300, 30)];
        lbMsg.textColor = COLOR9;
        lbMsg.font = FONT11;
        lbMsg.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:lbMsg];
        lbMsg.textAlignment = NSTextAlignmentLeft;
        lbMsg.text = model.name;
    }
    if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CGsigningUnitCollectionViewFooter" forIndexPath:indexPath];
        
        footerview.backgroundColor = kRGB(245, 245, 245);
        reusableView = footerview;
    }
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGUnitSelectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CGUnitSelectionCollectionViewCell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
 
    CGPositionExModel *model = self.dataArr[indexPath.section];
    CGPositionPosListModel *posModel = model.pos_list[indexPath.row];
    [cell setModel:posModel];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGPositionExModel *model = self.dataArr[indexPath.section];
    CGPositionPosListModel *posModel = model.pos_list[indexPath.row];
    if ([posModel.pos_status isEqualToString:@"3"] || [posModel.pos_status isEqualToString:@"4"])
    {
        return;
    }
    
    if ([posModel.is_choose isEqualToString:@"1"])
    {
        posModel.is_choose = @"0";
    }
    else
    {
         posModel.is_choose = @"1";
    }
    
    [self.collectionView reloadData];
}

-(void)getPosListByTenant
{

}

@end
