//
//  RegisterModel.m
//  Love
//
//  Created by 李伟 on 14-8-5.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "RegisterModel.h"
#import "APPRegisterNetworkDao.h"
#import "SVProgressHUD.h"
#import "APPNetworkClient.h"
#import "APPReplayNetworkDao.h"

static NSString * const smsURL = @"Users/registerForSMS";
static NSString * const smsConfirmURL = @"Users/registerForSMSConfirm";
static NSString * const registerURL = @"Users/register";

static NSString * const againPwdURL = @"Users/reGetPwdrForSMS";
static NSString * const againConfirmURL = @"Users/reGetPwdForSMSConfirm";
static NSString * const againChangePwdURL = @"Users/reGetPwd";

static NSString * const verifyCouponURL = @"Users/checkCode";

@implementation RegisterModel

/**
 填写手机号
 
 @param   mobile 	手机号
 
 @return  block     msg = 请求是否成功的消息
 */
+ (void)registerForSMSWithMobile:(NSString *)mobile  block:(void(^)(NSString *msg, NSNumber *currentTime, int code))block

{
    [APPRegisterNetworkDao getURLString:[NSString stringWithFormat:@"%@?mobile=%@", smsURL, mobile]
                                  block:^(NSString *msg, NSNumber *currentTime, int status, NSError *error, int code) {
                                      if (status == 200) {
                                          NSLog(@"%@",msg);
                                          block(msg, currentTime, code);
                                      }else{
                                          [SVProgressHUD showErrorWithStatus:@"验证码发送失败"];
                                      }
                                  }];
    
}

+ (void)againChangePassword:(NSString *)mobile block:(void(^)(NSString *msg, NSNumber *currentTime, int code))block{
    [APPRegisterNetworkDao getURLString:[NSString stringWithFormat:@"%@?mobile=%@",againPwdURL,mobile] block:^(NSString *msg, NSNumber *currentTime, int status, NSError *error, int code) {
        if (status == 200) {
            NSLog(@"%@",msg);
            block(msg, currentTime,code);
        }else{
            [SVProgressHUD showErrorWithStatus:@"验证码发送失败"];
        }
    }];
}

/**
 填写验证码

 @param   mobile 	手机号
 @param   code    	验证码
 
 @return  block    msg = 请求是否成功的消息
 */
+ (void)registerForSMSConfirmWithWithMobile:(NSString *)mobile code:(NSString *)code block:(void(^)(NSString *msg, int code))block
{
    [APPRegisterNetworkDao getURLString:[NSString stringWithFormat:@"%@?mobile=%@&code=%@", smsConfirmURL, mobile, code]
                                  block:^(NSString *msg, NSNumber *currentTime, int status, NSError *error, int code) {
                                      if (status == 200) {
                                          block(msg, code);
                                      }else{
                                          [SVProgressHUD showErrorWithStatus:@"验证码验证失败"];
                                      }
                                  }];
}

+ (void)againChangePAsswordWithMobile:(NSString *)mobile code:(NSString *)code block:(void(^)(NSString *msg, int code))block{
    [APPRegisterNetworkDao getURLString:[NSString stringWithFormat:@"%@?mobile=%@&code=%@",againConfirmURL,mobile,code] block:^(NSString *msg, NSNumber *currentTime, int status, NSError *error, int code) {
        if (status == 200) {
            block(msg, code);
        }else{
            [SVProgressHUD showErrorWithStatus:@"验证码验证失败"];
        }
    }];
}

/**
 注册
 
 @param  userName 	用户名
 @param  password 	密码
 @param  mobile 	手机号
 
 @return block       msg = 请求是否成功的消息
 */
+ (void)registerWithUserName:(NSString *)userName password:(NSString *)password mobile:(NSString *)mobile couponCode:(NSString *)couponCode block:(void (^)(NSString *, int))block
{
    NSDictionary *dic = @{@"name":userName, @"pwd":password, @"mobile":mobile};
    [APPReplayNetworkDao postURLString:[NSString stringWithFormat:@"%@",registerURL] parameters:dic block:^(int code, NSString *msg) {
        block(msg,code);
    }];

}

+ (void)againChangePasswordWithMobile:(NSString *)mobile confirmPwd:(NSString *)confirmPwd pwd:(NSString *)pwd block:(void(^)(NSString *msg, int code))block{
    [APPRegisterNetworkDao getURLString:[NSString stringWithFormat:@"%@?mobile=%@&confirmPwd=%@&pwd=%@",againChangePwdURL,mobile,confirmPwd,pwd] block:^(NSString *msg, NSNumber *currentTime, int status, NSError *error, int code) {
        if (status == 200) {
            block(msg,code);
        }else{
            [SVProgressHUD showErrorWithStatus:msg];
        }
    }];
}

/**
 验证邀请码
 
 @param  couponCode 	邀请码
 
 @return block       msg = 请求是否成功的消息
 */

+ (void)testAndVerifyCoupon:(NSString *)couponCode block:(void(^)(NSString *msg, int code))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@?coupon_code=%@",verifyCouponURL,couponCode];
    [APPReplayNetworkDao postURLString:urlStr parameters:nil block:^(int code, NSString *msg) {
        if (block) {
            block(msg,code);
        }
    }];
}
- (void)dismissAlert
{
    [SVProgressHUD dismiss];
}

@end
