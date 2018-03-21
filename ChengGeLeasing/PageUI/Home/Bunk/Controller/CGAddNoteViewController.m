//
//  CGAddNoteViewController.m
//  ChengGeLeasing
//
//  Created by 徐中华 on 2017/12/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGAddNoteViewController.h"
#import "CGLimitTextView.h"
@interface CGAddNoteViewController ()

@property (nonatomic ,strong) CGLimitTextView *limitView;

@end

@implementation CGAddNoteViewController

- (void)viewDidLoad {
    self.hiddenHeaderRefresh = YES;
    [self setRightButtonItemTitle:@"保存"];
    [super viewDidLoad];
    
    self.title = @"添加备注";
}

- (void)rightButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
    if(self.callBack) {
        self.callBack(self.limitView.textView.text);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CGAddNoteViewController";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    //创建“详情输入框”
    self.limitView = [[CGLimitTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    self.limitView.limitNum = 200;
    if (IsStringEmpty(self.content))
    {
        self.limitView.placeHolder = @"详情...";
    }
    else
    {
        self.limitView.textView.text = self.content;
    }
    
    [cell.contentView addSubview:self.limitView];
    
    return cell;
}
@end
