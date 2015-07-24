//
//  LOVThirdLogin.h
//  HaitaoLogin
//
//  Created by wang xiaoliang on 14/11/30.
//  Copyright (c) 2014年 wang xiaoliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LOVThirdLoginConfig.h"

@protocol LoginSuccessDelegate <NSObject>

- (void)loginSuccess;

@end

@interface LOVThirdLogin : NSObject<TencentSessionDelegate, WBHttpRequestDelegate>
{
    TencentOAuth* _tencentOAuth;
    
    NSArray* _permissions;
    
    NSString *accessToken;
    NSString *openid;
}

@property (nonatomic, weak) id<LoginSuccessDelegate>delegate;

- (instancetype)init;


- (void)qqLoginAction;
- (void)weixinLoginAction;
- (void)weiboLoginAction;
- (void)alipayLoginAction;

- (void)qqLogoutAction;
- (void)weixinLogoutAction;
- (void)weiboLogoutAction;
- (void)alipayLogoutAction;


@end
