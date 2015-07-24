//
//  ReturnMoneyModel.h
//  Love
//
//  Created by use on 14-12-26.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//
//退款
#import <Foundation/Foundation.h>
#import "APPCommissionDetailDao.h"

@interface ReturnMoneyModel : NSObject
- (instancetype)initWithAttributtes:(NSDictionary *)attributes;

+ (void)getReturnMoneyDataCode:(NSString *)code
                         intro:(NSString *)intro
                          type:(NSString *)type
                         image:(NSString *)img
                         money:(NSString *)money
                         block:(void(^)(int code, NSString *msg))block;
@end
