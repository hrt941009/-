//
//  ChangeAddressModel.m
//  Love
//
//  Created by use on 14-12-5.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ChangeAddressModel.h"
#import "APPCommissionDetailDao.h"
#import "APPReplayNetworkDao.h"
static NSString * const kChangeAddressURL = @"Address/setAddress";
NSString * const kChangeAddressNotificationName = @"kChangeAddressNotificationName";
@implementation ChangeAddressModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _code = [attributes objectForKey:@"code"];
        _msg = [attributes objectForKey:@"msg"];
    }
    return self;
}

+ (void)getDetailAddressType:(NSString *)type andAddressId:(NSString *)address_id andProvinceId:(NSString *)province_id andCityId:(NSString *)city_id andDistrictId:(NSString *)district_id andDetailAddr:(NSString *)addr andMobile:(NSString *)mobile andZipcode:(NSString *)zipcode andConsignee:(NSString *)consignee block:(void(^)(int code, NSString *msg))block{
//    NSString *urlStr = [NSString stringWithFormat:@"%@?type=%@&address_id=%@&province=%@&city=%@&district=%@&addr=%@&mobile=%@&zipcode=%@&consignee=%@",kChangeAddressURL,type,address_id,province_id,city_id,district_id,addr,mobile,zipcode,consignee];
//    [APPCommissionDetailDao getURLString:urlStr
//                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
//                                       NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
//                                       ChangeAddressModel *model = [[ChangeAddressModel alloc] initWithAttributes:dic];
//                                       [mutableArray addObject:model];
//                                       [[NSNotificationCenter defaultCenter] postNotificationName: kChangeAddressNotificationName object:[NSArray arrayWithArray:mutableArray]];
//    }];
    
    NSDictionary *dic  = @{@"type":type, @"address_id":address_id, @"province":province_id, @"city":city_id, @"district":district_id, @"addr":addr, @"mobile":mobile, @"zipcode":zipcode, @"consignee":consignee};
    [APPReplayNetworkDao postURLString:kChangeAddressURL parameters:dic block:^(int code, NSString *msg) {
        block(code,msg);
    }];
    
}

@end
