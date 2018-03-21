//
//  CGLimitTextView.m
//  zteiwh
//
//  Created by 相约在冬季 on 2017/9/13.
//  Copyright © 2017年 印特. All rights reserved.
//

#import "CGLimitTextView.h"

@interface CGLimitTextView ()

@property (nonatomic, strong) UILabel *limitLabel;

@end

@implementation CGLimitTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        //设置默认值
        if(self.limitNum<=0) {
            self.limitNum = 200;
        }
        
        //创建“输入框”
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.textView setTextColor:COLOR3];
        [self.textView setTextAlignment:NSTextAlignmentLeft];
        [self.textView setFont:FONT15];
        [self.textView setDelegate:self];
        [self addSubview:self.textView];
        
        //创建“提示语”
//        if(IsStringEmpty(self.placeHolder)) {
//            self.placeHolder = [NSString stringWithFormat:@"您最多输入%zd个字符",self.limitNum];
//        }
        self.placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, frame.size.width-10, 100)];
        [self.placeHolderLabel setNumberOfLines:0];
        [self.placeHolderLabel setText:self.placeHolder];
        [self.placeHolderLabel setTextColor:COLOR9];
        [self.placeHolderLabel setFont:FONT15];
        [self.textView addSubview:self.placeHolderLabel];
        
        //创建“限制字数、已输入字数”
        self.limitLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width-80, frame.size.height-20, 70, 20)];
        [self.limitLabel setText:[NSString stringWithFormat:@"0/%zd",self.limitNum]];
        [self.limitLabel setTextColor:COLOR9];
        [self.limitLabel setTextAlignment:NSTextAlignmentRight];
        [self.limitLabel setFont:FONT13];
        [self.textView addSubview:self.limitLabel];
        
    }
    return self;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    [self.placeHolderLabel setText:placeHolder];
    [self.placeHolderLabel sizeToFit];
}

- (void)setLimitNum:(NSInteger)limitNum {
    _limitNum = limitNum;
    [self.limitLabel setText:[NSString stringWithFormat:@"0/%zd",limitNum]];
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if([textView.text length]<=0) {
        if(IsStringEmpty(self.placeHolder)) {
            self.placeHolder = [NSString stringWithFormat:@"您最多输入%zd个字符",self.limitNum];
        }
        [self.placeHolderLabel setText:self.placeHolder];
    }else{
        [self.placeHolderLabel setText:@""];
    }
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    NSString  *nsTextContent = textView.text;
    NSInteger enterNum = nsTextContent.length;
    if (enterNum >self.limitNum){
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:self.limitNum];
        [textView setText:s];
    }
    //不让显示负数
    self.limitLabel.text = [NSString stringWithFormat:@"%zd/%zd",MAX(0,enterNum),self.limitNum];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //不支持系统表情的输入
    if ([[textView textInputMode] primaryLanguage]==nil||[[[textView textInputMode] primaryLanguage]isEqualToString:@"emoji"]) {
        return NO;
    }
    UITextRange *selectedRange = [textView markedTextRange];
    
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange =NSMakeRange(startOffset, endOffset - startOffset);
        if (offsetRange.location <self.limitNum) {
            return YES;
        }else{
            return NO;
        }
    }
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen =self.limitNum - comcatstr.length;
    if (caninputlen >=0){
        return YES;
    }else{
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        if (rg.length >0){
            NSString *s =@"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }else{
                __block NSInteger idx =0;
                __block NSString  *trimString =@"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring,NSRange substringRange,NSRange enclosingRange,BOOL* stop) {
                                          if (idx >= rg.length) {
                                              *stop =YES;//取出所需要就break，提高效率
                                              return ;
                                          }
                                          trimString = [trimString stringByAppendingString:substring];
                                          idx++;
                                      }];
                s = trimString;
            }
            
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
            self.limitLabel.text = [NSString stringWithFormat:@"%zd/%zd",self.limitNum,self.limitNum];
        }
        return NO;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
