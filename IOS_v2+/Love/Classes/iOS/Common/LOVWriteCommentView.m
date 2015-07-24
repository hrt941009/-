//
//  LOVWriteCommentView.m
//  Love
//
//  Created by lee wei on 15/3/4.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "LOVWriteCommentView.h"

@implementation LOVWriteCommentView

/** 
 初始化
 
 @param   cid     评论的专辑id／商品id
 @param   toId 	  评论人id
 @param   conent  评论内容
 
 @return  block
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [[UIScreen mainScreen] bounds];
        self.alpha = 1.f;
        
        UIWindow *win =  [[UIApplication sharedApplication] keyWindow];
        [win addSubview:self];
    }
    return self;
}


- (void)showWirteView
{
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = self.bounds;
    bgButton.backgroundColor = [UIColor darkGrayColor];
    bgButton.alpha = 0.5;
    [bgButton addTarget:self action:@selector(hiddenViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgButton];
    
    UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 300.f, self.frame.size.width, 300.f)];
    commentView.backgroundColor = [UIColor colorRGBWithRed:246.f green:246.f blue:246.f alpha:1.f];
    [self addSubview:commentView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(15.f, 5.f, 23.f, 23.f);
    cancelButton.backgroundColor = [UIColor clearColor];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"comment_cancel"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [commentView addSubview:cancelButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 216)/2, 5.f, 216.f, 30.f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = MyLocalizedString(@"写评论");
    titleLabel.font = [UIFont systemFontOfSize:14.f];
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [commentView addSubview:titleLabel];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(kScreenWidth - 38.f, 5.f, 23.f, 23.f);
    submitButton.backgroundColor = [UIColor clearColor];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"comment_submit"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [commentView addSubview:submitButton];
    
    contentView = [[UITextView alloc] initWithFrame:CGRectMake(15.f, CGRectGetMaxY(titleLabel.frame), kScreenWidth - 40.f, 74.f)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    contentView.layer.borderWidth = 0.8;
    contentView.delegate = self;
    contentView.text = MyLocalizedString(@"最多50字");
    contentView.textColor = [UIColor lightGrayColor];
    //[contentView becomeFirstResponder];
    [commentView addSubview:contentView];
}

- (void)closeKeyboard
{
    [contentView resignFirstResponder];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    contentView.text = nil;
    contentView.textColor = [UIColor darkGrayColor];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.length > 50) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - button action
- (void)hiddenViewAction
{
    contentView.text = MyLocalizedString(@"最多50字");
    contentView.textColor = [UIColor lightGrayColor];
    [contentView resignFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }];
}

- (void)cancelAction:(id)sender
{
    [self hiddenViewAction];
    [_delegate cancelWirteComment];
}

- (void)submitAction:(id)sender
{
    [_delegate postCommentContent:contentView.text];
}

@end
