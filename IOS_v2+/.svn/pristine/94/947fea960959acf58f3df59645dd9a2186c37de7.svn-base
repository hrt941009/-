//
//  CountryModel.m
//  Love
//
//  Created by 李伟 on 14/10/27.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CountryModel.h"
#import "APPNetworkDao.h"

NSString * const kAllCountryNotificationName = @"kAllCountryNotificationName";
static NSString * const kAllCountryURL = @"HtCountry/lists";

@implementation CountryModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _countryID = [attributes valueForKey:@"id"];
        _countryName = [attributes valueForKey:@"name"];
        _countryDecription = [attributes valueForKey:@"decription"];
        _flagPicPath = [attributes valueForKey:@"flag_pic"];
        _code = [attributes valueForKey:@"code"];
    }
    return self;
}

+ (void)getAllCountry
{
    [APPNetworkDao getURLString:kAllCountryURL
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                              for (NSDictionary *dic in array) {
                                  if ([dic count] > 0) {
                                      CountryModel *model = [[CountryModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  [[NSNotificationCenter defaultCenter] postNotificationName:kAllCountryNotificationName
                                                                                      object:[NSArray arrayWithArray:mutableArray]];
                              }
                              
                          }];
}

@end
