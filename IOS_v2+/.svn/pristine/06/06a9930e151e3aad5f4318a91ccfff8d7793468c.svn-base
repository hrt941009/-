//
//  FollowDresserLiveViewController.h
//  Love
//
//  Created by lee wei on 15/2/3.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//
//关注达人

#import <UIKit/UIKit.h>

@protocol FollowDresserLiveControllerDelegate <NSObject>

- (void)pushDresserDetailViewControllerWithUserID:(NSString *)userId userName:(NSString *)userName;

@end

@interface FollowDresserLiveViewController : UIViewController

@property (nonatomic, weak) id<FollowDresserLiveControllerDelegate> delegate;


- (void)isConnect:(BOOL)connect;

@end
