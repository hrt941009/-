//
//  CommissionModel.m
//  Love
//
//  Created by lee wei on 14-9-19.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CommissionModel.h"
#import "APPNetworkDao.h"

static NSString * const kSearchURL = @"Search/show";
static NSString *const kCommissionHomePageURL = @"FlItem/lists";
static NSString * const kTagProductURL = @"tagProduct/taglist";
static NSString * const kProductListURL = @"tagProduct/productlist";
static NSString * const kShareProductListURL = @"IndexShare/shareproduct";

NSString * const kRebateKey = @"rebate";
NSString * const kCouponKey = @"coupon";
NSString * const kDiscussKey = @"discuss";
NSString * const kLoveKey = @"love";
NSString * const kHotKey = @"hot";

NSString * const kCommissionKeyNotificationName = @"kCommissionKeyNotificationName";
NSString * const kSearchNoticefationName = @"kSearchNoticefationName";
NSString * const kTagProductNotificationName = @"kTagProductNotificationName";
NSString * const kProductListDataNotificationName = @"kProductListDataNotificationName";

@implementation CommissionModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _cid = [attributes valueForKey:@"id"];
        _cDetail = [attributes valueForKey:@"name"];
        _thumb = [attributes valueForKey:@"thumb"];
        _originalPrice = [attributes valueForKey:@"original_price"];
        _price = [attributes valueForKey:@"price"];
        _save = [attributes valueForKey:@"save"];
        _discuss = [attributes valueForKey:@"discuss"];
        _love = [attributes valueForKey:@"love"];
        _isRebate = [attributes valueForKey:@"is_rebate"];
        _rebate = [attributes valueForKey:@"rebate"];
        _hasCoupon = [attributes valueForKey:@"has_coupon"];
        _hasDiscount = [attributes valueForKey:@"has_discount"];
        _discount = [attributes valueForKey:@"discount"];
        _sales = [attributes valueForKey:@"sales"];
        _brandName = [attributes valueForKey:@"brand_name"];
        
        _tagId = [attributes valueForKey:@"id"];
        _tagName = [attributes valueForKey:@"name"];
        _tagIntro = [attributes valueForKey:@"intro"];
        
        _productId = [attributes valueForKey:@"id"];
        _productName = [attributes valueForKey:@"product_name"];
        _markedPrice = [attributes valueForKey:@"marked_price"];
        _loveNum = [attributes valueForKey:@"love_number"];
        _effect = [attributes valueForKey:@"effect"];
        _myTagId = [attributes valueForKey:@"tag_id"];
        
        _shareName = [attributes valueForKey:@"name"];
        _shareIntro = [attributes valueForKey:@"intro"];
        _shareTag = [attributes valueForKey:@"tag_name"];
        _shareTagId = [attributes valueForKey:@"tag_id"];
    }
    return self;
}

/**
 首页分类浏览/侧边栏按实际排序
 
 @param   time 	时间选择分别为 day week month；首页浏览默认时间=day
 @param   key 	顶部tab: rebate：返利；coupon：优惠券；discuss：有评论；love：大家喜欢；hot：热卖
 @param   p 	页码
 @param   pnum 	每页条数
 
 @return  block
 */
+ (void)getHomePageDataWithTime:(NSString *)time
                            key:(NSString *)key
                              p:(NSString *)p
                           pnum:(NSString *)pnum
{
    NSString *urlString = [NSString stringWithFormat:@"%@?time=%@&key=%@&p=%@&pnum=%@", kCommissionHomePageURL, time, key, p, pnum];
    [APPNetworkDao getURLString:urlString
                     parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                         NSArray *resultArray = nil;
                         if ([array count] > 0) {
                             NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                             for (NSDictionary *dic in array) {
                                 CommissionModel *model = [[CommissionModel alloc] initWithAttributes:dic];
                                 [mutableArray addObject:model];
                             }
                             resultArray = [NSArray arrayWithArray:mutableArray];
                         }else{
                             resultArray = [NSArray array];
                         }
                         [[NSNotificationCenter defaultCenter] postNotificationName:kCommissionKeyNotificationName
                                                                             object:resultArray
                                                                           userInfo:nil];
                     }];
}

/**
 首页侧边栏按类别排序
 
 @param   type 	类别
 @param   key 	顶部tab: rebate：有返利；coupon：又优惠券；discuss：有评论；love：大家喜欢；hot：热卖
 @param   p 	页码
 @param   pnum 	每页条数
 
 @return  block
 */
+ (void)getCatagoryDataWithType:(NSString *)type
                            key:(NSString *)key
                              p:(NSString *)p
                           pnum:(NSString *)pnum
{
    NSString *urlString = [NSString stringWithFormat:@"%@?type=%@&key=%@&p=%@&pnum=%@", kCommissionHomePageURL, type, key, p, pnum];
    [APPNetworkDao getURLString:urlString
                     parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                         NSArray *resultArray = nil;
                         if ([array count] > 0) {
                             NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                             for (NSDictionary *dic in array) {
                                 CommissionModel *model = [[CommissionModel alloc] initWithAttributes:dic];
                                 [mutableArray addObject:model];
                             }
                             resultArray = [NSArray arrayWithArray:mutableArray];
                         }else{
                             resultArray = [NSArray array];
                         }
                         [[NSNotificationCenter defaultCenter] postNotificationName:kCommissionKeyNotificationName
                                                                             object:resultArray
                                                                           userInfo:nil];
                     }];
}

+ (void)getSearchDataWithKeyword:(NSString *)keyword page:(NSString *)page pageNumber:(NSString *)pnum{
    NSString *url = [NSString stringWithFormat:@"%@",kSearchURL];
    NSDictionary *parameters = @{@"keyword":keyword,@"p":page,@"pnum":pnum};
    [APPNetworkDao getURLString:url parameters:parameters block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
        NSArray *resultArray = nil;
        if ([array count] > 0) {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                CommissionModel *model = [[CommissionModel alloc] initWithAttributes:dic];
                [mutableArray addObject:model];
            }
            resultArray = [NSArray arrayWithArray:mutableArray];
        }else{
            resultArray = [NSArray array];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kSearchNoticefationName
                                                            object:resultArray
                                                          userInfo:nil];
    }];
}

+ (void)getProductMainDataWithKey:(NSString *)key
                             Page:(NSString *)page
                             pnum:(NSString *)pnum{
    NSString *urlStr;
    if (key == kRebateKey) {
        urlStr = [NSString stringWithFormat:@"%@?p=%@&pnum=%@",kTagProductURL,page,pnum];
    }
    if (key == kDiscussKey) {
        urlStr = [NSString stringWithFormat:@"%@?p=%@&pnum=%@",kShareProductListURL,page,pnum];
    }
    [APPNetworkDao getURLString:urlStr  parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
            NSArray *resultArray = nil;
            if ([array count] > 0) {
                NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in array) {
                    CommissionModel *model = [[CommissionModel alloc] initWithAttributes:dic];
                    [mutableArray addObject:model];
                }
                resultArray = [NSArray arrayWithArray:mutableArray];
            }else{
                resultArray = [NSArray array];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kTagProductNotificationName
                                                            object:resultArray
                                                          userInfo:nil];
    }];
}

+ (void)getProductListDataWithPage:(NSString *)page
                              pnum:(NSString *)pnum
                             tagId:(NSString *)tagId{
    NSString *urlStr = [NSString stringWithFormat:@"%@?p=%@&pnum=%@&tag_id=%@",kProductListURL,page,pnum,tagId];
    [APPNetworkDao getURLString:urlStr  parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
        NSArray *resultArray = nil;
        if ([array count] > 0) {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                CommissionModel *model = [[CommissionModel alloc] initWithAttributes:dic];
                [mutableArray addObject:model];
            }
            resultArray = [NSArray arrayWithArray:mutableArray];
        }else{
            resultArray = [NSArray array];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kProductListDataNotificationName
                                                            object:resultArray
                                                          userInfo:nil];
    }];
    
}

@end
