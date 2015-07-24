//
//  OrderDetailController.h
//  Love
//
//  Created by use on 14-11-21.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//订单详情

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
@protocol OrderDetailDelegate <NSObject>
@required
- (void)orderCancleButtonClick;
@end

typedef NS_ENUM(NSInteger, MeOrderStatus)
{
    MeOrderStatusALl = 0,
    MeOrderStatusPay,
    MeOrderStatusSendGoods,
    MeOrderStatusReceive
};


@interface OrderDetailController : LOVBaseViewController

@property (nonatomic ,strong) NSString *orderDetailCode;
@property (nonatomic ,strong) NSArray *detailDataArray;

@property (nonatomic, weak) id<OrderDetailDelegate>delegate;

@end
