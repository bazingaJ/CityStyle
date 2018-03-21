//
//  CGHomeCollectionView.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/8/7.
//  Copyright © 2017年 田浩渺. All rights reserved.
//

#import "CGHomeCollectionView.h"

@implementation CGHomeCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self)
    {
        //创建"CollectionView"
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[CGHomeCollectionViewCell class] forCellWithReuseIdentifier:@"CGHomeCollectionViewCell"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CGHomeCollectionViewHeader"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CGHomeCollectionViewFooter"];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _model.position.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CGPositionModel *model = _model.position[section];
    
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
        UICollectionReusableView *backView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CGHomeCollectionViewHeader" forIndexPath:indexPath];
        reusableView = backView;
        for (UIView *view  in reusableView.subviews)
        {
            [view removeFromSuperview];
        }
        
        CGPositionModel *model = _model.position[indexPath.section];
        
        //创建楼层
        UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 50, 30)];
        lbMsg.textColor = COLOR9;
        lbMsg.font = FONT11;
        lbMsg.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:lbMsg];
        lbMsg.textAlignment = NSTextAlignmentLeft;
        lbMsg.text = model.name;
        
        //创建"出租率"/"铺位"/"面积"
        float width = (SCREEN_WIDTH -50-50)/3;
        for (int i =0; i<3; i++)
        {
            UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(i*width+45, 0, width, 30)];
            lbMsg.textColor = COLOR9;
            lbMsg.font = FONT11;
            
            lbMsg.textAlignment = NSTextAlignmentCenter;
            [backView addSubview:lbMsg];
            switch (i) {
                case 0:
                {
                    //出租率
                    NSString * rents;
                    if ([model.letting_rate isEqualToString:@"0"])
                    {
                        rents = @"0";
                    }
                    else
                    {
                        rents = model.letting_rate;
                    }
                    lbMsg.text =[NSString stringWithFormat:@"出租率:%@%%",rents];
                    lbMsg.frame =CGRectMake(65, 0, 75, 30);
                }
                    break;
                case 1:
                {
                    //铺位
                    lbMsg.text =[NSString stringWithFormat:@"铺位:%@/%@个",model.sign_num,model.total_num];
                    lbMsg.frame =CGRectMake(65+70, 0, 80, 30);
                }
                    break;
                case 2:
                {
                    //面积
                    lbMsg.text =[NSString stringWithFormat:@"面积:%@㎡/%@㎡",model.sign_area,model.total_area];
                    lbMsg.frame =CGRectMake(65+75+80, 0,width*3-(70+80), 30);
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        //创建"详情按钮"
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH-50, 0, 35, 30);
        [btn setImage:[UIImage imageNamed:@"home_quyupuwei_icon"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sectionDetails:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 70+indexPath.section;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -12);
        [backView addSubview:btn];
        
    }
    if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CGHomeCollectionViewFooter" forIndexPath:indexPath];
        footerview.backgroundColor = kRGB(245, 245, 245);
        reusableView = footerview;
    }    
    return reusableView;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CGHomeCollectionViewCell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    CGPositionModel *positionModel = [_model.position objectAtIndex:indexPath.section];
    CGHomePos_listModel * pos_listModel =[positionModel.pos_list objectAtIndex:indexPath.row];
    [cell setModel:pos_listModel];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGPositionModel *positionModel = [_model.position objectAtIndex:indexPath.section];
    CGHomePos_listModel * pos_listModel =[positionModel.pos_list objectAtIndex:indexPath.row];

    if (self.callBack)
    {
        self.callBack(pos_listModel.pos_id);
    }
}


-(void)sectionDetails:(UIButton *)sender
{
     CGPositionModel *model = _model.position[sender.tag -70];
    if (self.callRegionalUnitState)
    {
        self.callRegionalUnitState(model.id,model.name);
    }
}

@end
