//
//  FollowBrandViewController.h
//  Love
//
//  Created by lee wei on 14-9-22.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  关注店铺（原来为关注品牌，此处类名字没做修改）
//

#import <UIKit/UIKit.h>

@protocol FollowBrandControllerDelegate <NSObject>

- (void)pushBrandViewControllerWithBrandID:(NSString *)bid;

@end

@interface FollowBrandViewController : UIViewController

@property (nonatomic, weak) id<FollowBrandControllerDelegate> delegate;

- (void)isConnect:(BOOL)connect;

@end
