//
//  CGLocalVideoListViewController.m
//  ChengGeLeasing
//
//  Created by 相约在冬季 on 2017/12/27.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLocalVideoListViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CGLocalVideoCell.h"

@interface CGLocalVideoListViewController ()

@end

@implementation CGLocalVideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"本地视频";
    
}

/**
 *  关闭页面
 */
- (void)leftButtonItemClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CGLocalVideoCell";
    CGLocalVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CGLocalVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGLocalVideoModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [cell setLocalVideoModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CGLocalVideoModel *model;
    if(self.dataArr.count) {
        model = [self.dataArr objectAtIndex:indexPath.row];
    }
    if(self.callBack) {
        self.callBack(model);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 *  获取视频信息
 */
- (void)getDataList:(BOOL)isMore {
    
    ALAssetsLibrary *assetsLib = [[ALAssetsLibrary alloc] init];
    [assetsLib enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allVideos]];
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    CGLocalVideoModel *model = [CGLocalVideoModel new];
                    model.video_name = [[result defaultRepresentation] filename];
                    model.thumbnail = [UIImage imageWithCGImage:result.thumbnail];
                    model.video_url = result.defaultRepresentation.url;
                    model.duration = [result valueForProperty:ALAssetPropertyDuration];
                    model.video_time = [self getFormatedDateStringOfDate:[result valueForProperty:ALAssetPropertyDate]];
                    model.video_size = result.defaultRepresentation.size;
                    [self.dataArr addObject:model];
                }
            }];
            [self.tableView reloadData];
            [self endDataRefresh];
        } else {
            //没有更多的group时，即可认为已经加载完成。
            //NSLog(@"after load, the total alumvideo count is %ld",_albumVideoInfos.count);
            //self.dataArr = [_albumVideoInfos mutableCopy];
            //dispatch_async(dispatch_get_main_queue(), ^{
            //    [[NSNotificationCenter defaultCenter] postNotificationName:@"Player" object:nil];
            //});
        }
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Failed.");
    }];
    
}

- (NSString *)getFormatedDateStringOfDate:(NSDate *)date{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd:HH:mm"]; //注意时间的格式：MM表示月份，mm表示分钟，HH用24小时制，小hh是12小时制。
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
