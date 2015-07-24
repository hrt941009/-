//
//  FollowDresserViewController.h
//  Love
//
//  Created by 李伟 on 14-10-16.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  关注美妆师
//

#import <UIKit/UIKit.h>

@protocol FollowDresserControllerDelegate <NSObject>

- (void)pushDresserViewControllerWithDresserID:(NSString *)did Title:(NSString *)title;

@end

@interface FollowDresserViewController : UIViewController

@property (nonatomic, weak) id<FollowDresserControllerDelegate> delegate;


- (void)isConnect:(BOOL)connect;

@end
