//
//  UserModel.m
//  Love
//
//  Created by lee wei on 14/11/2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "UserInfoModel.h"
#import "APPCommissionDetailDao.h"
#import "APPReplayNetworkDao.h"

NSString * const kUserInfoNotificationName = @"kUserInfoNotificationName";

static NSString * const kUserInfoURL = @"Users/info";
static NSString * const kEditUserNameURL = @"UserTodo/Editname";
static NSString * const kEditRealNameURL = @"UserTodo/EditRealname";
static NSString * const kEditIntroURL = @"UserTodo/EditInto";
static NSString * const kEditUserSexURL = @"UserTodo/EditSex";
static NSString * const kEditBirthdayURL = @"UserTodo/EditBirthday";
static NSString * const kEditAddressURL = @"UserTodo/EditAddress";

@implementation UserInfoModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _userID = [attributes valueForKey:@"id"];
        _userSex = [attributes valueForKey:@"sex"];
        _userName = [attributes valueForKey:@"name"];
        _userRealName = [attributes valueForKey:@"realName"];
        _headerPath = [attributes valueForKey:@"header"];
        _userIntro = [attributes valueForKey:@"intro"];
        _userBirthday = [attributes valueForKey:@"birthday"];
        _userCity = [attributes valueForKey:@"city"];
        _userProvince = [attributes valueForKey:@"province"];
        _couponNum = [attributes valueForKey:@"coupon"];
        _rebatePrice = [attributes valueForKey:@"rebate"];
        _baaiMonney = [attributes valueForKey:@"baai_monney"];
        _couponCode = [attributes valueForKey:@"coupon_code"];

    }
    return self;
}

/**
 注册
 
 @param  uid 	用户id
 */
+ (void)getUserInfoWithUserID:(NSString *)uid
{
    [APPCommissionDetailDao getURLString:[NSString stringWithFormat:@"%@?id=%@", kUserInfoURL, uid]
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                       UserInfoModel *model = [[UserInfoModel alloc] initWithAttributes:dic];
                                       [mutableArray addObject:model];
                                       [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoNotificationName
                                                                                           object:[NSArray arrayWithArray:mutableArray]];
                                   }];
}

/**
 用户名
 
 @param  userName 	用户名
 */
+ (void)eidtUserName:(NSString *)userName block:(void(^)(int code))block
{
    NSDictionary *dic = @{@"name": userName};
    [APPReplayNetworkDao postURLString:kEditUserNameURL
                            parameters:dic
                                 block:^(int code, NSString *msg) {
                                     block(code);
                                 }];
}

/**
 真实姓名
 
 @param  realName 	真实姓名
 */
+ (void)eidtRealName:(NSString *)realName
{
    NSDictionary *dic = @{@"real_name": realName};
    [APPReplayNetworkDao postURLString:kEditRealNameURL
                            parameters:dic
                                 block:^(int code, NSString *msg) {
                                     
                                 }];
}

/**
 个性签名
 
 @param  intro 	intro
 */
+ (void)eidtUserIntro:(NSString *)intro block:(void(^)(int code))block
{
    NSDictionary *dic = @{@"intro": intro};
    [APPReplayNetworkDao postURLString:kEditIntroURL
                            parameters:dic
                                 block:^(int code, NSString *msg) {
                                     block(code);
                                 }];
}

/**
 性别
 
 @param  sex 	性别
 */
+ (void)eidtUserSex:(NSString *)sex block:(void (^)(int))block
{
    NSDictionary *dic = @{@"sex": sex};
    [APPReplayNetworkDao postURLString:kEditUserSexURL
                            parameters:dic
                                 block:^(int code, NSString *msg) {
                                     block(code);
                                 }];
}

/**
 生日
 
 @param  birthday 	生日
 */
+ (void)eidtBirthday:(NSString *)birthday block:(void(^)(int code))block
{
    NSDictionary *dic = @{@"birthday": birthday};
    [APPReplayNetworkDao postURLString:kEditBirthdayURL
                            parameters:dic
                                 block:^(int code, NSString *msg) {
                                     if (block) {
                                         block(code);
                                     }
                                 }];
}

/**
 地址
 
 @param  province 	省 city 市
 */
+ (void)eidtAddressProvince:(NSString*)province andCity:(NSString*)city block:(void(^)(int code))block{
    NSDictionary *dic = @{@"province": province,@"city": city};
    [APPReplayNetworkDao postURLString:kEditAddressURL
                            parameters:dic
                                 block:^(int code, NSString *msg) {
                                     if (block) {
                                         block(code);
                                     }
                                 }];
}


@end
