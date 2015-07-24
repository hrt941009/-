//
//  FollowModel.m
//  Love
//
//  Created by lee wei on 14-9-24.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "FollowModel.h"
#import "APPLoginNetworkDao.h"
#import "UserManager.h"
#import "APPNetworkDao.h"

NSString * const kFollowMasterNotificationName = @"kFollowMasterNotificationName";
NSString * const kFollowSubjectNotificationName = @"kFollowSubjectNotificationName";
NSString * const kFollowBrandNotificationName = @"kFollowBrandNotificationName";
NSString * const kFollowDresserNotificationName = @"kFollowDresserNotificationName";
NSString * const kFollowShopNotificationName = @"kFollowShopNotificationName";
NSString * const kFollowLiveNotificationName = @"kFollowLiveNotificationName";

static NSString * const kFollowSubjectURL = @"Attend/albumList";
static NSString * const kFollowBrandURL = @"Attend/brandList";
static NSString * const kFollowDresserURL = @"Attend/artistList";
static NSString * const kFollowShopURL = @"Attend/shopList";
static NSString * const kFollowLiveURL = @"Attend/artistLiveList";
static NSString * const kFollowMasterURL = @"Attend/masterList";

@implementation FollowMasterModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _mheader = [attributes valueForKey:@"header"];
        _mName = [attributes valueForKey:@"name"];
        _mIntro = [attributes valueForKey:@"intro"];
        _mLocation = [attributes valueForKey:@"location"];
        _mid = [attributes valueForKey:@"user_id"];
    }
    return self;
}

+ (void)getFollowMasterWithP:(NSString *)p pnum:(NSString *)pnum{
    NSString *urlStr = [NSString stringWithFormat:@"%@?p=%@&pnum=%@",kFollowMasterURL,p,pnum];
    [APPNetworkDao getURLString:urlStr parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
        NSArray *resultArray = nil;
        if ([array count] > 0) {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                FollowMasterModel *model = [[FollowMasterModel alloc] initWithAttributes:dic];
                [mutableArray addObject:model];
            }
            resultArray = [NSArray arrayWithArray:mutableArray];
        }else{
            resultArray = [NSArray array];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kFollowMasterNotificationName
                                                            object:resultArray
                                                          userInfo:nil];
    }];
}

@end


@implementation FollowSubjectModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _sid = [attributes valueForKey:@"id"];
        _albumName = [attributes valueForKey:@"album_name"];
        _subjectDesc = [attributes valueForKey:@"description"];
        _thumbPath = [attributes valueForKey:@"thumb"];
        _userId = [attributes valueForKey:@"user_id"];
        _userName = [attributes valueForKey:@"user_name"];
        _interestNum  = [attributes valueForKey:@"interest_num"];
        _reviewNum = [attributes valueForKey:@"review_num"];
    }
    return self;
}

/** 关注专辑
 
 @param   p 	页码
 @param   pnum 	每页条数
 @param   sig 	登录后获取
 @param   uid 	登录后获取
 
 @return  block
 */
+ (void)getFollowSubjectWithP:(NSString *)p pnum:(NSString *)pnum
{
//    NSDictionary *parameter = @{@"p": p, @"pnum": pnum, @"sig":sig, @"uid":uid};

    NSString *sig = [UserManager readSig];
    NSString *uid = [UserManager readUid];

    
    NSString *urlString = [NSString stringWithFormat:@"%@?p=%@&pnum=%@&sig=%@&uid=%@", kFollowSubjectURL,p, pnum, sig, uid];
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      FollowSubjectModel *model = [[FollowSubjectModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                              [[NSNotificationCenter defaultCenter] postNotificationName:kFollowSubjectNotificationName
                                                                                  object:resultArray
                                                                                userInfo:nil];
                          }];
}


@end


@implementation FollowBrandModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _bid = [attributes valueForKey:@"id"];
        _brandName = [attributes valueForKey:@"name"];
        _brandIntro = [attributes valueForKey:@"intro"];
        _brandNation = [attributes valueForKey:@"nation"];
        _brandOperation = [attributes valueForKey:@"operation"];
        _thumbPath = [attributes valueForKey:@"thumb"];
    }
    return self;
}

/** 关注品牌
 
 @param   p 	页码
 @param   pnum 	每页条数
 @param   sig 	登录后获取
 @param   uid 	登录后获取
 
 @return  block
 */
+ (void)getFollowBrandtWithP:(NSString *)p pnum:(NSString *)pnum
{
    NSString *sig = [UserManager readSig];
    NSString *uid = [UserManager readUid];
    
    NSString *urlString = [NSString stringWithFormat:@"%@?p=%@&pnum=%@&sig=%@&uid=%@", kFollowBrandURL,p, pnum, sig, uid];
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      FollowBrandModel *model = [[FollowBrandModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                              [[NSNotificationCenter defaultCenter] postNotificationName:kFollowBrandNotificationName
                                                                                  object:resultArray
                                                                                userInfo:nil];
                          }];
}

@end

@implementation FollowDresserModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _sellerId = [attributes valueForKey:@"artist_id"];
        _dresserName = [attributes valueForKey:@"name"];
        _dresserIntro = [attributes valueForKey:@"intro"];
        _dresesrLocation = [attributes valueForKey:@"location"];
        _numAtt = [attributes valueForKey:@"num_att"];
        _thumbPath = [attributes valueForKey:@"thumb"];
        _numProduct = [attributes valueForKey:@"num_product"];
        _dresserStar = [attributes valueForKey:@"star"];
    }
    return self;
}

/** 关注美妆师
 
 @param   p 	页码
 @param   pnum 	每页条数
 @param   sig 	登录后获取
 @param   uid 	登录后获取
 
 @return  block
 */
+ (void)getFollowDresserWithPage:(NSString *)p pageNum:(NSString *)pnum
{
    NSString *sig = [UserManager readSig];
    NSString *uid = [UserManager readUid];
    
    NSString *urlString = [NSString stringWithFormat:@"%@?p=%@&pnum=%@&sig=%@&uid=%@", kFollowDresserURL,p, pnum, sig, uid];
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      FollowDresserModel *model = [[FollowDresserModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                              [[NSNotificationCenter defaultCenter] postNotificationName:kFollowDresserNotificationName
                                                                                  object:resultArray
                                                                                userInfo:nil];
                          }];
}

@end

@implementation FollowLiveModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _liveId = [attributes valueForKey:@"live_id"];
        _liveName = [attributes valueForKey:@"live_name"];
        _liveLocation = [attributes valueForKey:@"location"];
        _thumbPath = [attributes valueForKey:@"thumb"];
        _artistId = [attributes valueForKey:@"artist_id"];
        _artistName = [attributes valueForKey:@"artist_name"];
        _headerPath = [attributes valueForKey:@"header"];
        _star = [attributes valueForKey:@"star"];
        _love = [attributes valueForKey:@"love"];
        _discuss = [attributes valueForKey:@"discuss"];
        _createTime = [attributes valueForKey:@"create_time"];
    }
    return self;
}

/** 关注直播
 
 @param   p 	页码
 @param   pnum 	每页条数
 @param   sig 	登录后获取
 @param   uid 	登录后获取
 
 @return  block
 */
+ (void)getFollowLiveWithPage:(NSString *)p pageNum:(NSString *)pnum
{
    NSString *sig = [UserManager readSig];
    NSString *uid = [UserManager readUid];
    
    NSString *urlString = [NSString stringWithFormat:@"%@?p=%@&pnum=%@&sig=%@&uid=%@", kFollowLiveURL,p, pnum, sig, uid];
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      FollowLiveModel *model = [[FollowLiveModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                              [[NSNotificationCenter defaultCenter] postNotificationName:kFollowLiveNotificationName
                                                                                  object:resultArray
                                                                                userInfo:nil];
                          }];
}

@end

/** 关注店铺
 
 @param   p 	页码
 @param   pnum 	每页条数
 @param   sig 	登录后获取
 @param   uid 	登录后获取
 
 @return  block
 */
@implementation FollowShopModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    if (self) {
        _shopId = [attributes valueForKey:@"id"];
        _userId = [attributes valueForKey:@"user_id"];
        _shopName = [attributes valueForKey:@"shop_name"];
        _shopLogo = [attributes valueForKey:@"shop_logo"];
        _shopType = [attributes valueForKey:@"shop_type"];
        _shopCat = [attributes valueForKey:@"shop_cat"];
        _shopRegion = [attributes valueForKey:@"shop_region"];
        _shopAddress = [attributes valueForKey:@"shop_address"];
        _shopPostcode = [attributes valueForKey:@"shop_postcode"];
        _shopMobile = [attributes valueForKey:@"shop_mobile"];
        _shopIntro = [attributes valueForKey:@"shop_intro"];
        _shopDetail = [attributes valueForKey:@"shop_detail"];
        _shopOperateType = [attributes valueForKey:@"shop_operate_type"];
        _goodsResource = [attributes valueForKey:@"goods_resource"];
        _isStore = [attributes valueForKey:@"is_store"];
        _isFactory = [attributes valueForKey:@"is_factory"];
        _createTime = [attributes valueForKey:@"create_time"];
        _createName = [attributes valueForKey:@"create_name"];
        _updateTime = [attributes valueForKey:@"update_time"];
        _updateName = [attributes valueForKey:@"update_name"];
        _shopState = [attributes valueForKey:@"state"];
        _deletedInfo = [attributes valueForKey:@"deleted"];
        _shopBigLogo = [attributes valueForKey:@"shop_big_logo"];
        _brandInfo = [attributes valueForKey:@"brand"];
        _currencyInfo = [attributes valueForKey:@"currency"];
        _isOwn = [attributes valueForKey:@"is_own"];
    }
    return self;
}

+ (void)getFollowShopWithPage:(NSString *)p pnum:(NSString *)pnum
{
    NSString *sig = [UserManager readSig];
    NSString *uid = [UserManager readUid];
    
    NSString *urlString = [NSString stringWithFormat:@"%@?p=%@&pnum=%@&sig=%@&uid=%@", kFollowShopURL,p, pnum, sig, uid];
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (int i = 0; i < [array count]; i++) {
                                      id object = array[i];
                                      if ([object isKindOfClass:[NSDictionary class]]) {
                                          FollowShopModel *model = [[FollowShopModel alloc] initWithAttributes:object];
                                          [mutableArray addObject:model];
                                      }
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                              [[NSNotificationCenter defaultCenter] postNotificationName:kFollowShopNotificationName
                                                                                  object:resultArray
                                                                                userInfo:nil];
                          }];
}

@end

//--------------------
@implementation FollowModel

@end
