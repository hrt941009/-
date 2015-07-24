//
//  UserModel.h
//  Love
//
//  Created by lee wei on 14/11/2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kUserInfoNotificationName;

@interface UserInfoModel : NSObject

@property (nonatomic, strong) NSString *userID;//用户ID
@property (nonatomic, strong) NSString *userSex;//性别
@property (nonatomic, strong) NSString *userName;//昵称
@property (nonatomic, strong) NSString *userRealName;//;realName
@property (nonatomic, strong) NSString *headerPath;//头像url
@property (nonatomic, strong) NSString *userIntro;//自我介绍
@property (nonatomic, strong) NSString *userBirthday;
@property (nonatomic, strong) NSString *userCity;//city
@property (nonatomic, strong) NSString *userProvince;//
@property (nonatomic, strong) NSString *couponNum;//优惠券数量
@property (nonatomic, strong) NSString *rebatePrice;//返利价格
@property (nonatomic, strong) NSString *baaiMonney;//八爱币
@property (nonatomic, strong) NSString *couponCode;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (void)getUserInfoWithUserID:(NSString *)uid;

+ (void)eidtUserName:(NSString *)userName block:(void(^)(int code))block;
+ (void)eidtRealName:(NSString *)realName;
+ (void)eidtUserIntro:(NSString *)intro block:(void(^)(int code))block;
+ (void)eidtUserSex:(NSString *)sex block:(void(^)(int code))block;
+ (void)eidtBirthday:(NSString *)birthday block:(void(^)(int code))block;
+ (void)eidtAddressProvince:(NSString*)province andCity:(NSString*)city block:(void(^)(int code))block;
@end
