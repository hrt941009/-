//
//  CreateNewAdressModel.h
//  Love
//
//  Created by use on 14-12-4.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//创建新地址

#import <Foundation/Foundation.h>
extern NSString * const kCreateNewAddressNotificationName;
extern NSString * const kCityNotificationName;
extern NSString * const kDistrictNotificationName;
extern NSString * const KCreateNewsAddressSuccessNotificationName;
extern NSString * const kAllAddressNotificationName;

@interface CreateNewAdressModel : NSObject
@property (nonatomic ,strong) NSString *provinceId;//根据此ID获取下一级城市，（0为获取所有省）
@property (nonatomic ,strong) NSString *father_id;//该城市的ID
@property (nonatomic ,strong) NSString *name;//该城市名称
@property (nonatomic ,strong) NSString *code;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

//+ (void)getAllProvinceDataFromFatherID:(NSString *)fatherId;

//+ (void)getCityDataFromFatherID:(NSString *)fatherId;

//+ (void)getDistrictDataFromFatherID:(NSString *)fatherId;

+ (void)getCreateNewsAddressDataPostType:(NSString *)type andProvince:(NSString *)provinceId andCity:(NSString *)cityId andDistrict:(NSString *)districtId andAddress:(NSString *)address andMobile:(NSString *)mobile andZipcode:(NSString *)zipcode andConsignee:(NSString*)consignee block:(void (^) (int code, NSString *msg))block;

+ (void)getAllProvinceAndData;

@end
