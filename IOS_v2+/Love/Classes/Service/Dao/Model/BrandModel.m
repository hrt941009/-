//
//  BrandModel.m
//  Love
//
//  Created by lee wei on 14/12/4.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//


#import "BrandModel.h"
#import "APPNetworkDao.h"
#import "APPCommissionDetailDao.h"

NSString * const kBrandProductListNoticefationName = @"kBrandProductListNoticefationName";

static NSString * const kBrandInfoURL = @"brand/info?brand";
static NSString * const kBrandProductList = @"brand/itemList?brand";


@implementation BrandModel

- (instancetype)initWithAttributtes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _commentNum = [attributes valueForKey:@"discuss"];
        _introString = [attributes valueForKey:@"intro"];
        _loveNum = [attributes valueForKey:@"love"];
        _productPrice = [attributes valueForKey:@"price"];
        _productId = [attributes valueForKey:@"product_id"];
        _productName = [attributes valueForKey:@"product_name"];
        _saveNum = [attributes valueForKey:@"save"];
        _thumbPath = [attributes valueForKey:@"thumb"];
    }
    return self;
}

+ (void)getBrandInfoWithID:(NSString *)bid block:(void(^)(NSString *fansNum,
                                                          NSString *brandID,
                                                          NSString *intro,
                                                          NSString *brandName,
                                                          NSString *productNum,
                                                          NSString *thumbPath))block
{
    [APPCommissionDetailDao getURLString:[NSString stringWithFormat:@"%@=%@", kBrandInfoURL, bid]
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       NSString *fansNumber = [dic objectForKey:@"fans_num"];
                                       NSString *brandID = [dic objectForKey:@"id"];
                                       NSString *introString = [dic objectForKey:@"intro"];
                                       NSString *brandName = [dic objectForKey:@"name"];
                                       NSString *productNumber = [dic objectForKey:@"product_num"];
                                       NSString *thumbPath = [dic objectForKey:@"thumb"];
                                       
                                       if (block) {
                                           block(fansNumber, brandID, introString, brandName, productNumber, thumbPath);
                                       }
                                   }];
}

+ (void)getBrandProductListWithID:(NSString *)bid page:(NSString *)page pageNumber:(NSString *)pageNumber
{
    NSString *urlString = [NSString stringWithFormat:@"%@=%@&p=%@&pnum=%@", kBrandProductList, bid, page, pageNumber];
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                              if ([array count] > 0) {
                                  for (NSDictionary *dic in array) {
                                      BrandModel *bmodel = [[BrandModel alloc] initWithAttributtes:dic];
                                      [mutableArray addObject:bmodel];
                                  }
                              }
                              [[NSNotificationCenter defaultCenter] postNotificationName:kBrandProductListNoticefationName object:[NSArray arrayWithArray:mutableArray]];
                          }];
}

@end
