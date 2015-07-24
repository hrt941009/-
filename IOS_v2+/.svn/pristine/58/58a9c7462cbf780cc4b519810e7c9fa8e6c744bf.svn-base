//
//  SellerHomePageModel.m
//  Love
//
//  Created by 李伟 on 14-10-14.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SellerHomePageModel.h"
#import "APPCommissionDetailDao.h"

static NSString * const kSellerLiveInfURL = @"HtSeller/lists";

//------
@implementation SellerLivingInfoModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    
    if (self) {
        
        _shopingLiveID = [attributes valueForKey:@"shopingLiveID"];
        _sellerDescription = [attributes valueForKey:@"description"];
        _sellerLocation = [attributes valueForKey:@"location"];
        _liveStatus = [attributes valueForKey:@"status"];
        _liveTime = [attributes valueForKey:@"time"];
    }
    
    return self;
}

@end

//------
@implementation SellerFutureLiveInfoModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    
    if (self) {
        
        _shopingLiveID = [attributes valueForKey:@"shopingLiveID"];
        _sellerDescription = [attributes valueForKey:@"description"];
        _sellerLocation = [attributes valueForKey:@"location"];
        _liveStatus = [attributes valueForKey:@"status"];
        _liveTime = [attributes valueForKey:@"time"];
    }
    
    return self;
}

@end

//------
@implementation SellerHistoryLiveInfoModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    
    if (self) {
        
        _shopingLiveID = [attributes valueForKey:@"shopingLiveID"];
        _sellerDescription = [attributes valueForKey:@"description"];
        _sellerLocation = [attributes valueForKey:@"location"];
        _liveStatus = [attributes valueForKey:@"status"];
        _liveTime = [attributes valueForKey:@"time"];
    }
    
    return self;
}

@end

//------
@implementation SellerHomePageModel

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _sellerID = @"id";
        _sellerName = @"sellerName";
        _sellerLocation = @"location";
        _sellerCountry = @"country";
        _countryFlag = @"flag";
        _headerPhoto = @"header";
        _followNum = @"follow";
        _itemsNum = @"items";
        _liveNum = @"live";
        _shopBackground = @"shop_bg";
        _isAttention = @"isAttention";
    }
    
    return self;
}

/**
 
 @param   sellerId 买手ID
 
 @return  block
 */
+ (void)getSellerDetailInfoWithId:(NSString *)sellerId
                          pageNum:(NSString *)pnum
                            block:(void(^)(NSDictionary *sellerInfoDic, NSArray *livingArray, NSArray *futureArray, NSArray *historyArray))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@?seller=%@&pnum=%@", kSellerLiveInfURL, sellerId, pnum];
    [APPCommissionDetailDao getURLString:urlString
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       
                                       NSMutableArray *livingMutableArray = [[NSMutableArray alloc] init];
                                       NSMutableArray *futureMutableArray = [[NSMutableArray alloc] init];
                                       NSMutableArray *historyMutableArray = [[NSMutableArray alloc] init];
                                       
                                       /*字段说明
                                       shoppingLive   正在直播
                                       future		    即将开始直播
                                       history		已结束直播
                                       info		    买手信息
                                       */
                                       
                                       NSDictionary *sellerInfoDic = [dic objectForKey:@"info"];

                                       NSArray *shoppingLiveArray = [dic objectForKey:@"shoppingLive"];
                                       if ([shoppingLiveArray count] > 0) {
                                           for (NSDictionary *livingDic in shoppingLiveArray) {
                                               if ([livingDic count] > 0) {
                                                   SellerLivingInfoModel *livingModel = [[SellerLivingInfoModel alloc] initWithAttributes:livingDic];
                                                   [livingMutableArray addObject:livingModel];
                                               }
                                           }
                                       }
                                       
                                       NSArray *futureLiveArray = [dic objectForKey:@"future"];
                                       if ([futureLiveArray count] > 0) {
                                           for (NSDictionary *futureDic in futureLiveArray) {
                                               if ([futureDic count] > 0) {
                                                   SellerFutureLiveInfoModel *futureModel = [[SellerFutureLiveInfoModel alloc] initWithAttributes:futureDic];
                                                   [futureMutableArray addObject:futureModel];
                                               }
                                           }
                                       }
                                       
                                       NSArray *shoppingHistoryArray = [dic objectForKey:@"history"];
                                       if ([shoppingHistoryArray count] > 0) {
                                           for (NSDictionary *historyDic in shoppingHistoryArray) {
                                               if ([historyDic count] > 0) {
                                                   SellerHistoryLiveInfoModel *historyModel = [[SellerHistoryLiveInfoModel alloc] initWithAttributes:historyDic];
                                                   [historyMutableArray addObject:historyModel];
                                                   NSLog(@"historyDic = %@", historyDic);
                                               }
                                           }
                                           NSLog(@"shoppingHistoryArray = %@", shoppingHistoryArray);
                                           NSLog(@"historyMutableArray = %@", historyMutableArray);
                                       }
                                       
                                       if (block) {
                                           block(sellerInfoDic,
                                                 [NSArray arrayWithArray:livingMutableArray],
                                                 [NSArray arrayWithArray:futureMutableArray],
                                                 [NSArray arrayWithArray:historyMutableArray]);
                                       }
                                   }];
}

@end
