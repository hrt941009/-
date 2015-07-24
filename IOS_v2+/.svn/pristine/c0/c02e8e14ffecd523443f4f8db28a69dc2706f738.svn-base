//
//  RegisterModel.h
//  Love
//
//  Created by 李伟 on 14-8-5.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  注册
//

#import <Foundation/Foundation.h>

@interface RegisterModel : NSObject

+ (void)registerForSMSWithMobile:(NSString *)mobile  block:(void(^)(NSString *msg, NSNumber *currentTime, int code))block;
+ (void)registerForSMSConfirmWithWithMobile:(NSString *)mobile code:(NSString *)code block:(void(^)(NSString *msg, int code))block;
+ (void)registerWithUserName:(NSString *)userName password:(NSString *)password mobile:(NSString *)mobile couponCode:(NSString *)couponCode block:(void(^)(NSString *msg, int code))block;

+ (void)againChangePassword:(NSString *)mobile block:(void(^)(NSString *msg, NSNumber *currentTime, int code))block;
+ (void)againChangePAsswordWithMobile:(NSString *)mobile code:(NSString *)code block:(void(^)(NSString *msg, int code))block;
+ (void)againChangePasswordWithMobile:(NSString *)mobile confirmPwd:(NSString *)confirmPwd pwd:(NSString *)pwd block:(void(^)(NSString *msg, int code))block;

+ (void)testAndVerifyCoupon:(NSString *)couponCode block:(void(^)(NSString *msg, int code))block;

@end
