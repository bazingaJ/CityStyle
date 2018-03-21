//
//  CGShopLeaseItemCell.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGShopLeaseItemCell.h"
#import "CGUnitLeaseItemCollectionViewCell.h"

@interface CGShopLeaseItemCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic ,strong) UICollectionView *collectionView;

@end

@implementation CGShopLeaseItemCell

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
        case 1: {
            //当前租户
            
            if(IsStringEmpty(self.model.sign_cust_id) ||
               [self.model.sign_cust_id isEqualToString:@"0"]) {
                UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 40)];
                lbMsg.textColor = COLOR9;
                lbMsg.font = FONT15;
                lbMsg.textAlignment = NSTextAlignmentCenter;
                lbMsg.text = @"暂无当前租户";
                [self.contentView addSubview:lbMsg];
            }else{
                UICollectionView *collectionView = [self collectionView];
                [self.contentView addSubview:collectionView];
                CGRect rect = collectionView.frame;
                rect.size.height = 120;
                collectionView.frame = rect;
                
                //设置"tag"
                collectionView.tag = 300;
            }
            
            break;
        }
        case 2:
        {
            //第二区
            
            if (self.model.isShow2 ==NO)
            {
                NSInteger itemCount  =self.model.intent_list.count;

                NSInteger numLine = itemCount/5;

                if ((itemCount % 5) > 0)
                {
                    numLine ++;
                }
                if (numLine ==0)
                {
                    self.model.sectionH2 = 40;
                    UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
                    lbMsg.textColor = COLOR9;
                    lbMsg.font = FONT15;
                    lbMsg.textAlignment = NSTextAlignmentCenter;
                    lbMsg.text = @"暂无意向租户";
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
                //创建"collectionView"
                UICollectionView *collectionView = [self collectionView];
                [self.contentView addSubview:collectionView];
                CGRect rect = collectionView.frame;
                rect.size.height = 120;
                collectionView.frame = rect;
                
                //设置"tag"
                collectionView.tag = 100;
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
                btn.tag =300;
                [self.contentView addSubview:btn];
            }
            
        }
            break;
        case 3:
        {
            if (self.model.isShow3 ==NO)
            {
                NSInteger itemCount  =self.model.history_list.count;

                NSInteger numLine = itemCount/5;

                if ((itemCount % 5) > 0)
                {
                    numLine ++;
                }
                if (numLine ==0)
                {
                    self.model.sectionH3 = 40;
                    UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
                    lbMsg.textColor = COLOR9;
                    lbMsg.font = FONT15;
                    lbMsg.textAlignment = NSTextAlignmentCenter;
                    lbMsg.text = @"暂无历史租户";
                    [self.contentView addSubview:lbMsg];
                }
                else if (numLine <= 2)
                {
                    self.model.sectionH3 = (numLine *(96+12))+12;
                }
                else if (numLine >2)
                {
                    self.model.sectionH3 = (2 *(96+12))+12;
                }

                self.model.numLine3 = numLine;
            }

            if (self.model.numLine3 !=0)
            {
                //创建"collectionView"
                UICollectionView *collectionView = [self collectionView];
                [self.contentView addSubview:collectionView];
                //设置"tag"
                collectionView.tag = 200;
                CGRect rect = collectionView.frame;
                rect.size.height = 120;
                collectionView.frame = rect;
            }

            if (self.model.numLine2 > 2)
            {
                //创建"查看更多租户按钮"
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(SCREEN_WIDTH/2-10, self.model.sectionH2-10, 20, 20);
                if (self.model.isShow3 ==NO)
                {
                    [btn setImage:[UIImage imageNamed:@"home_icon_xiala"] forState:UIControlStateNormal];
                }
                else
                {
                    [btn setImage:[UIImage imageNamed:@"home_icon_shangla"] forState:UIControlStateNormal];
                } 
                [btn addTarget:self action:@selector(shouGenDuoZuHu:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = 400;
                [self.contentView addSubview:btn];
            }
            
        }
            
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
            lbMsg1.text = self.model.area;
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
            lbMsg1.text = self.model.group_name;
        }
            break;
        case 3:
        {
            lbMsg.text = @"经营状态";
            lbMsg1.text =self.model.operate_status_name;
        }
            break;
            
        default:
            break;
    }
}

-(UICollectionView *)collectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(66 , 96);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 12, 12, 12);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 12;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 3*(96+24)) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.scrollEnabled = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CGUnitLeaseItemCollectionViewCell class] forCellWithReuseIdentifier:@"CGUnitLeaseItemCollectionViewCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CGUnitLeaseItemCollectionViewHeader"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CGUnitLeaseItemCollectionViewFooter"];
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag ==100)
    {
        return  self.model.intent_list.count;
    }
    else if (collectionView.tag ==200)
    {
        return self.model.history_list.count;
    }else if(collectionView.tag==300) {
        return 1;
    }
    
    return 0;
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
        
        UICollectionReusableView *backView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CGUnitLeaseItemCollectionViewHeader" forIndexPath:indexPath];
        reusableView = backView;
    }
    if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CGUnitLeaseItemCollectionViewFooter" forIndexPath:indexPath];
        
        footerview.backgroundColor = kRGB(245, 245, 245);
        reusableView = footerview;
    }
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGUnitLeaseItemCollectionViewCell *cell;
    if (collectionView.tag ==100)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CGUnitLeaseItemCollectionViewCell" forIndexPath:indexPath];
        for (UIView *view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        [cell setModel:100 withIntentMode:self.model.intent_list[indexPath.row] withHistoryListModel:nil model:self.model];
    }
    else if (collectionView.tag ==200)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CGUnitLeaseItemCollectionViewCell" forIndexPath:indexPath];
        for (UIView *view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        [cell setModel:200 withIntentMode:nil withHistoryListModel:self.model.history_list[indexPath.row] model:self.model];
    }else if(collectionView.tag==300) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CGUnitLeaseItemCollectionViewCell" forIndexPath:indexPath];
        for (UIView *view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        [cell setModel:300 withIntentMode:nil withHistoryListModel:nil model:self.model];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag ==100)
    {
        if (!self.model.intent_list.count) return;
        CGShopBusinessMattersIntentModel *model = self.model.intent_list[indexPath.row];
        self.callCollectionBack(model, nil, nil,100);
    }
    else if (collectionView.tag ==200)
    {
        if (!self.model.history_list.count) return;
        CGShopBusinessMattersHistoryListModel *model = self.model.history_list[indexPath.row];
        self.callCollectionBack(nil, model, nil,200);
    }else if(collectionView.tag==300) {
        //当前租户
        if (!self.model) return;
        self.callCollectionBack(nil, nil, self.model,300);
    }
}



-(void)shouGenDuoZuHu:(UIButton *)sender
{
    
    CGRect rect  = sender.frame;
    if (sender.tag ==300)
    {
        rect.origin.y = (self.model.numLine2 *(96+12)+12) -10;
        sender.frame = rect;
        self.model.sectionH2 = rect.origin.y +10;
        self.model.isShow2 = !self.model.isShow2;
    }
    else
    {
        rect.origin.y = (self.model.numLine3 *(96+12)+12) -10;
        sender.frame = rect;
        self.model.sectionH3 = rect.origin.y +10;
        self.model.isShow3 = !self.model.isShow3;
    }
    
    if (self.callBackRelodData)
    {
        self.callBackRelodData();
    }
}

@end
