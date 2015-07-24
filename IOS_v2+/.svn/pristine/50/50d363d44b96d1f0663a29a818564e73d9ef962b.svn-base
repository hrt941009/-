//
//  ChangeAddressModel.h
//  Love
//
//  Created by use on 14-12-5.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//修改收货地址

#import <Foundation/Foundation.h>
extern NSString * const kChangeAddressNotificationName;
@interface ChangeAddressModel : NSObject

@property (nonatomic ,strong) NSString *code;
@property (nonatomic ,strong) NSString *msg;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getDetailAddressType:(NSString *)type andAddressId:(NSString *)address_id andProvinceId:(NSString *)province_id andCityId:(NSString *)city_id andDistrictId:(NSString *)district_id andDetailAddr:(NSString *)addr andMobile:(NSString *)mobile andZipcode:(NSString *)zipcode andConsignee:(NSString *)consignee block:(void(^)(int code, NSString *msg))block;

@end
