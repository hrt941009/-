//
//  CreateNewAdressModel.m
//  Love
//
//  Created by use on 14-12-4.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "CreateNewAdressModel.h"
#import "APPNetworkDao.h"
#import "APPCommissionDetailDao.h"
#import "APPReplayNetworkDao.h"

//-----获取省市区
//#define kAllAddressKey     @"ProvinceCityDistrict"

static NSString * const kCreateNewAdressURL = @"Address/getAddressFromFatherID";
static NSString * const kSetAddressURL = @"Address/setAddress";

static NSString * const kAllAdress = @"address/allAddress";
NSString * const kCreateNewAddressNotificationName = @"kCreateNewAddressNotificationName";
NSString * const kCityNotificationName = @"kCityNotificationName";
NSString * const kDistrictNotificationName = @"kDistrictNotificationName";
NSString * const KCreateNewsAddressSuccessNotificationName = @"KCreateNewsAddressSuccessNotificationName";
NSString * const kAllAddressNotificationName = @"kAllAddressNotificationName";
@implementation CreateNewAdressModel
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _provinceId = [attributes objectForKey:@"id"];
        _name = [attributes objectForKey:@"name"];
        _father_id = [attributes objectForKey:@"father_id"];
        _code = [attributes objectForKey:@"code"];
    }
    return self;
}

//+ (void)getAllProvinceDataFromFatherID:(NSString *)fatherId{
//    NSString *urlStr = [NSString stringWithFormat:@"%@?fid=%@",kCreateNewAdressURL,fatherId];
//    [APPNetworkDao getURLString:urlStr
//                     parameters:nil
//                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
//                              NSArray *resultArray = nil;
//                              if ([array count] > 0) {
//                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
//                                  for (NSDictionary *dic in array) {
//                                      CreateNewAdressModel *model = [[CreateNewAdressModel alloc] initWithAttributes:dic];
//                                      [mutableArray addObject:model];
//                                  }
//                                  resultArray = [NSArray arrayWithArray:mutableArray];
//                              }else{
//                                  resultArray = [NSArray array];
//                              }
//                            [[NSNotificationCenter defaultCenter] postNotificationName: kCreateNewAddressNotificationName object:[NSArray arrayWithArray:resultArray]];
//    }];
//}
//
//+ (void)getCityDataFromFatherID:(NSString *)fatherId{
//    NSString *urlStr = [NSString stringWithFormat:@"%@?fid=%@",kCreateNewAdressURL,fatherId];
//    [APPNetworkDao getURLString:urlStr
//                     parameters:nil
//                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
//                              NSArray *resultArray = nil;
//                              if ([array count] > 0) {
//                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
//                                  for (NSDictionary *dic in array) {
//                                      CreateNewAdressModel *model = [[CreateNewAdressModel alloc] initWithAttributes:dic];
//                                      [mutableArray addObject:model];
//                                  }
//                                  resultArray = [NSArray arrayWithArray:mutableArray];
//                              }else{
//                                  resultArray = [NSArray array];
//                              }
//                            [[NSNotificationCenter defaultCenter] postNotificationName: kCityNotificationName object:[NSArray arrayWithArray:resultArray]];
//                          }];
//}
//
//+ (void)getDistrictDataFromFatherID:(NSString *)fatherId{
//    NSString *urlStr = [NSString stringWithFormat:@"%@?fid=%@",kCreateNewAdressURL,fatherId];
//    [APPNetworkDao getURLString:urlStr
//                     parameters:nil
//                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
//                              NSArray *resultArray = nil;
//                              if ([array count] > 0) {
//                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
//                                  for (NSDictionary *dic in array) {
//                                      CreateNewAdressModel *model = [[CreateNewAdressModel alloc] initWithAttributes:dic];
//                                      [mutableArray addObject:model];
//                                  }
//                                  resultArray = [NSArray arrayWithArray:mutableArray];
//                              }else{
//                                  resultArray = [NSArray array];
//                              }
//                            [[NSNotificationCenter defaultCenter] postNotificationName: kDistrictNotificationName object:[NSArray arrayWithArray:resultArray]];
//                          }];
//}

+ (void)getCreateNewsAddressDataPostType:(NSString *)type andProvince:(NSString *)provinceId andCity:(NSString *)cityId andDistrict:(NSString *)districtId andAddress:(NSString *)address andMobile:(NSString *)mobile andZipcode:(NSString *)zipcode andConsignee:(NSString*)consignee block:(void (^) (int code, NSString *msg))block{
    
    NSDictionary *dic = @{@"type":type, @"province":provinceId, @"city":cityId, @"district":districtId, @"addr":address, @"mobile":mobile, @"zipcode":zipcode, @"consignee":consignee};
    
    [APPReplayNetworkDao postURLString:kSetAddressURL
                            parameters:dic
                                 block:^(int code, NSString *msg) {
                                     block(code,msg);
                                 }];
    
}

+ (void)getAllProvinceAndData{
    NSString *urlStr = [NSString stringWithFormat:@"%@",kAllAdress];
    [APPNetworkDao getURLString:urlStr
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              if ([array count]>0) {
                                  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                  [userDefaults setObject:array forKey:kAllAddressKey];
                                  [[NSNotificationCenter defaultCenter] postNotificationName:kAllAddressNotificationName object:currentTime];
                                }
        
                          }];
}

@end
