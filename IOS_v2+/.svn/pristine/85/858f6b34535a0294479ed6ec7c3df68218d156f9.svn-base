//
//  FollowTagViewController.h
//  Love
//
//  Created by use on 15-4-6.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  FollowMasterDelegate <NSObject>

- (void)pushFollowTagDetailDelegateWithTagId:(NSString *)tagId tagName:(NSString *)tagName;

@end

@interface FollowTagViewController : LOVBaseViewController
- (void)isConnect:(BOOL)connect;

@property (nonatomic, strong) id<FollowMasterDelegate>delegate;

@end
