//
//  CommissionDetailModel.m
//  Love
//
//  Created by lee wei on 14-9-27.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CommissionDetailModel.h"
#import "APPNetworkDao.h"
#import "APPCommissionDetailDao.h"

NSString * const kCommissionDescNotificationName = @"kCommissionDescNotificationName";
static NSString * const kCommissionDescURL = @"FlItem/getDescription";
static NSString * const kCommissionDetailURL = @"FlItem/info";


@implementation CommissionDescModel

//商品id
+ (void)getCommissionDescListWithID:(NSString *)cid
{
    [APPNetworkDao getURLString:[NSString stringWithFormat:@"%@?id=%@", kCommissionDescURL, cid]
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              
                              [[NSNotificationCenter defaultCenter] postNotificationName:kCommissionDescNotificationName
                                                                                  object:array
                                                                                userInfo:nil];
                          }];
}

@end

@implementation CommissionDetailModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _cid = [attributes objectForKey:@"id"];
        _cName = [attributes objectForKey:@"name"];
        _cImageArray = [attributes objectForKey:@"images"];
        _originalPrice = [attributes objectForKey:@"original_price"];
        _price = [attributes objectForKey:@"price"];
        _save = [attributes objectForKey:@"save"];
        _discuss = [attributes objectForKey:@"discuss"];
        _love = [attributes objectForKey:@"love"];
        _isRebate = [attributes objectForKey:@"is_rebate"];
        _rebate = [attributes objectForKey:@"rebate"];
        _hasCoupon = [attributes objectForKey:@"has_coupon"];
        _hasDiscount = [attributes objectForKey:@"has_discount"];
        _discount = [attributes objectForKey:@"discount"];
        _hasNextPrice = [attributes objectForKey:@"has_next_price"];
        _nextPrice = [attributes objectForKey:@"next_price"];
        _isAttention = [attributes objectForKey:@"is_attention"];
        _commissionStock = [attributes objectForKey:@"stock"];
        _sales = [attributes objectForKey:@"sales"];
        _brandId = [attributes objectForKey:@"brand_id"];
        _brandName = [attributes objectForKey:@"brand_name"];
        _intro = [attributes objectForKey:@"intro"];
    }
    return self;
}

//item 商品ID
+ (void)getDetailWithItem:(NSString *)item block:(void(^)(NSArray *array))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@?item=%@", kCommissionDetailURL, item];
    [APPCommissionDetailDao getURLString:urlString
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       if ([dic count] > 0) {
                                           NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                           CommissionDetailModel *model = [[CommissionDetailModel alloc] initWithAttributes:dic];
                                           [mutableArray addObject:model];
                                           if (block) {
                                               block([NSArray arrayWithArray:mutableArray]);
                                           }
                                       } 
                          }];
}

@end
