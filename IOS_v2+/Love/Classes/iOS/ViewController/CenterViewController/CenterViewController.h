//
//  CenterViewController.h
//  Love
//
//  Created by 李伟 on 14-6-26.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  我-个人信息
//

#import <UIKit/UIKit.h>
@protocol RemoveMeViewSubviewsDelegate <NSObject>

- (void)removeMeViewSubviews;

@end

@interface CenterViewController : LOVBaseViewController

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, weak) id<RemoveMeViewSubviewsDelegate>delegate;

@end
