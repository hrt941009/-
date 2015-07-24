//
//  LoginModel.m
//  Love
//
//  Created by 李伟 on 14/10/29.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "LoginModel.h"
#import "APPLoginNetworkDao.h"
#import "APPCommissionDetailDao.h"
#import "UserManager.h"

static NSString * const kLoginURL  = @"Users/login";
static NSString * const kLogoutURL  = @"Users/loginOut";

@implementation LoginModel

//测试用户名18888888888 密码123456
+ (void)loginAppWithName:(NSString *)name password:(NSString *)pwd block:(void(^)(int code, NSDictionary *dic))block
{
    [APPLoginNetworkDao postLoginURLString:[NSString stringWithFormat:@"%@?name=%@&pwd=%@", kLoginURL, name, pwd]
                                parameters:nil
                                     block:^(NSDictionary *dic) {
                                         int code = [[dic objectForKey:@"code"] intValue];
                                         NSString *msg = [dic objectForKey:@"msg"];
                                         NSLog(@"code = %d, msg = %@", code, msg);
                                         block(code, dic);
                                     }];
}

+ (void)logoutMyApp
{
    [APPCommissionDetailDao getURLString:kLogoutURL
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       NSLog(@"message = %@", [dic objectForKey:@"msg"]);
                                   }];
}

@end
