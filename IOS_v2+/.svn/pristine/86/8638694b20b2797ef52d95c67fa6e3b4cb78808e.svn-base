//
//  LOVGuardView.h
//  Love
//
//  Created by 李伟 on 14-6-27.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  第一次启动app显示的引导界面
//

#import <UIKit/UIKit.h>

@protocol LOVGuardViewDelegate <NSObject>

@optional
- (void)startApp;

@end

@interface LOVGuardView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong, readonly) UIImageView *imgView;
@property (nonatomic, strong, readonly) UIButton *startButton;

@property (nonatomic, strong, readonly) UISwipeGestureRecognizer *leftSwipe;
@property (nonatomic, strong, readonly) UISwipeGestureRecognizer *rightSwipe;

@property (nonatomic, assign, readonly) int pages;

@property (nonatomic, weak) id<LOVGuardViewDelegate> delegate;

@end
