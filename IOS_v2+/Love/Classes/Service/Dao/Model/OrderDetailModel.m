//
//  OrderDetailModel.m
//  Love
//
//  Created by use on 14-12-1.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "OrderDetailModel.h"
#import "APPCommissionDetailDao.h"

static NSString * const kOrderDetailURL = @"OrderList/info";
NSString * const kOrderDetailNotificationName = @"kOrderDetailNotificationName";
@implementation OrderDetailModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _invoice = [attributes objectForKey:@"invoice"];
        _post_type = [attributes objectForKey:@"post_type"];
        _orderDetailId = [attributes objectForKey:@"id"];
        _code = [attributes objectForKey:@"code"];
        _seller_id = [attributes objectForKey:@"seller_id"];
        _seller_name = [attributes objectForKey:@"seller_name"];
        _adress_info = [attributes objectForKey:@"adress_info"];
        _create_time = [attributes objectForKey:@"create_time"];
        _status = [attributes objectForKey:@"status"];
        _type = [attributes objectForKey:@"type"];
        _post_price = [attributes objectForKey:@"post_price"];
        _rebate = [attributes objectForKey:@"rebate"];
        _total_price = [attributes objectForKey:@"total_price"];
        _order_detail = [attributes objectForKey:@"order_detail"];
    }
    return self;
}

+ (void)getOrderDetail:(NSString *)orderCode{
    NSString *urlStr = [NSString stringWithFormat:@"%@?code=%@",kOrderDetailURL,orderCode];
    [APPCommissionDetailDao getURLString:urlStr
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                       OrderDetailModel *model = [[OrderDetailModel alloc] initWithAttributes:dic];
                                       [mutableArray addObject:model];
                                       [[NSNotificationCenter defaultCenter] postNotificationName:kOrderDetailNotificationName object:[NSArray arrayWithArray:mutableArray]];
    }];
}

@end
