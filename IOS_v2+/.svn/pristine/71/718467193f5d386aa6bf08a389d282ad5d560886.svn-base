//
//  ShopDiscountModel.m
//  Love
//
//  Created by lee wei on 14/12/21.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ShopDiscountModel.h"
#import "APPNetworkDao.h"

NSString * const kShopDiscountNotificationName = @"kShopDiscountNotificationName";
static NSString * const kShopDiscountURL = @"Shop/returnItem?id";

@implementation ShopDiscountModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _productId = [attributes objectForKey:@"id"];
        _productName = [attributes objectForKey:@"name"];
        _isRebate = [attributes objectForKey:@"is_rebate"];
        _rebateInfo = [attributes objectForKey:@"rebate"];
        _oldPrice = [attributes objectForKey:@"old_price"];
        _price = [attributes objectForKey:@"price"];
        _thumb = [attributes objectForKey:@"thumb"];
    }
    return self;
}
+ (void)getShopDiscountWithShopID:(NSString *)shopID page:(NSString *)page pageNum:(NSString *)pageNum
{
    [APPNetworkDao getURLString:[NSString stringWithFormat:@"%@=%@", kShopDiscountURL, shopID]
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                              for (int i = 0; i < [array count]; i++) {
                                  id object = array[i];
                                  if ([object isKindOfClass:[NSDictionary class]]) {
                                      ShopDiscountModel *model = [[ShopDiscountModel alloc] initWithAttributes:(NSDictionary *)object];
                                      [mutableArray addObject:model];
                                  }
                              }
                              [[NSNotificationCenter defaultCenter] postNotificationName:kShopDiscountNotificationName object:[NSArray arrayWithArray:mutableArray]];
                          }];
}

@end
