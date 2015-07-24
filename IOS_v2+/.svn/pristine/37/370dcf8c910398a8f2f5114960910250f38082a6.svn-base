//
//  ReciveAdressModel.m
//  Love
//
//  Created by use on 14-12-3.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ReciveAdressModel.h"
#import "APPNetworkDao.h"
#import "APPCommissionDetailDao.h"
#import "APPNetworkClient.h"

static NSString * const kReciveAddressURL = @"Address/getAddress";
static NSString * const kSetDefaultAdressURL = @"Address/setDefaultAdress";
static NSString * const kDeleteAddressURL = @"Address/delAdress";

NSString * const kReciveAddressNotificationName = @"kReciveAddressNotificationName";
NSString * const kSettingDefaultAddressNotificationName = @"kSettingDefaultAddressNotificationName";
NSString * const kDeleteAddressNotificationName = @"kDeleteAddressNotificationName";
@implementation ReciveAdressModel
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _reciveaddrId = [attributes objectForKey:@"id"];
        _address = [attributes objectForKey:@"address"];
        _zipcode = [attributes objectForKey:@"zipcode"];
        _mobile = [attributes objectForKey:@"mobile"];
        _province = [attributes objectForKey:@"province"];
        _city = [attributes objectForKey:@"city"];
        _district = [attributes objectForKey:@"district"];
        _addr = [attributes objectForKey:@"addr"];
        _province_name = [attributes objectForKey:@"province_name"];
        _city_name = [attributes objectForKey:@"city_name"];
        _district_name = [attributes objectForKey:@"district_name"];
        _consignee = [attributes objectForKey:@"consignee"];
        _code = [attributes objectForKey:@"code"];
        _status = [attributes objectForKey:@"status"];
    }
    return self;
}

+ (void)getReciveAddressDataType:(NSString *)type{
    NSString *urlStr = [NSString stringWithFormat:@"%@?type=%@",kReciveAddressURL,type];
    NSString *string = [NSString stringWithFormat:@"%@%@", kAPPNetworkURLHeader, urlStr];
    [[APPNetworkClient sharedClient] GET:string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *resultArray = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = [responseObject objectForKey:@"result"];
            NSString *code = [dic objectForKey:@"code"];
            if ([code integerValue] == 1) {
                NSArray *array = [dic objectForKey:@"data"];
                if ([array count]>0) {
                    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                    for (NSDictionary *dic in array) {
                        ReciveAdressModel *model = [[ReciveAdressModel alloc] initWithAttributes:dic];
                        [mutableArray addObject:model];
                    }
                    resultArray = [NSArray arrayWithArray:mutableArray];
                }else{
                    resultArray = [NSArray array];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName: kReciveAddressNotificationName object:[NSArray arrayWithArray:resultArray]];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName: kReciveAddressNotificationName object:[NSArray arrayWithArray:resultArray]];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@", error);
        if([error code] == NSURLErrorCancelled)
        {
            //[SVProgressHUD dismiss];
            
            return [[[APPNetworkClient sharedClient] operationQueue] cancelAllOperations];
        }
    }];
    
    
}

+ (void)getSetDefaultAddressDataAddress_id:(NSString *)address_id{
    NSString *urlStr = [NSString stringWithFormat:@"%@?address_id=%@",kSetDefaultAdressURL,address_id];
    [APPCommissionDetailDao getURLString:urlStr
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       NSString *code = [dic objectForKey:@"code"];
                                       [[NSNotificationCenter defaultCenter] postNotificationName: kSettingDefaultAddressNotificationName object:code];
    }];
}

+ (void)getDeleteAddressDataAddress_id:(NSString *)address_id{
    NSString *urlStr = [NSString stringWithFormat:@"%@?address_id=%@",kDeleteAddressURL,address_id];
    [APPCommissionDetailDao getURLString:urlStr
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       NSString *code = [dic objectForKey:@"code"];
                                       [[NSNotificationCenter defaultCenter] postNotificationName: kDeleteAddressNotificationName object:code];
                                   }];
}

+ (void)payReciveAddressDataType:(NSString *)type block:(void(^)(NSString *name, NSString *phoneNumber, NSString *addressDetail, NSString *addressId))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@?type=%@",kReciveAddressURL,type];
//    [APPNetworkDao getURLString:urlStr
//                     parameters:nil
//                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
//                              NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
//                              for (NSDictionary *dic in array) {
//                                  ReciveAdressModel *model = [[ReciveAdressModel alloc] initWithAttributes:dic];
//                                  [mutableArray addObject:model];
//                              }
//                              
//                          }];
    [APPCommissionDetailDao getURLString:urlStr block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
        int code = [[dic objectForKey:@"code"] intValue];
        if (code == 0) {
            NSString *name = nil;
            NSString *phonenNumber = nil;
            NSString *address = nil;
            NSString *addressId = nil;
            if (block) {
                block(name, phonenNumber, address, addressId);
            }
        }else{
            NSDictionary *resultDic = [dic objectForKey:@"data"];
            ReciveAdressModel *model = [[ReciveAdressModel alloc] initWithAttributes:resultDic];
            NSString *name = model.consignee;
            NSString *phonenNumber = model.mobile;
            NSString *address = model.address;
            NSString *addressId = model.reciveaddrId;
            if (block) {
                block(name, phonenNumber, address, addressId);
            }
        }
        
    }];

}

@end
