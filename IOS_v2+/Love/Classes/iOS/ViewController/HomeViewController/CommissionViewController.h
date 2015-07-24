//
//  CommissionViewController.h
//  Love
//
//  Created by lee wei on 14-8-20.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  返利首页
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CommissionButtonTag)
{
    CommissionButtonTagWithCommission = 0,
    CommissionButtonTagWithDiscount = 1,
    CommissionButtonTagWithComment = 2,
    CommissionButtonTagWithLike = 3,
    CommissionButtonTagWithBuy = 4,
    CommissionButtonTagWithSubject = 5
};

@protocol CommissionViewControllerDelegate <NSObject>

- (void)toggleLeftDrawerSide;
- (void)toggleRightDrawerSide;

@end

@interface CommissionViewController : LOVBaseTabViewController

@property (nonatomic, weak) id<CommissionViewControllerDelegate> delegate;

- (void)reloadCommissionView;

@end
