//
//  LOVThirdLogin.m
//  HaitaoLogin
//
//  Created by wang xiaoliang on 14/11/30.
//  Copyright (c) 2014年 wang xiaoliang. All rights reserved.
//

#import "LOVThirdLogin.h"
#import "AppDelegate.h"

#import "UserManager.h"

#import "ThirdGetUserInfo.h"
#import "ThirdLoginModel.h"


NSString * const LoginSuccessNotification = @"LoginSuccessNotification";

@interface WBBaseRequest ()
- (void)debugPrint;
@end

@interface WBBaseResponse ()
- (void)debugPrint;
@end

@implementation LOVThirdLogin

#pragma mark - init
- (instancetype)init
{
    self = [super init];
    if (self) {
        //---
        //向微信注册
        [WXApi registerApp:kWXAPP_ID withDescription:@"weixin"];
        
        //---微博
        [WeiboSDK enableDebugMode:YES];
        [WeiboSDK registerApp:Sina_Weibo_App_Key];
        
        //----qq
        _permissions = @[kOPEN_PERMISSION_GET_USER_INFO,
                         kOPEN_PERMISSION_GET_SIMPLE_USER_INFO];
        

        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:Tencent_App_ID
                                                andDelegate:self];
        
    }
    return self;
}
#pragma mark - action
- (void)qqLoginAction
{
    [_tencentOAuth authorize:_permissions inSafari:NO];
    
}
- (void)qqLogoutAction
{
    [_tencentOAuth logout:self];
    NSLog(@"退出登录");
}

- (void)weixinLoginAction
{
    [AppDelegate shareInstance].isShare = NO;
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq* req =[[SendAuthReq alloc ] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"0744" ;
        //    req.openID = @"0c806938e2413ce73eef92cc3";
        [WXApi sendReq:req];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"微信登录需要安装微信客户端，请更换其他的登录方式或安装微信客户端!" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}
- (void)weixinLogoutAction
{
    
}

- (void)weiboLoginAction
{
    [AppDelegate shareInstance].isShare = NO;
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = Sina_Weibo_App_Redirect_Url;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"LOVThirdLogin",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}
- (void)weiboLogoutAction
{
    //AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    //    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"user1"];
}

- (void)alipayLoginAction
{
    
}
- (void)alipayLogoutAction
{
    
}


#pragma mark - qq 登录
/**
 * Called when the user successfully logged in.
 */
- (void)tencentDidLogin {
    // 登录成功
    NSLog(@"登录完成");
    
    if (_tencentOAuth.accessToken
        && 0 != [_tencentOAuth.accessToken length])
    {
        NSLog(@"登录完成 accessToken = %@", _tencentOAuth.accessToken);
        [UserManager saveOpenId:_tencentOAuth.openId];
        __block NSString *key = _tencentOAuth.openId;
        [ThirdGetUserInfo qqGetUserInfoWithAccessToken:_tencentOAuth.accessToken oauthConsumerKey:_tencentOAuth.appId openid:_tencentOAuth.openId block:^(NSDictionary *dic) {
            NSLog(@"%@",dic);
            NSString *name = [dic valueForKey:@"nickname"];
            NSString *sex = nil;
            if ([[dic valueForKey:@"gender"] isEqual:@"男"]) {
                sex = @"1";
            }else{
                sex = @"0";
            }
            NSString *header = [dic valueForKey:@"figureurl_qq_2"];
            [ThirdLoginModel thirdLoginWithKey:key Name:name Sex:sex Header:header block:^(int code, NSString *msg, NSString *uid, NSString *sig) {
                if (code == 1) {
                    NSLog(@"登录成功");
                    [UserManager saveSig:sig uid:uid];
                    if ([_delegate respondsToSelector:@selector(loginSuccess)]) {
                        [_delegate loginSuccess];
                    }
                }else{
                    NSLog(@"登录失败");
                }
            }];
        }];
        
    }
    else
    {
        NSLog(@"登录不成功 没有获取accesstoken");
    }
}

/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled){
        NSLog(@"用户取消登录");
    }
    else {
        NSLog(@"登录失败");
    }
    
}

/**
 * Called when the notNewWork.
 */
-(void)tencentDidNotNetWork
{
    NSLog(@"无网络连接，请设置网络");
}

/**
 * Called when the logout.
 */
-(void)tencentDidLogout
{
    NSLog(@"退出登录成功，请重新登录");
}

#pragma mark - 新浪微博
#pragma mark - 新浪微博
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        
        NSLog(@"sina weibo title = %@ \n message = %@", title, message);
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* weiboAccessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (weiboAccessToken)
        {
            NSLog(@"sina weibo accessToken = %@", weiboAccessToken);
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            NSLog(@"sina weibo userID = %@", userID);
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = NSLocalizedString(@"认证结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        
        NSString *wbtoken = [(WBAuthorizeResponse *)response accessToken];
        NSString *wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        
        
        __block NSString *onceId = wbCurrentUserID;
        [ThirdGetUserInfo sinaGetUserInfoWithAccessToken:wbtoken uid:wbCurrentUserID block:^(NSDictionary *dic) {
            NSString *header = [dic valueForKey:@"avatar_large"];
            NSString *name = [dic valueForKey:@"screen_name"];
            NSString *sex = nil;
            if ([[dic valueForKey:@"gender"] isEqual:@"m"]) {
                sex = @"1";
            }else{
                sex = @"0";
            }
            [ThirdLoginModel thirdLoginWithKey:onceId Name:name Sex:sex Header:header block:^(int code, NSString *msg, NSString *uid, NSString *sig) {
                if (code == 1) {
                    NSLog(@"登录成功");
                    [UserManager saveSig:sig uid:uid];
                    if ([_delegate respondsToSelector:@selector(loginSuccess)]) {
                        [_delegate loginSuccess];
                    }
                }else{
                    NSLog(@"登录失败");
                }
            }];
        }];
        
        NSLog(@"sina weibo title = %@ \n message = %@", title, message);
        NSLog(@"sina weibo accessToken = %@", wbtoken);
        NSLog(@"sina weibo userID = %@", wbCurrentUserID);
    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
        NSString *title = NSLocalizedString(@"支付结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        
        NSLog(@"sina weibo title = %@ \n message = %@", title, message);
    }
}


#pragma - WBHttpRequestDelegate
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"收到网络回调", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",result]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"请求异常", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",error]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}

#pragma mark - 微信 token和openid

-(void)getAccess_token
{
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXAPP_ID,kWXAPP_SECRET,[AppDelegate shareInstance].weixinCode];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 "access_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWiusJMZwzQU8kXcnT1hNs_ykAFDfDEuNp6waj-bDdepEzooL_k1vb7EQzhP8plTbD0AgR8zCRi1It3eNS7yRyd5A";
                 "expires_in" = 7200;
                 openid = oyAaTjsDx7pl4Q42O3sDzDtA7gZs;
                 "refresh_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWi2ZzH_XfVVxZbmha9oSFnKAhFsS0iyARkXCa7zPu4MqVRdwyb8J16V8cWw7oNIff0l-5F-4-GJwD8MopmjHXKiA";
                 scope = "snsapi_userinfo,snsapi_base";
                 }
                 */
                
                accessToken = [dic objectForKey:@"access_token"];
                openid = [dic objectForKey:@"openid"];
                NSLog(@"weixin accesssToken = %@ \n openId = %@", accessToken, openid);
            }
        });
    });  
}

#pragma mark - userinfo

-(void)getUserInfo
{
    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 city = Haidian;
                 country = CN;
                 headimgurl = "http://wx.qlogo.cn/mmopen/FrdAUicrPIibcpGzxuD0kjfnvc2klwzQ62a1brlWq1sjNfWREia6W8Cf8kNCbErowsSUcGSIltXTqrhQgPEibYakpl5EokGMibMPU/0";
                 language = "zh_CN";
                 nickname = "xxx";
                 openid = oyAaTjsDx7pl4xxxxxxx;
                 privilege =     (
                 );
                 province = Beijing;
                 sex = 1;
                 unionid = oyAaTjsxxxxxxQ42O3xxxxxxs;
                 }
                 */
                
//                NSString *nickname = [dic objectForKey:@"nickname"];
//                self.wxHeadImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"headimgurl"]]]];
                
            }
        });
        
    });  
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [WeiboSDK handleOpenURL:url delegate:self];
//}
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return [WeiboSDK handleOpenURL:url delegate:self ];
//}


@end
