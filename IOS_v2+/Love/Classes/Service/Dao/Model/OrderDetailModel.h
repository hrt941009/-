//
//  OrderDetailModel.h
//  Love
//
//  Created by use on 14-12-1.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//订单详情

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject
extern NSString * const kOrderDetailNotificationName;

@property (nonatomic ,strong) NSString *post_type;//快递方式
@property (nonatomic ,strong) NSString *invoice;//发票信息
@property (nonatomic ,strong) NSString *orderDetailId;//订单ID
@property (nonatomic ,strong) NSString *code;//订单号
@property (nonatomic ,strong) NSString *seller_id;//卖家ID
@property (nonatomic ,strong) NSString *seller_name;//卖家名称
@property (nonatomic ,strong) NSDictionary *adress_info;//卖家详细信息
@property (nonatomic ,strong) NSString *create_time;//创建时间
@property (nonatomic ,strong) NSString *status;//订单状态（-1-审核中，0-未支付，1-待发货，2-已发货，3-已收货，4-已取消，31-已评论)，5-退款申请中，51-待退货，52-已退货，53-卖家收货，50-确认退款）
@property (nonatomic ,strong) NSString *type;//订单类型（0-普通订单，1-海外预定订单,2-海淘订单）
@property (nonatomic ,strong) NSString *post_price;//物流价格
@property (nonatomic ,strong) NSString *rebate;//返利价格
@property (nonatomic ,strong) NSString *total_price;//一条订单详情的价格
@property (nonatomic ,strong) NSArray *order_detail;//订单详情

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getOrderDetail:(NSString *)orderCode;

@end
