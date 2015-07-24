//
//  ShopNewModel.m
//  Love
//
//  Created by lee wei on 14/12/21.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ShopNewModel.h"
#import "APPNetworkDao.h"

NSString * const kShopNewNotificationName = @"kShopDiscountNotificationName";
static NSString * const kShopNewURL = @"Shop/newItem?id";

@implementation ShopNewModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+ (void)getShopNewWithShopID:(NSString *)shopID page:(NSString *)page pageNum:(NSString *)pageNum
{
    [APPNetworkDao getURLString:[NSString stringWithFormat:@"%@=%@", kShopNewURL, shopID]
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                              for (int i = 0; i < [array count]; i++) {
                                  id object = array[i];
                                  if ([object isKindOfClass:[NSDictionary class]]) {
                                      ShopNewModel *model = [[ShopNewModel alloc] initWithAttributes:(NSDictionary *)object];
                                      [mutableArray addObject:model];
                                  }
                              }
                              [[NSNotificationCenter defaultCenter] postNotificationName:kShopNewNotificationName object:[NSArray arrayWithArray:mutableArray]];
                          }];
}


@end
