//
//  CGHomeCell.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/11/27.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGHomeCell.h"

@interface CGHomeCell()
@property (nonatomic ,strong)NSArray *twoSectionTitleArr;
@end

@implementation CGHomeCell


-(NSArray *)twoSectionTitleArr
{
    if (!_twoSectionTitleArr)
    {
        _twoSectionTitleArr = @[@"空置商铺",@"稳营商铺",@"预动商铺",@"退铺警告"];
    }
    return _twoSectionTitleArr;
}

-(void)setModel:(CGHomeModel *)model withIndexPath:(NSIndexPath *)indexPath
{
    _model = model;
    _indexPath = indexPath;
    
    if (!_model) return;
    
    switch (indexPath.section)
    {
        case 0:
        {
            [self setUpOne];
        }
            break;
        case 1:
        {
            [self setUpTwo];
        }
            break;
        case 2:
        {
            [self setUpThree];
        }
            break;
            
        default:
            break;
    }
}

//第一区
-(void)setUpOne
{
    //创建"背景"
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_model.cover_url]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds =YES;
    imageView.userInteractionEnabled = YES;
    [imageView addTouch:^{
        
        if([self.delegate respondsToSelector:@selector(CGHomeCellProjectNetworkLocation)])
        {
            [self.delegate CGHomeCellProjectNetworkLocation];
        }
        
    }];
    [self.contentView addSubview:imageView];
    
    //创建CGContextRef
    UIGraphicsBeginImageContext(CGSizeMake(SCREEN_WIDTH, 200));
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    
    //绘制Path
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, SCREEN_WIDTH, 0);
    CGPathAddLineToPoint(path, NULL, SCREEN_WIDTH, 200);
    CGPathAddLineToPoint(path, NULL, 0, 200);
    CGPathCloseSubpath(path);
    
    //绘制渐变
    [self drawLinearGradient:gc path:path startColor:[UIColor clearColor].CGColor endColor:COLOR6.CGColor];
    
    //注意释放CGMutablePathRef
    CGPathRelease(path);
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView * cover = [[UIImageView alloc] initWithImage:img];
    [self.contentView addSubview:cover];
    
    
    //创建"出租率"/平方米
    float width = SCREEN_WIDTH/2;
    for (int i =0; i<2; i++)
    {
        //创建"背景"
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(i*width, 190-40, width, 25)];
        backView.backgroundColor = [UIColor clearColor];
        
        //创建"图片"
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(width/2-30, 3, 25, 22.5)];
        [backView addSubview:imageView];
        
        if (i == 0)
        {
            imageView.image = [UIImage imageNamed:@"home_rents_icon"];
            
            //创建"出租率"
            UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(width/2+5, 0, 100, 30)];
            lbMsg.textColor = [UIColor whiteColor];
            lbMsg.font = [UIFont systemFontOfSize:24];
            lbMsg.text =[NSString stringWithFormat:@"%@%@",_model.sign_percent,@"%"];
            [backView addSubview:lbMsg];
        }
        else
        {
            imageView.image = [UIImage imageNamed:@"home_totalarea_icon"];
            //创建"出租面积"
            UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(width/2+5, 0, 150, 15)];
            lbMsg.textColor = [UIColor whiteColor];
            lbMsg.text = [NSString stringWithFormat:@"%@㎡",_model.total_sign_area];
            lbMsg.font = FONT12;
            [backView addSubview:lbMsg];
            
            //创建总面积
            UILabel *lbMsg1 = [[UILabel alloc]initWithFrame:CGRectMake(width/2+5, 15, 150, 15)];
            lbMsg1.textColor = [UIColor whiteColor];
            lbMsg1.text = [NSString stringWithFormat:@"%@㎡",_model.total_area];
            lbMsg1.font = FONT12;
            [backView addSubview:lbMsg1];
        }
        [self.contentView addSubview:backView];
    }
}

//TODO:第二区
-(void)setUpTwo
{
    float width = SCREEN_WIDTH/self.twoSectionTitleArr.count;
    for (int i =0; i<self.twoSectionTitleArr.count; i++)
    {
        //创建背景
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(i*width, 0, width, 90)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        
        //创建"图片"
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(width/2-17.5, 17.5, 35, 35)];
        imageView.image = [UIImage imageNamed:@[@"home_bunk_empty",@"home_bunk_wenying",@"home_bunk_yudong",@"home_bunk_tuipu"][i]];
        [backView addSubview:imageView];
        
        //创建"图片上提示Lab"
        UILabel *lbMsg = [[UILabel alloc]initWithFrame:CGRectMake(width/2+17.5-5.5, 16, 14, 14)];
        lbMsg.layer.cornerRadius = 7;
        lbMsg.clipsToBounds = YES;
        lbMsg.textAlignment = NSTextAlignmentCenter;
        lbMsg.font = [UIFont systemFontOfSize:8];
        switch (i)
        {
            case 0:
            {
                //空置商铺
                lbMsg.backgroundColor = UIColorFromRGBWith16HEX(0xBBCDE9);
                lbMsg.textColor = COLOR3;
                lbMsg.text = _model.trendsModel.empty;
            }
                break;
            case 1:
            {
                //稳营商铺
                lbMsg.backgroundColor = UIColorFromRGBWith16HEX(0xBABABA);
                lbMsg.textColor = COLOR3;
                lbMsg.text = _model.trendsModel.profitNum;
            }
                break;
            case 2:
            {
                //预动商铺
                lbMsg.backgroundColor = UIColorFromRGBWith16HEX(0xFFE207);
                
                lbMsg.text = _model.trendsModel.togoNum;
                if ([_model.trendsModel.togoNum isEqualToString:@"0"])
                {
                    lbMsg.backgroundColor = kRGB(188, 205, 235);
                }
                else
                {
                    lbMsg.backgroundColor = kRGB(254, 224, 52);
                    lbMsg.textColor = COLOR3;
                }
                
            }
                break;
            case 3:
            {
                //退铺警告
                lbMsg.text = _model.trendsModel.outNum;
                lbMsg.backgroundColor = UIColorFromRGBWith16HEX(0xFF0000);
                if ([_model.trendsModel.outNum isEqualToString:@"0"])
                {
                    lbMsg.backgroundColor = kRGB(188, 205, 235);
                }
                else
                {
                    lbMsg.backgroundColor = [UIColor redColor];
                    lbMsg.textColor =[UIColor whiteColor];
                }
            }
                break;
            default:
                break;
        }
        
        [backView addSubview:lbMsg];
        
        //创建"标题"
        UILabel *lbMsg1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, width, 15)];
        lbMsg1.textColor = COLOR3;
        lbMsg1.font = FONT12;
        lbMsg1.textAlignment = NSTextAlignmentCenter;
        lbMsg1.text = self.twoSectionTitleArr[i];
        [backView addSubview:lbMsg1];
        
        //创建"线"
        if(i < 3)
        {
            UIView *lineLab = [[UIView alloc]initWithFrame:CGRectMake(width-.5, 0,0.5 , 90)];
            lineLab.backgroundColor = LINE_COLOR;
            [backView addSubview:lineLab];
        }
        
        //创建按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, width, 90);
        [btn addTarget:self action:@selector(unitDynamicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [backView addSubview:btn];
        
    }
}
//TODO:第三区
-(void)setUpThree
{
    float width = SCREEN_WIDTH /3;
    float height = 205 /3;
    
    NSArray *colorArr = @[UIColorFromRGBWith16HEX(0xB9B9B9),UIColorFromRGBWith16HEX(0x779AD6),UIColorFromRGBWith16HEX(0xBBCDE9)];
    
    NSString *oneStr;
    NSString *twoStr;
    NSString *threeStr;
    
    if ([_model.letDataModel.signPercent isEqualToString:@"0"] &&[_model.letDataModel.intentPercent isEqualToString:@"0"] &&[_model.letDataModel.noIntentPercent isEqualToString:@"0"])
    {
        oneStr = @"1";
        twoStr = @"0";
        threeStr = @"0";
    }
    else
    {
        oneStr = _model.letDataModel.signPercent;
        twoStr = _model.letDataModel.intentPercent;
        threeStr =_model.letDataModel.noIntentPercent;
    }
    [self drawPresentChart:@[oneStr,twoStr,threeStr] titles:nil];
    
    NSArray *titleArr = @[@"已租",@"待租有意向",@"待租无意向"];
    //创建"已租"待租有意"无意"
    for (int i =0; i<3; i++)
    {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(width*2, height*i, width, height)];
        backView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:backView];
        
        //创建"颜色盒"
        UILabel *lbMsg1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 18, 15, 15)];
        lbMsg1.layer.cornerRadius = 3;
        lbMsg1.clipsToBounds = YES;
        lbMsg1.backgroundColor = colorArr[i];
        [backView addSubview:lbMsg1];
        
        //创建"住标题如"已租""
        UILabel *lbMsg2 =[[UILabel alloc]init];
        lbMsg2.text = titleArr[i];
        lbMsg2.font = FONT14;
        lbMsg2.textColor = UIColorFromRGBWith16HEX(0x3A7DCE);
        CGSize titleSize = [lbMsg2 sizeThatFits:CGSizeMake(MAXFLOAT-30, 15)];
        lbMsg2.frame = CGRectMake(CGRectGetMaxX(lbMsg1.frame)+5, 18, titleSize.width, 15);
        [backView addSubview:lbMsg2];
        
        //创建"个数"
        UILabel *lbMsg3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lbMsg1.frame)+5, CGRectGetMaxY(lbMsg2.frame)+5, 100, 15)];
        lbMsg3.textColor = COLOR9;
        lbMsg3.font = FONT14;
        [backView addSubview:lbMsg3];
        
        //创建"平方米"
        UILabel *lbMsg4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lbMsg1.frame)+5, CGRectGetMaxY(lbMsg3.frame)+5, 150, 15)];
        lbMsg4.font = FONT14;
        lbMsg4.textColor = COLOR9;
        [backView addSubview:lbMsg4];
        
        switch (i) {
            case 0:
            {
                //已租
                lbMsg3.text = _model.letDataModel.signNum;
                lbMsg4.text =[NSString stringWithFormat:@"%@㎡",_model.letDataModel.signArea];
            }
                break;
            case 1:
            {
                //待租有意向

                lbMsg3.text = _model.letDataModel.intentNum;
                lbMsg4.text = [NSString stringWithFormat:@"%@㎡",_model.letDataModel.intentArea];
            }
                break;
                
            case 2:
            {
                //待租无意向
                lbMsg3.text = _model.letDataModel.noIntentNum;
                lbMsg4.text = [NSString stringWithFormat:@"%@㎡",_model.letDataModel.noIntentArea];
            }
                break;
    
            default:
                break;
        }
    }
    
    //创建"查看招租报表"
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame  = CGRectMake(SCREEN_WIDTH/2-65, 210, 130, 35);
    [btn addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"查看招租报表" forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromRGBWith16HEX(0x779AD6) forState:UIControlStateNormal];
    btn.titleLabel.font = FONT14;
    btn.layer.cornerRadius = 4;
    btn.layer.borderColor = UIColorFromRGBWith16HEX(0x779AD6).CGColor;
    btn.layer.borderWidth = .5;
    btn.clipsToBounds = YES;
    [self.contentView addSubview:btn];
}

-(void)showTable:(UIButton *)sender
{
    if([self.delegate respondsToSelector:@selector(CGHomeCell:showTable:)])
    {
        [self.delegate CGHomeCell:self showTable:sender];
    }
}

-(void)unitDynamicBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(CGHomeCell:withGoToUnit:)])
    {
        [self.delegate CGHomeCell:self withGoToUnit:sender];
    }
}


-(void)drawPresentChart:(NSArray*)valueDataArr titles:(NSArray*)titleArr
{
    float width =SCREEN_WIDTH/3;
    JHRingChart *ring = [[JHRingChart alloc] initWithFrame:CGRectMake(0, 0, width *2, width *2)];
    /*        background color         */
    ring.backgroundColor = [UIColor whiteColor];
    
    ring.totalNum = _model.letDataModel.totalNum;
    ring.tIndex = 0;
    /* Data source array, only the incoming value, the corresponding ratio will be automatically calculated   */
    ring.valueDataArr = [valueDataArr copy];
    /*         Width of ring graph        */
    ring.ringWidth = 35.0;
    /*        Fill color for each section of the ring diagram         */
   ring.fillColorArray = @[UIColorFromRGBWith16HEX(0xB9B9B9),UIColorFromRGBWith16HEX(0x779AD6),UIColorFromRGBWith16HEX(0xBBCDE9)];
    /*        Start animation             */
    [ring showAnimation];
    [self.contentView addSubview:ring];
    self.ringChart = ring;
    
    
    
    //创建"饼状图中间内容"
    UILabel *lbMsg =[[UILabel alloc]initWithFrame:CGRectMake(0, ring.frame.size.height/2-30, ring.frame.size.width, 10)];
    lbMsg.text = @"总铺数";
    lbMsg.textColor =COLOR6;
    lbMsg.textAlignment =NSTextAlignmentCenter;
    lbMsg.font =FONT11;
    [ring addSubview:lbMsg];
    
    UILabel *lbMsg1 =[[UILabel alloc]initWithFrame:CGRectMake(0,ring.frame.size.height/2-45, ring.frame.size.width, 10)];
    lbMsg1.text = _model.letDataModel.totalNum;
    lbMsg1.textColor = UIColorFromRGBWith16HEX(0x779AD6);
    lbMsg1.textAlignment =NSTextAlignmentCenter;
    lbMsg1.font =FONT11;
    [ring addSubview:lbMsg1];
}


/** 渐变 */
- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
