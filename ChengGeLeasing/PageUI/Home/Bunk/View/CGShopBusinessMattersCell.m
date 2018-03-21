//
//  CGShopBusinessMattersCell.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGShopBusinessMattersCell.h"
#import "CGUnitBusinessMattersCollectionViewCell.h"
@interface CGShopBusinessMattersCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic ,strong) UICollectionView *collectionView;

@end

@implementation CGShopBusinessMattersCell

-(void)setModel:(CGShopBusinessMattersModel *)model withIndexPath:(NSIndexPath *)indexPath
{
    _model = model;
    _indexPath = indexPath;
    
    switch (indexPath.section)
    {
        case 0:
        {
            //第一区
            [self setUpView1];
        }
            break;
        case 1:
        {
            //第二区
            [self setUpView2];
        }
            break;
        case 2:
        {
            //第三区
           [self setUpView3];

        }
            break;
            
        default:
            break;
    }
}

-(void)setUpView1
{
    //创建"标题"
    UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 85, 50)];
    lbMsg.font = FONT15;
    lbMsg.textColor = COLOR3;
    [self.contentView addSubview:lbMsg];
    
    //创建"内容Lab"
    UILabel *lbMsg1 = [[UILabel alloc]initWithFrame:CGRectMake(lbMsg.right+5, 0, 85, 50)];
    lbMsg1.font = FONT15;
    lbMsg1.textColor = COLOR3;
    [self.contentView addSubview:lbMsg1];
    
    //创建"线"
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(100, 44.5, SCREEN_WIDTH -100, .5)];
    lineView.backgroundColor = LINE_COLOR;
    [self.contentView addSubview:lineView];
    
    switch (self.indexPath.row)
    {
        case 0:
        {
            lbMsg.text = @"铺位名称";
            lbMsg1.text = self.model.name;
        }
            break;
        case 1:
        {
            lbMsg.text = @"面积";
            lbMsg1.text = [NSString stringWithFormat:@"%@",self.model.area];
            
            //创建"㎡"
            UILabel *lbMsg2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -40, 0, 25, 50)];
            lbMsg2.font = FONT12;
            lbMsg2.textColor = COLOR3;
            lbMsg2.text = @"㎡";
            lbMsg2.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:lbMsg2];
        }
            break;
        case 2:
        {
            lbMsg.text = @"所在区域";
            lbMsg1.text =[NSString stringWithFormat:@"%@",self.model.group_name];
        }
            break;
        case 3:
        {
            lbMsg.text = @"经营状态";
            
            lbMsg1.text = self.model.operate_status_name;
        }
            break;
            
        default:
            break;
    }
    
}

-(void)setUpView2
{
    [self collectionView];
}

-(void)setUpView3
{
    CGShopBusinessMattersOperateListModel *operateModel = self.model.operate_list[self.indexPath.row];
    //创建"联系人"
    UILabel *lbMsg2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH -15-80, 15)];
    if (IsStringEmpty(operateModel.linkman_name))
    {
        lbMsg2.text =[NSString stringWithFormat:@"联系人:%@",@"暂无"];
    }
    else
    {
        lbMsg2.text =[NSString stringWithFormat:@"联系人:%@",operateModel.linkman_name];
    }
    lbMsg2.textColor = COLOR9;
    lbMsg2.font = FONT13;
    [self.contentView addSubview:lbMsg2];
    
    //创建"时间"
    UILabel *lbMsg3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -100, 5, 90, 17)];
    lbMsg3.textAlignment = NSTextAlignmentRight;
    lbMsg3.text = operateModel.add_time;
    lbMsg3.font = FONT13;
    lbMsg3.textColor = COLOR9;
    [self.contentView addSubview:lbMsg3];
    
    //创建"经营动态"
    UILabel *lbMsg4 =[[UILabel alloc]initWithFrame:CGRectMake(15, lbMsg2.bottom+5, 10, 17)];
    lbMsg4.textColor = COLOR9;
    lbMsg4.font = FONT13;
    lbMsg4.text = @"经营动态 :";
    [lbMsg4 sizeToFit];
    [self.contentView addSubview:lbMsg4];
    
    //创建"动态"
    UILabel *lbMsg5 =[[UILabel alloc]initWithFrame:CGRectMake(lbMsg4.right +2, lbMsg4.top, 100, 17)];
    lbMsg5.font =FONT13;
    lbMsg5.text = operateModel.status_name;
    lbMsg5.textColor = UIColorFromRGBWith16HEX(0x789BD4);
    [lbMsg5 sizeToFit];
    [self.contentView addSubview:lbMsg5];
    
    //创建"描述经营事项";
    UILabel *lbMsg6 = [[UILabel alloc]initWithFrame:CGRectMake(15, lbMsg5.bottom +5, SCREEN_WIDTH -30, 50)];
    lbMsg6.font = FONT13;
    lbMsg6.textColor = COLOR9;
    lbMsg6.numberOfLines =0;
    lbMsg6.text = operateModel.intro;;
    [lbMsg6 sizeToFit];
    [self.contentView addSubview:lbMsg6];
    
    //创建"线"
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, lbMsg6.bottom+5, SCREEN_WIDTH, 10)];
    lineView.backgroundColor = GRAY_COLOR;
    [self.contentView addSubview:lineView];
    operateModel.cellHeight = lineView.bottom;
}

-(UICollectionView *)collectionView
{
    if (self.model.isShow2 ==NO)
    {
        NSInteger itemCount  =self.model.history_list.count;

        NSInteger numLine = itemCount/5;

        if ((itemCount % 5) > 0)
        {
            numLine ++;
        }
        if (numLine == 0)
        {
            self.model.sectionH2 = 40;
            UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            lbMsg.textColor = COLOR9;
            lbMsg.font = FONT15;
            lbMsg.textAlignment = NSTextAlignmentCenter;
            lbMsg.text = @"暂无历史租户";
            [self.contentView addSubview:lbMsg];
        }
        else if (numLine <= 2)
        {
            self.model.sectionH2 = (numLine *(96+12))+12;
        }
        else if (numLine >2)
        {
            self.model.sectionH2 = (2 *(96+12))+12;
        }

        self.model.numLine2 = numLine;
    }

    if (self.model.numLine2 != 0)
    {
    
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(66 , 96);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 12, 12, 12);
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumLineSpacing = 12;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.model.sectionH2) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled =NO;
        [_collectionView registerClass:[CGUnitBusinessMattersCollectionViewCell class] forCellWithReuseIdentifier:@"CGUnitBusinessMattersCollectionViewCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CGUnitBusinessMattersCollectionViewHeader"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CGUnitBusinessMattersCollectionViewFooter"];
        [self.contentView addSubview:_collectionView];
    }
    
    if (self.model.numLine2 > 2)
    {
        //创建"查看更多租户按钮"
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH/2-10, self.model.sectionH2-10, 20, 20);
        if (self.model.isShow2 ==NO)
        {
            [btn setImage:[UIImage imageNamed:@"home_icon_xiala"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"home_icon_shangla"] forState:UIControlStateNormal];
        }

        [btn addTarget:self action:@selector(shouGenDuoZuHu:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }

    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.history_list.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {SCREEN_WIDTH, 12};
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = {SCREEN_WIDTH, 12};
    return size;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        
        UICollectionReusableView *backView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CGUnitBusinessMattersCollectionViewHeader" forIndexPath:indexPath];
        reusableView = backView;
    }
    if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CGUnitBusinessMattersCollectionViewFooter" forIndexPath:indexPath];
        
        footerview.backgroundColor = kRGB(245, 245, 245);
        reusableView = footerview;
    }
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGUnitBusinessMattersCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CGUnitBusinessMattersCollectionViewCell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    CGShopBusinessMattersHistoryListModel *operateModel =self.model.history_list[indexPath.row];
    
    [cell setModel:operateModel];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.model.history_list.count)return;

    if (self.callBackHistory)
    {
        self.callBackHistory(self.model.history_list[indexPath.row]);
    }

}


-(void)shouGenDuoZuHu:(UIButton *)sender
{
    
    CGRect rect  = sender.frame;
    rect.origin.y = (self.model.numLine2 *(96+12)+12) -10;
    sender.frame = rect;
    self.model.sectionH2 = rect.origin.y +10;
    self.model.isShow2 = !self.model.isShow2;
    if (self.callBackRelodData)
    {
        self.callBackRelodData();
    }
}


@end
