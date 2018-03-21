//
//  CGOperatingDynamicDetailsViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/11.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGOperatingDynamicDetailsViewController.h"
#import "CGOperationDynamicView.h"
#import "CGOperatingDynamicDetailsCell.h"
#import "CGShopDetailsViewController.h"
@interface CGOperatingDynamicDetailsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic ,strong) CGOperationDynamicView *headView;
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) CGOperationDynamicModel *model;
@property (nonatomic, strong) UILabel *placeLab;

@end

@implementation CGOperatingDynamicDetailsViewController

-(CGOperationDynamicView *)headView
{
    if (!_headView)
    {
        _headView =[[CGOperationDynamicView alloc]initWithFrame:CGRectMake(0,-270, SCREEN_WIDTH, 260)];
        [self.view addSubview:_headView];
    }
    return _headView;
}

-(UILabel *)placeLab
{
    if (!_placeLab)
    {
        _placeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30)];
        _placeLab.text =@"没有相关铺位";
        _placeLab.textAlignment = NSTextAlignmentCenter;
        _placeLab.textColor = COLOR9;
        _placeLab.font = FONT15;
        
    }
    return _placeLab;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        //创建"CollectionView"
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(66 , 66);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 12, 12, 12);
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumLineSpacing = 12;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT -45) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CGOperatingDynamicDetailsCell class] forCellWithReuseIdentifier:@"CGOperatingDynamicDetailsCell"];
        _collectionView.contentInset = UIEdgeInsetsMake(270, 0, 0, 0);
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.userInteractionEnabled = YES;
        //        _collectionView.contentOffset = CGPointMake(0, -690);
        [self.view addSubview:_collectionView];
        [_collectionView addSubview:[self headView]];
        //添加提示语
        [_collectionView addSubview:[self placeLab]];
    }
    return _collectionView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //头部view;
    [self headView];
    
    //创建"collectionView"
    [self collectionView];
    
    //获取数据
     [self getTrends];
}

- (void)reloadDynamicList {
    NSLog(@"刷新");
    [self getTrends];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.position.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     CGOperatingDynamicDetailsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CGOperatingDynamicDetailsCell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    CGOperationDynamicPositionModel *pos_model = [self.model.position objectAtIndex:indexPath.row];
    if (self.model.position.count)
    {
        self.placeLab.hidden =YES;
    }
    else
    {
         self.placeLab.hidden =NO;
    }
    
    [cell setModel:pos_model];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGOperationDynamicPositionModel *pos_model = [self.model.position objectAtIndex:indexPath.row];
    CGShopDetailsViewController *shopDetailsView =[CGShopDetailsViewController new];
    shopDetailsView.pos_id = pos_model.id;
    shopDetailsView.type =1;
    shopDetailsView.is_mine = pos_model.is_mine;
    shopDetailsView.callBackData = ^{
      
        [self getTrends];
    };
    [self.navigationController pushViewController:shopDetailsView animated:YES];
}

//获取经营动态详情
-(void)getTrends
{
    NSMutableDictionary *param =[NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getTrends" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:@(self.fromWhere) forKey:@"operate"];
    [MBProgressHUD showMsg:@"加载中..." toView:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
     {
        [MBProgressHUD hideHUD:self.view];
        NSString *code = [json objectForKey:@"code"];
        
        if ([code isEqualToString:SUCCESS])
        {
            self.model = [CGOperationDynamicModel mj_objectWithKeyValues:[json objectForKey:@"data"]];
        }
        [self.collectionView reloadData];
        [self.headView setModel:self.model];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD:self.view];
    }];
}

@end
