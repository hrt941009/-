//
//  AllOrderModel.m
//  Love
//
//  Created by use on 14-12-1.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "AllOrderModel.h"
#import "APPNetworkDao.h"

static NSString * const kAllOrderURL = @"OrderList/allList";
NSString * const kAllOrderListNotificationName = @"kAllOrderListNotificationName";

@implementation AllOrderModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _orderId = [attributes valueForKey:@"id"];
        _code = [attributes valueForKey:@"code"];
        _seller_id = [attributes valueForKey:@"seller_id"];
        _seller_name = [attributes valueForKey:@"seller_name"];
        _create_time = [attributes valueForKey:@"create_time"];
        _status = [attributes valueForKey:@"status"];
        _type = [attributes valueForKey:@"type"];
        _total_price = [attributes valueForKey:@"total_price"];
        _order_detail = [attributes valueForKey:@"order_detail"];
    }
    return self;
}


+ (void)getAllOrderStatus:(NSString*)status andPage:(NSString *)page andPageNum:(NSString *)pageNum{
    NSString *urlStr = [NSString stringWithFormat:@"%@?status=%@&p=%@&pnum=%@",kAllOrderURL,status,page,pageNum];
    [APPNetworkDao getURLString:urlStr
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  if ([array count] > 0) {
                                      for (NSDictionary *dic in array) {
                                          AllOrderModel *model = [[AllOrderModel alloc] initWithAttributes:dic];
                                          [mutableArray addObject:model];
                                      }
                                      resultArray = [NSArray arrayWithArray:mutableArray];
                                  }
                              }else{
                                    resultArray = [NSMutableArray array];
                            }
                            [[NSNotificationCenter defaultCenter] postNotificationName:kAllOrderListNotificationName object:[NSArray arrayWithArray:resultArray]];
                          }];
}

@end
