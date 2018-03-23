//
//  CGNetdiscViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/27.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGNetdiscViewController.h"
#import "CGLocalVideoListViewController.h"
#import "UpYun.h"
#import "UpYunFormUploader.h" //图片，小文件，短视频
#import "WSDatePickerView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZLPhotoPickerBrowserViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "CGNetdiscNamePopupView.h"
#import "YWFilePreviewView.h"
#import "CGFileOpenViewController.h"
#import "CGUpdateView.h"

@interface CGNetdiscViewController () <ZLPhotoPickerBrowserViewControllerDelegate>

{
    //yes有权限
    BOOL is_authority;
}

@end

@implementation CGNetdiscViewController

- (void)viewDidLoad {
    [self setShowFooterRefresh:YES];
    [super viewDidLoad];
    
    self.title = @"项目网盘";

    //获取我的权限
    [self getMyAuth];
    CGUpdateView *view = [[CGUpdateView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 275, 345) contentStr:@"获取更大网盘空间"];
    view.clickCallBack = ^(NSInteger tIndex) {
        [self.popup dismiss:YES];
        if (tIndex == 0)
        {
            return ;
        }
        else
        {
            [MBProgressHUD showMessage:@"确定删除" toView:self.view];
        }
    };
    self.popup = [KLCPopup popupWithContentView:view
                                       showType:KLCPopupShowTypeGrowIn
                                    dismissType:KLCPopupDismissTypeGrowOut
                                       maskType:KLCPopupMaskTypeDimmed
                       dismissOnBackgroundTouch:NO
                          dismissOnContentTouch:NO];
    [self.popup show];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGNetdiscCell";
    CGNetdiscCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGNetdiscCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGNetdiscModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:80];
    [cell setDelegate:self];
    [cell setNetdiscModel:model indexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CGNetdiscModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if (!model) return;
    
    NSString *urlStringUTF8 = [model.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //文件类型 1图片 2视频 3word 4excel 5 CAD 6 3DMAX 7 PDF 8其他
    
    NSInteger typeV = [model.type integerValue];
    if(typeV==1) {
        //图片
        ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
        photo.photoURL = [NSURL URLWithString:urlStringUTF8];
        //点击头像放大
        
        // 图片游览器
        ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
        // 淡入淡出效果
        pickerBrowser.status = UIViewAnimationAnimationStatusFade;
        // 数据源/delegate
        pickerBrowser.photos = @[photo];
        // 能够删除
        pickerBrowser.delegate = self;
        // 当前选中的值
        pickerBrowser.currentIndex = 0;
        // 展示控制器
        [pickerBrowser showPickerVc:self];
        
    }else if(typeV==2) {
        //视频
        MPMoviePlayerViewController *mPMoviePlayerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:urlStringUTF8]];
        mPMoviePlayerViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self presentViewController:mPMoviePlayerViewController animated:YES completion:nil];
    }else{
        
        //1.创建会话管理者
        AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
        
        NSURL *url = [NSURL URLWithString:urlStringUTF8];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        //2.下载文件
        /*
         第一个参数:请求对象
         第二个参数:progress 进度回调 downloadProgress
         第三个参数:destination 回调(目标位置)
         有返回值
         targetPath:临时文件路径
         response:响应头信息
         第四个参数:completionHandler 下载完成之后的回调
         filePath:最终的文件路径
         */
        NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            
            //监听下载进度
            //completedUnitCount 已经下载的数据大小
            //totalUnitCount     文件数据的中大小
            NSLog(@"%f",1.0 *downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            
            CGFloat progressValue = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
            
            //主线程执行
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *proStr = [[NSString stringWithFormat:@"已加载%.0f",progressValue*100] stringByAppendingString:@"%"];
                [MBProgressHUD showMessage:proStr toView:self.view];
            });
            
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
            
            NSLog(@"targetPath:%@",targetPath);
            NSLog(@"fullPath:%@",fullPath);
            
            return [NSURL fileURLWithPath:fullPath];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
            NSLog(@"%@",filePath);
            
            //停顿1秒后,打开文档
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //文件类型 1图片 2视频 3word 4excel 5 CAD 6 3DMAX 7 PDF 8其他
                if(typeV==5 || typeV==6 || typeV==8) {
                    CGFileOpenViewController *testView = [[CGFileOpenViewController alloc] init];
                    testView.title = model.name;
                    testView.fileURL = model.url;//[filePath absoluteString];
                    [self.navigationController pushViewController:testView animated:YES];
                }else{
                    [YWFilePreviewView previewFileWithPaths:filePath];
                }
                
            });
            
        }];
        
        //3.执行Task
        [download resume];
        
    }

}

- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    //设置分享按钮
    UIButton *btnFunc2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFunc2 setTitle:@"分享" forState:UIControlStateNormal];
    [btnFunc2 setTitleColor:COLOR3 forState:UIControlStateNormal];
    [btnFunc2.titleLabel setFont:FONT14];
    [btnFunc2 setBackgroundColor:GRAY_COLOR];
    [btnFunc2 setImage:[UIImage imageNamed:@"netdisc_icon_share"] forState:UIControlStateNormal];
    [btnFunc2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btnFunc2 setTitleEdgeInsets:UIEdgeInsetsMake(btnFunc2.imageView.frame.size.height+30 ,-btnFunc2.imageView.frame.size.width-30, 0, 0)];
    //图片距离右边框距离减少图片的宽度，其它不边
    [btnFunc2 setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 35, -btnFunc2.titleLabel.bounds.size.width)];
    [btnFunc2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [rightUtilityButtons addObject:btnFunc2];
    
    //设置删除按钮
    if(is_authority) {
        UIButton *btnFunc = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnFunc setTitle:@"删除" forState:UIControlStateNormal];
        [btnFunc setTitleColor:COLOR3 forState:UIControlStateNormal];
        [btnFunc.titleLabel setFont:FONT14];
        [btnFunc setBackgroundColor:GRAY_COLOR];
        [btnFunc setImage:[UIImage imageNamed:@"delete_icon_small"] forState:UIControlStateNormal];
        [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btnFunc setTitleEdgeInsets:UIEdgeInsetsMake(btnFunc.imageView.frame.size.height+30 ,-btnFunc.imageView.frame.size.width-30, 0, 0)];
        //图片距离右边框距离减少图片的宽度，其它不边
        [btnFunc setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 35, -btnFunc.titleLabel.bounds.size.width)];
        [btnFunc setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [rightUtilityButtons addObject:btnFunc];
    }
    
    return rightUtilityButtons;
}

// prevent multiple cells from showing utilty buttons simultaneously
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}
// prevent cell(s) from displaying left/right utility buttons
- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state {
    return YES;
}

/**
 *  滑动委托委托代理
 */
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSLog(@"滑动委托委托代理");
    if (!is_authority)
    {
        [MBProgressHUD showError:@"没有权限操作网盘" toView:self.view];
        return;
    }
    CGNetdiscCell *tCell = (CGNetdiscCell *)cell;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tCell];
    CGNetdiscModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if (!model) return;
    
    switch (index) {
        case 0: {
            //分享
            
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:model.cover_icon forKey:@"cover_url"];
            [param setValue:model.url forKey:@"share_url"];
            [param setValue:model.name forKey:@"title"];
            [param setValue:model.name forKey:@"content"];
            [param setValue:model.id forKey:@"id"];
            CGUMSocialSheetEx *socialView = [[CGUMSocialSheetEx alloc] initWithView:self param:param];
            socialView.callSuccBack = ^(BOOL isSucc) {
                //刷新当前数据
                
                [self.tableView beginUpdates];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView endUpdates];
                
            };
            [socialView show];
            
            break;
        }
        case 1: {
            //删除
            
            NSMutableDictionary *param =[NSMutableDictionary dictionary];
            [param setValue:@"home" forKey:@"app"];
            [param setValue:@"dropSkyDrive" forKey:@"act"];
            [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
            [param setValue:model.id forKey:@"id"];
            [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
                NSString *code = json[@"code"];
                NSString *msg = json[@"msg"];
                if ([code isEqualToString:SUCCESS]) {
                    [MBProgressHUD showSuccess:@"删除成功" toView:self.view];
                    [self.tableView.mj_header beginRefreshing];
                }else{
                    [MBProgressHUD showError:msg toView:self.view];
                }
                
            } failure:^(NSError *error) {
                NSLog(@"%@",[error description]);
            }];
            
            break;
        }
            
        default:
            break;
    }
    
}

/**
 *  上传文件事件
 */
- (void)btnFuncClick:(UIButton *)btnSender {
    NSLog(@"上传文件");
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    UIAlertController *alertController = [[UIAlertController alloc] init];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        NSLog(@"拍照");
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            imagePicker.delegate = self;
//            [self presentViewController:imagePicker animated:YES completion:nil];
//            
//        }else{
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"无法打开相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alert show];
//        }
//    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"从手机相册选择");
        //imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"本地视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"本地视频");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UINavigationController *navigationController = (UINavigationController *)self.view.window.rootViewController;
            CGLocalVideoListViewController *videoView = [[CGLocalVideoListViewController alloc] init];
            videoView.callBack = ^(CGLocalVideoModel *model){
                NSLog(@"选择视图回调成功");
                CGNetdiscNamePopupView *popupView = [[CGNetdiscNamePopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 300, 175) titleStr:@"重命名" placeholderStr:@"请输入文件名称" contentStr:@""];
                popupView.callBack = ^(NSInteger tIndex, NSString *content) {
                    NSLog(@"编辑、添加业态回调成功:%zd-%@",tIndex,content);
                    [self.popup dismiss:YES];
                    
                    if(tIndex==0) return ;
                    
                    NSArray *prefixArr = [model.video_name componentsSeparatedByString:@"."];
                    //NSString *dateStr = [NSString stringWithFormat:@"%@.%@",[[NSDate date] stringWithFormat:@"yyyyMMddHHmmss"],prefixArr[1]];
                    NSString *nameStr = [NSString stringWithFormat:@"%@.%@",content,prefixArr[prefixArr.count-1]];
                    [self videoUrl:model.video_url withName:nameStr];
                    
                };
                self.popup = [KLCPopup popupWithContentView:popupView
                                                   showType:KLCPopupShowTypeGrowIn
                                                dismissType:KLCPopupDismissTypeGrowOut
                                                   maskType:KLCPopupMaskTypeDimmed
                                   dismissOnBackgroundTouch:NO
                                      dismissOnContentTouch:NO];
                [self.popup show];
                
//                NSArray *prefixArr = [model.video_name componentsSeparatedByString:@"."];
//                NSString *dateStr = [NSString stringWithFormat:@"%@.%@",[[NSDate date] stringWithFormat:@"yyyyMMddHHmmss"],prefixArr[1]];
//                [self videoUrl:model.video_url withName:dateStr];
                //[self videoUrl:model.video_url withName:model.video_name];
            };
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:videoView];
            [nav setNavigationBarHidden:YES];
            [navigationController presentViewController:nav animated:YES completion:nil];
        });
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

//UIImagePickerControlDelegate委托事件
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获取相机返回的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    if (@available(iOS 11.0, *)) {
//        NSURL *filePase = [info objectForKey:UIImagePickerControllerImageURL];
//        NSString * filePaseStr = [filePase absoluteString];
//        filePaseStr = [filePaseStr stringByReplacingOccurrencesOfString:@"file://"withString:@""];
//        NSString * date = [[NSDate date] stringWithFormat:@"yyyy-MM-ddHH:mm:ss"];
//        [self uplodFile:filePaseStr withSuffix:[NSString stringWithFormat:@"%@.jpeg",date]];
//    } else {
//        // Fallback on earlier versions
//    }
    CGNetdiscNamePopupView *popupView = [[CGNetdiscNamePopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 0, 300, 175) titleStr:@"重命名" placeholderStr:@"请输入文件名称" contentStr:@""];
    popupView.callBack = ^(NSInteger tIndex, NSString *content) {
        NSLog(@"编辑、添加业态回调成功:%zd-%@",tIndex,content);
        [self.popup dismiss:YES];
        
        if(tIndex==0) return ;
        
        //上传
        UIImage *photoImg = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSString *dateStr = [[NSDate date] stringWithFormat:@"yyyyMMddHHmmss"];
        [self uplodFileEx:photoImg withSuffix:[NSString stringWithFormat:@"%@.jpeg",dateStr] nameStr:content];
        
    };
    self.popup = [KLCPopup popupWithContentView:popupView
                                       showType:KLCPopupShowTypeGrowIn
                                    dismissType:KLCPopupDismissTypeGrowOut
                                       maskType:KLCPopupMaskTypeDimmed
                       dismissOnBackgroundTouch:NO
                          dismissOnContentTouch:NO];
    [self.popup show];
    
}

////获取当前时间戳  （以毫秒为单位）
//- (NSString *)getNowTimeTimestamp{
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//    //设置时区,这个对于时间的处理有时很重要
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timeZone];
//    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
//    return timeSp;
//
//}

- (NSString * )getSaveKeyWith:(NSString *)suffix {
    //设置存储路径：生成 saveKey
    
    //方式1 本地生产绝对值 saveKey
    return [NSString stringWithFormat:@"/%@.%@", [self getDateString], suffix];
    
    //方式2 由服务器根据格式生成 saveKey
    //return [NSString stringWithFormat:@"/{year}/{mon}/{filename}{.suffix}"];
    
    //更多方式 参阅 http://docs.upyun.com/api/form_api/#_5
}

- (NSString *)getDateString {
    NSDate *curDate = [NSDate date];//获取当前日期
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy/MM/dd"];//这里去掉 具体时间 保留日期
    NSString * curTime = [formater stringFromDate:curDate];
    curTime = [NSString stringWithFormat:@"%@/%.0f", curTime, [curDate timeIntervalSince1970]];
    return curTime;
}


/**
 *  获取信息
 */
- (void)getDataList:(BOOL)isMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"getSkyDriveList" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:@(self.pageIndex) forKey:@"page"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = json[@"code"];
        NSDictionary *dataDic = json[@"data"];
        if ([code isEqualToString:SUCCESS])
        {
            NSArray *listArr =dataDic[@"list"];
            for (NSDictionary *itemDic in listArr)
            {
                [self.dataArr addObject:[CGNetdiscModel mj_objectWithKeyValues:itemDic]];
            }
            
            //当前总数
            NSString *dataNum = [dataDic objectForKey:@"count"];
            if(!IsStringEmpty(dataNum)) {
                self.totalNum = [dataNum intValue];
            }else{
                self.totalNum = 0;
            }
        }
        [self.tableView reloadData];
        [self endDataRefresh];
    } failure:^(NSError *error)
    {
     
        [self endDataRefresh];
    }];
    
}

- (void)uplodFile:(NSString *)filePath1 withSuffix:(NSString *)suffix
{
    //设置服务名
    [UPYUNConfig sharedInstance].DEFAULT_BUCKET = @"file-upyun";
    //设置空间表单密钥
    [UPYUNConfig sharedInstance].DEFAULT_PASSCODE = @"Znqw1Dhp7IgL+6682XRAtCIO59Q=";
    
    __block UpYun *uy = [[UpYun alloc] init];
    uy.successBlocker = ^(NSURLResponse *response, id responseData) {
        NSLog(@"上传成功:response body %@", responseData);
        [MBProgressHUD showSuccess:@"上传成功" toView:self.view];
        [self setSkyDrive:@"1" withPath:responseData[@"url"] withName:responseData[@"url"] withCover:nil];
       
    };
    uy.failBlocker = ^(NSError * error) {
        NSString *message = error.description;
        NSLog(@"上传失败：%@",message);
        NSLog(@"error %@", error);
    };
    uy.progressBlocker = ^(CGFloat percent, int64_t requestDidSendBytes) {
        NSLog(@"当前进度：%f",percent);
        [MBProgressHUD showMessage:[NSString stringWithFormat:@"%.2f%%",percent*100] toView:self.view];
    };
    
    //获取上传文件路径
    [uy uploadFile:filePath1 saveKey:suffix];
}

- (void)uplodFileEx:(UIImage *)img withSuffix:(NSString *)suffix nameStr:(NSString *)nameStr
{
    //设置服务名
    [UPYUNConfig sharedInstance].DEFAULT_BUCKET = @"file-upyun";
    //设置空间表单密钥
    [UPYUNConfig sharedInstance].DEFAULT_PASSCODE = @"Znqw1Dhp7IgL+6682XRAtCIO59Q=";
    
    __block UpYun *uy = [[UpYun alloc] init];
    uy.successBlocker = ^(NSURLResponse *response, id responseData) {
        NSLog(@"上传成功:response body %@", responseData);
        [MBProgressHUD showSuccess:@"上传成功" toView:self.view];
        [self setSkyDrive:@"1" withPath:responseData[@"url"] withName:nameStr withCover:nil];
        
    };
    uy.failBlocker = ^(NSError * error) {
        NSString *message = error.description;
        NSLog(@"上传失败：%@",message);
        NSLog(@"error %@", error);
    };
    uy.progressBlocker = ^(CGFloat percent, int64_t requestDidSendBytes) {
        NSLog(@"当前进度：%f",percent);
        [MBProgressHUD showMessage:[NSString stringWithFormat:@"已上传%.2f%%",percent*100] toView:self.view];
    };
    
    //获取上传文件路径
    [uy uploadFile:img saveKey:suffix];
}

/**
 * 添加网盘文件
 */
- (void)setSkyDrive:(NSString *)type withPath:(NSString *)path withName:(NSString *)name withCover:(NSString *)cover
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"home" forKey:@"app"];
    [param setValue:@"setSkyDrive" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [param setValue:type forKey:@"type"];
    [param setValue:path forKey:@"path"];
    [param setValue:name forKey:@"name"];
    [param setValue:cover forKey:@"cover"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json) {
        NSString *code = json[@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            [self.tableView.mj_header beginRefreshing];
        }
    } failure:^(NSError *error)
    {
        
    }];

}

-(void)videoUrl:(NSURL *)url withName:(NSString *)name
{
    __block NSData *data;
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)
    {
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        Byte *buffer = (Byte*)malloc(rep.size);
        NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
        data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
        if (data)
        {
           
            //设置服务名
            [UPYUNConfig sharedInstance].DEFAULT_BUCKET = @"file-upyun";
            //设置空间表单密钥
            [UPYUNConfig sharedInstance].DEFAULT_PASSCODE = @"Znqw1Dhp7IgL+6682XRAtCIO59Q=";
            
            __block UpYun *uy = [[UpYun alloc] init];
            uy.successBlocker = ^(NSURLResponse *response, id responseData)
            {
                NSLog(@"上传成功:response body %@", responseData);
                [MBProgressHUD showSuccess:@"上传成功" toView:self.view];
           
                [self setSkyDrive:@"2" withPath:responseData[@"url"] withName:responseData[@"url"] withCover:nil];
    
            };
            uy.failBlocker = ^(NSError * error) {
                NSString *message = error.description;
                NSLog(@"上传失败：%@",message);
                NSLog(@"error %@", error);
            };
            uy.progressBlocker = ^(CGFloat percent, int64_t requestDidSendBytes) {
                NSLog(@"当前进度：%f",percent);
                [MBProgressHUD showMessage:[NSString stringWithFormat:@"%.2f%%",percent*100] toView:self.view];
            };
            
            //获取上传文件路径
            [uy uploadFile:data saveKey:name];
            
        }
    }
    failureBlock:^(NSError *err)
     {
         NSLog(@"Error: %@",[err localizedDescription]);
     }];
}

//获取我的权限
-(void)getMyAuth
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"default" forKey:@"app"];
    [param setValue:@"getMyAuth" forKey:@"act"];
    [param setValue:[HelperManager CreateInstance].proId forKey:@"pro_id"];
    [HttpRequestEx postWithURL:SERVICE_URL params:param success:^(id json)
    {
        NSString *code = json[@"code"];
        if ([code isEqualToString:SUCCESS])
        {
            if ([json[@"data"][@"is_charge"] isEqualToString:@"1"])
            {
                //创建“上传文件”按钮
                UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
                [btnFunc setTitle:@"上传文件" forState:UIControlStateNormal];
                [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnFunc.titleLabel setFont:FONT17];
                [btnFunc setBackgroundColor:MAIN_COLOR];
                [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:btnFunc];
                self.tableView.height = SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT-45;
                 is_authority = YES;
            }
            else
            {
                NSArray *arr = [json[@"data"][@"authority"] componentsSeparatedByString:@","];
                for (NSString *authority in arr)
                {
                    if ([authority isEqualToString:@"10"])
                    {
                        UIButton *btnFunc = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-45, SCREEN_WIDTH, 45)];
                        [btnFunc setTitle:@"上传文件" forState:UIControlStateNormal];
                        [btnFunc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [btnFunc.titleLabel setFont:FONT17];
                        [btnFunc setBackgroundColor:MAIN_COLOR];
                        [btnFunc addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
                        [self.view addSubview:btnFunc];
                        self.tableView.height = SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT-45;
                        is_authority = YES;
                    }
                    else
                    {
                        self.tableView.height = SCREEN_HEIGHT -NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT;
                        is_authority = NO;
                    }
                }
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}

////64编码
//- (NSString *)encode:(NSString *)string {
//    //先将string转换成data
//    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *base64Data = [data base64EncodedDataWithOptions:0];
//    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
//    return baseString;
//}
//
//- (NSString *)dencode:(NSString *)base64String {
//    //NSData *base64data = [string dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    return string;
//
//}

@end
