//
//  DresserDetailModel.m
//  Love
//
//  Created by lee wei on 14-10-19.
//  Copyright (c) 2014年 李伟. All rights reserved.
//



#import "DresserDetailModel.h"
#import "APPCommissionDetailDao.h"
#import "APPNetworkDao.h"

static NSString * const kDresserInfoURL = @"ArtistSeller/lists";
static NSString * const kDresserProductURL = @"ArtistItem/liveitem";
static NSString * const kDresserDetailURL = @"ArtistLive/liveInfo";
static NSString * const kDresserLiveURL = @"ArtistLive/liveAll";

NSString * const kDresserInfoNotification = @"kDresserInfoNotification";
NSString * const kDresserProductListNotification = @"kDresserProductListNotification";
NSString * const kDresserDetailNotification = @"kDresserDetailNotification";
NSString * const kDresserLiveNotification = @"kDresserLiveNotification";


@implementation DresserInfoModel

/** 美妆师信息
 @param   id	    商品ID
 @param   name	    商品名
 @param   follow
 @param   items
 @param   star
 @param   intro
 @param   header
 @param   shop_bg
 @param   location
 @param   is_Attention  0 未关注；1 已关注
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _sid = @"id";
        _dresserName = @"name";
        _followNum = @"follow";
        _itemsNum = @"items";
        _dresserLevel = @"star";
        _dresserInfo = @"intro";
        _headerPath = @"header";
        _shopBackground = @"shop_bg";
        _dresserLocation = @"location";
        _attention = @"is_Attention";
    }
    return self;
}


+ (void)getDresserInfoWithSellerID:(NSString *)sellerID
{
    [APPCommissionDetailDao getURLString:[NSString stringWithFormat:@"%@?seller=%@", kDresserInfoURL, sellerID]
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       if ([dic count] > 0) {
                                           [[NSNotificationCenter defaultCenter] postNotificationName:kDresserInfoNotification
                                                                                               object:nil
                                                                                             userInfo:dic];
                                       }
                                   }];
}


@end


@implementation DresserProductModel

/** 美妆师直播详情商品列表
 @param   id	    商品ID
 @param   name	    商品名
 @param   price	    价格
 @param   is_recom	0不是推荐 1是推荐
 @param   recom_id	is_recom为1时，从该item点进去的商品加购物车要传 recom 参数，生成订单也需传该参数
 */

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _productID = [attributes valueForKey:@"id"];
        _productName = [attributes valueForKey:@"name"];
        _productPrice = [attributes valueForKey:@"price"];
        _thumbPath = [attributes valueForKey:@"thumb"];
        _isRecom = [attributes valueForKey:@"is_recom"];
        _recomId = [attributes valueForKey:@"recom_id"];
    }
    return self;
}


+ (void)getDresserProductListWithLiveID:(NSString *)liveId
{
    [APPNetworkDao getURLString:[NSString stringWithFormat:@"%@?live=%@", kDresserProductURL, liveId]//@"2"]
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                              if ([array count] > 0) {
                                  for (NSDictionary *dic in array) {
                                      DresserProductModel *model  = [[DresserProductModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                      
                                  }
                                  [[NSNotificationCenter defaultCenter] postNotificationName:kDresserProductListNotification
                                                                                      object:[NSArray arrayWithArray:mutableArray]
                                                                                    userInfo:nil];
                              }
                          }];
}


@end


@implementation DresserDetailModel

- (id)init
{
    self = [super init];
    if (self) {
        _artistID = @"artist_id";
        _dresserIntro = @"intro";
        _attention = @"is_attention";
        _liveID = @"live_id";
        _liveName = @"live_name";
        _dresserLocation = @"location";
        _photoArray = @"pic";
    }
    return self;
}


+ (void)getDresserDetailWithLiveID:(NSString *)liveID block:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@?live=%@", kDresserDetailURL, liveID];
    [APPCommissionDetailDao getURLString:urlString
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       if ([dic count] > 0) {
                                           if (block) {
                                               block(dic);
                                           }
                                           
                                       }
                                       
                                   }];
}


@end



@implementation DresserLiveModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    
    self = [super init];
    
    if (self) {
        _artistID = [attributes valueForKey:@"artist_id"];
        _dresserIntro = [attributes valueForKey:@"intro"];
        _livePic = [attributes valueForKey:@"live_pic"];
        _liveID = [attributes valueForKey:@"live_id"];
        _liveName = [attributes valueForKey:@"live_name"];
        _dresserLocation = [attributes valueForKey:@"location"];
        _createTime = [attributes valueForKey:@"create_time"];
        
    }
    return self;
}





+ (void)getDresserDetailWithSellerID:(NSString *)sellerid
{
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@", kDresserLiveURL, sellerid];
    
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              
                              NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                              
                              if ([array count] > 0) {
                                  for (NSDictionary *dic in array) {
                                      DresserLiveModel *model  = [[DresserLiveModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                      
                                  }
                                  [[NSNotificationCenter defaultCenter] postNotificationName:kDresserLiveNotification
                                                                                      object:[NSArray arrayWithArray:mutableArray]
                                                                                    userInfo:nil];
                                  
                              }
                              
                          }];
    
}



@end