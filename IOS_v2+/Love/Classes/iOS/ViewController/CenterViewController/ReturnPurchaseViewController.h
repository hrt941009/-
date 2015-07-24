//
//  ReturnPurchaseViewController.h
//  Love
//
//  Created by use on 14-11-24.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//退款

#import <UIKit/UIKit.h>

@interface ReturnPurchaseViewController : LOVBaseViewController
@property (nonatomic, strong) NSString *orderNumber;//订单编号
@property (nonatomic, strong) NSString *orderMoney;//订单价格
@property (nonatomic, strong) NSString *orderStatus;//订单状态
@end
