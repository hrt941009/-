//
//  SellerLiveModel.m
//  Love
//
//  Created by 李伟 on 14-7-23.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "ShoppingLiveModel.h"
#import "APPNetworkDao.h"
#import "APPCommissionDetailDao.h"

static  NSString * const kShoppingLiveDetailURL = @"HtLive/liveInfo";
static  NSString * const kShoppingLiveListURL = @"HtLive/liveProductList";

NSString * const kShoppingLiveListNotificationName = @"kShoppingLiveListNotificationName";

@implementation ShoppingLiveDetailModel

+ (void)getLiveDetailInfoWithLiveID:(NSString *)liveID block:(void (^)(NSString *sellerId,
                                                                       NSString *sellerName,
                                                                       NSString *header,
                                                                       NSString *description,
                                                                       NSString *Location,
                                                                       NSString *flag,
                                                                       NSString *startTime,
                                                                       NSString *endTime,
                                                                       NSString *attention,
                                                                       NSNumber *currentTime))block
{
    [APPCommissionDetailDao getURLString:[NSString stringWithFormat:@"%@?live=%@", kShoppingLiveDetailURL, liveID]
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       if ([dic count] > 0) {
                                           if (block) {
                                               block([[dic valueForKey:@"sellerInfo"] valueForKey:@"header"],
                                                     [[dic valueForKey:@"sellerInfo"] valueForKey:@"sellerName"],
                                                     [[dic valueForKey:@"sellerInfo"] valueForKey:@"header"],
                                                     [dic valueForKey:@"description"],
                                                     [dic valueForKey:@"location"],
                                                     [dic valueForKey:@"flag"],
                                                     [dic valueForKey:@"start_time"],
                                                     [dic valueForKey:@"end_time"],
                                                     [dic valueForKey:@"isAttention"], //是否关注：0 未关注，1 关注
                                                     currentTime);
                                           }
                                       }
                                   }];
}

@end

@implementation ShoppingLiveModel


- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _userName = @"userName";
        _msg = @"msg";
        _commentArray = [attributes valueForKey:@"debates"];
        _sellerName = [attributes valueForKey:@"name"];
        _itemID = [attributes valueForKey:@"itemID"];
        _imagesArray = [attributes valueForKey:@"images"];
        _shopDescription = [attributes valueForKey:@"description"];
        _stock = [attributes valueForKey:@"stock"];
        _price = [attributes valueForKey:@"price"];
        _startTime = [attributes valueForKey:@"startTime"];
        _rebateNum = [attributes valueForKey:@"rebate_num"];
    }
    return self;
}

/**
 
 @param   liveID 直播ID
 
 @return  block
 */
+ (void)getLiveDetailInfoWithLiveID:(NSString *)liveID page:(NSString *)page pageNum:(NSString *)pnum
{
    [APPNetworkDao getURLString:[NSString stringWithFormat:@"%@?live=%@&p=%@&pnum=%@", kShoppingLiveListURL, liveID, page, pnum]
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                              if ([array count] > 0) {
                                  for (NSDictionary *dic in array) {
                                      ShoppingLiveModel *listModel = [[ShoppingLiveModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:listModel];
                                  }
                                  [[NSNotificationCenter defaultCenter] postNotificationName:kShoppingLiveListNotificationName
                                                                                      object:[NSArray arrayWithArray:mutableArray]
                                                                                    userInfo:nil];
                              }
                          }];
}

@end
