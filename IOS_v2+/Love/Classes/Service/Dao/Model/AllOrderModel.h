//
//  AllOrderModel.h
//  Love
//
//  Created by use on 14-12-1.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//
//所有订单

#import <Foundation/Foundation.h>

@interface AllOrderModel : NSObject
extern NSString * const kAllOrderListNotificationName;

@property (nonatomic, strong) NSString *orderId;//订单ID
@property (nonatomic, strong) NSString *code;//订单号
@property (nonatomic, strong) NSString *seller_id;//卖家ID
@property (nonatomic, strong) NSString *seller_name;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *status;//订单状态( -1-所有订单，0-未支付，1-待发货，2-已发货，3-已收货，4-已取消，31-已评论)，5-退款申请中，51-待退货，52-已退货，53-卖家收货，50-确认退款)
@property (nonatomic, strong) NSString *type;//订单类型(0-普通订单，1-海外预定订单,2-海淘订单)
@property (nonatomic, strong) NSString *total_price;//付款金额
@property (nonatomic, strong) NSArray *order_detail;


- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getAllOrderStatus:(NSString*)status andPage:(NSString *)page andPageNum:(NSString *)pageNum;

@end
