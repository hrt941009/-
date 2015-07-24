//
//  PaymentViewController.h
//  Love
//
//  Created by use on 14-11-21.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//支付页面

#import <UIKit/UIKit.h>

@interface PaymentViewController : LOVBaseViewController

@property (nonatomic, strong) NSString *orderNum;
@property (nonatomic, strong) NSString *status;
@property (nonatomic ,strong) NSString *customerID;


@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, strong) NSString *customerName;
@property (nonatomic, strong) NSString *payAll;
@property (nonatomic, strong) NSString *balance;
@end
