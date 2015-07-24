//
//  ReciveAdressModel.h
//  Love
//
//  Created by use on 14-12-3.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//收货地址管理

#import <Foundation/Foundation.h>
extern NSString * const kReciveAddressNotificationName;
extern NSString * const kSettingDefaultAddressNotificationName;
extern NSString * const kDeleteAddressNotificationName;
@interface ReciveAdressModel : NSObject

@property (nonatomic ,strong) NSString *reciveaddrId;//地址id
@property (nonatomic ,strong) NSString *address;//地址全程
@property (nonatomic ,strong) NSString *zipcode;//邮编
@property (nonatomic ,strong) NSString *mobile;//手机号
@property (nonatomic ,strong) NSString *province;//省ID
@property (nonatomic ,strong) NSString *city;//市ID
@property (nonatomic ,strong) NSString *district;//区ID
@property (nonatomic ,strong) NSString *addr;//详细地址
@property (nonatomic ,strong) NSString *province_name;//省名
@property (nonatomic ,strong) NSString *city_name;//市名
@property (nonatomic ,strong) NSString *district_name;//区名
@property (nonatomic ,strong) NSString *consignee;//收货人名称
@property (nonatomic ,strong) NSString *code;//返回标识
@property (nonatomic ,strong) NSString *status;//分0和1，1为默认地址

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getReciveAddressDataType:(NSString *)type;

+ (void)getSetDefaultAddressDataAddress_id:(NSString *)address_id;

+ (void)getDeleteAddressDataAddress_id:(NSString *)address_id;

+ (void)payReciveAddressDataType:(NSString *)type block:(void(^)(NSString *name, NSString *phoneNumber, NSString *addressDetail, NSString *addressId))block;

@end
