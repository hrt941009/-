//
//  MCPagerView.h
//  MCPagerView
//
//  Created by Baglan on 7/20/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//
//  自定义的pagecontrol
//

#import <UIKit/UIKit.h>

#define MCPAGERVIEW_DID_UPDATE_NOTIFICATION @"MCPageViewDidUpdate"

@protocol MCPagerViewDelegate;

@interface MCPagerView : UIView

- (void)setImagePath:(NSString *)path forKey:(NSString *)key;

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,readonly) NSInteger numberOfPages;
@property (nonatomic,readonly) CGFloat imgViewWidth;
@property (nonatomic,readonly) CGFloat imgViewHeight;
@property (nonatomic,copy) NSString *pattern;
@property (nonatomic,assign) id<MCPagerViewDelegate>delegate;
@property (nonatomic, readonly) NSTimer *timer;

@end

@protocol MCPagerViewDelegate <NSObject>

@optional
- (BOOL)pageView:(MCPagerView *)pageView shouldUpdateToPage:(NSInteger)newPage;
- (void)pageView:(MCPagerView *)pageView didUpdateToPage:(NSInteger)newPage;

@end