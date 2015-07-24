//
//  LOVWriteCommentView.h
//  Love
//
//  Created by lee wei on 15/3/4.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LOVWriteCommentViewDelegate <NSObject>
@optional
- (void)postCommentContent:(NSString *)content;
- (void)cancelWirteComment;

@end

@interface LOVWriteCommentView : UIView <UITextViewDelegate>
{
    UITextView *contentView;
}

@property (nonatomic, weak) id<LOVWriteCommentViewDelegate> delegate;

- (instancetype)init;
- (void)showWirteView;
- (void)hiddenViewAction;
- (void)closeKeyboard;

@end
