//
//  AllOrderViewController.h
//  Love
//
//  Created by lee wei on 14-10-4.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  我-我的订单-所有订单&待付款&待发货
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MyOrderStatus)
{
    MyOrderStatusALl = 0,
    MyOrderStatusPay,
    MyOrderStatusSendGoods,
    MyOrderStatusReceive
};

@interface AllOrderViewController : LOVBaseViewController

@property (nonatomic, assign) NSInteger orderStatus;

@end
