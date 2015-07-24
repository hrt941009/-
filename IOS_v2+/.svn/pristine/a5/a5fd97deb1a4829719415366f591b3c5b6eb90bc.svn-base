//
//  SubmitOrderModel.h
//  Love
//
//  Created by use on 15-1-21.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//
//提交订单模型
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, InvoiceCode)
{
    InvoiceCodeIndividual = 1,
    InvoiceCodeCompany = 2,
};

@interface SubmitOrderModel : NSObject
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *alipay_order_no;

- (instancetype)initWithAttributtes:(NSDictionary *)attributes;
+ (void)submitOrderDataWithCode:(NSString*)code address:(NSString*)addressId Msg:(NSString *)msg baaiIcon:(NSString *)baaiIcon invoice:(NSString *)invoice cartId:(NSString *)cartId block:(void(^)(int code, NSString *msg, NSString *alipayOrderNo))block;
@end
