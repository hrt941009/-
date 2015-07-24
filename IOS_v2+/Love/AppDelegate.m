	//
//  AppDelegate.m
//  Love
//
//  Created by 李伟 on 14-6-26.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "AppDelegate.h"
#import "LOVTabBarController.h"

#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"

#import "LeftSideDrawerViewController.h"
#import "CommissionViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApi.h>

#import "AFNetworkActivityIndicatorManager.h"
#import "SVProgressHUD.h"
#import "APPNetworkClient.h"
#import "NSDate+Additions.h"

#import "AFHTTPRequestOperationManager.h"
#import "IQKeyboardManager.h"

#import "UserManager.h"
#import "LoginModel.h"
#import "ThirdLoginModel.h"
#import "ThirdGetUserInfo.h"

#import "LOVThirdLoginConfig.h"

#import "APPReleaseNoteDownload.h"

NSString *const LOVPopToRootViewControllerNotification = @"LOVPopToRootViewControllerNotification";

static NSString * const kAPPBaseHostName = @"http://m.hafung.com";

typedef NS_ENUM(NSInteger, APPDelegateAlertTag)
{
    APPDelegateAlertTagWithLoginError = 1000,
    APPDelegateAlertTagWithHaitao = 10001,
    APPDelegateAlertTagWithUpdate
};

@implementation AppDelegate

+ (AppDelegate *)shareInstance
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    Reachability *rb = [Reachability reachabilityWithHostname:@"www.baai.com"];
    NetworkStatus status = [rb currentReachabilityStatus];
    
    if (status == NotReachable) {
        UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:nil
                                                             message:MyLocalizedString(@"网络连接失败")
                                                            delegate:self
                                                   cancelButtonTitle:MyLocalizedString(@"Cancel")
                                                   otherButtonTitles:nil];
        alertView.tag = 100000;
        [alertView show];
        
    }
    //-- 设置缓存
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    //--
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(progressNotice:) name:SVProgressHUDDidReceiveTouchEventNotification object:nil];
    
    //-- 自动登录
    [self autoLoginApp];

    
    //-- 分享
    [self setShareSDK];
    
    //-- 检测版本
    //[self releaseNote];
    
    //--------
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //------
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    if ([[userDefaults objectForKey:@"first-start"] length] > 0) {
//        [userDefaults removeObjectForKey:@"first-start"];
//    }
    NSString *first = [userDefaults objectForKey:@"first-start"];
    NSLog(@"first = %@", first);
    //如果第一次启动 显示引导界面
    if (first == NULL) {
        NSLog(@"first start");
        _guardView = [[LOVGuardView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _guardView.backgroundColor = [UIColor clearColor];
        _guardView.delegate = self;
        [self.window addSubview:_guardView];
        
    }else{
        [self setTabarViewController];
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 检测版本
- (void)releaseNote
{
    __block NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *fristRelease = [userDefaults objectForKey:@"kFirstReleaseNote"];
    if ([fristRelease length] == 0) {
        [APPReleaseNoteDownload extractReleaseNoteWithIdentifier:iTunesItemIdentifier
                                                           block:^(BOOL update, NSString *releaseNotes) {
                                                               NSLog(@"update = %d, releaseNote = %@", update, releaseNotes);
                                                               if ([releaseNotes isEqualToString:@"000"]) {
                                                                   UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:MyLocalizedString(@"检查更新失败")
                                                                                                                        message:releaseNotes
                                                                                                                       delegate:self
                                                                                                              cancelButtonTitle:MyLocalizedString(@"Cancel")
                                                                                                              otherButtonTitles:nil];
                                                                   alertView.tag = APPDelegateAlertTagWithUpdate;
                                                                   alertView.delegate = self;
                                                                   [alertView show];
                                                               } else {
                                                                   if (update == YES) {
                                                                       UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:@"有新版"
                                                                                                                            message:releaseNotes
                                                                                                                           delegate:self
                                                                                                                  cancelButtonTitle:MyLocalizedString(@"Cancel")
                                                                                                                  otherButtonTitles:MyLocalizedString(@"OK"), nil];
                                                                       alertView.tag = APPDelegateAlertTagWithUpdate;
                                                                       alertView.delegate = self;
                                                                       [alertView show];
                                                                   }
                                                                   [userDefaults setObject:@"LovFirstReleaseNote" forKey:@"kFirstReleaseNote"];
                                                               }
                                                           }];
    }
}
#pragma mark - 自动登录
- (void)autoLoginApp
{
    NSString *username = [UserManager readAccount];
    NSString *pw = [UserManager readPassword];
    NSString *sig = [UserManager readSig];
    NSString *openID = [UserManager readOpenId];
    NSLog(@"openid = %@", openID);
    

    if ([sig length] > 0) {
        if ([openID length] > 0) {
            //这里是第三方登录
            [ThirdLoginModel autoLoginWithKey:openID block:^(int code, NSString *msg, NSString *uid, NSString *sig) {
                if (code == 1) {
                    //登录成功后更新sig， uid
                    [UserManager saveSig:sig uid:uid];
                    
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                        message:@"登录失败请重新登录"
                                                                       delegate:self
                                                              cancelButtonTitle:MyLocalizedString(@"OK")
                                                              otherButtonTitles:nil];
                    alertView.delegate = self;
                    alertView.tag = APPDelegateAlertTagWithLoginError;
                    [alertView show];
                }
            }];
        }else{
            [LoginModel loginAppWithName:username
                                password:pw
                                   block:^(int code, NSDictionary *dic) {
                                       
                                       if (code == 1) {
                                           NSString *sig = [[dic objectForKey:@"sign"] objectForKey:@"sig"];
                                           NSString *uid = [[dic objectForKey:@"sign"] objectForKey:@"uid"];
                                           NSLog(@"sig = %@, uid = %@", sig, uid);
                                           
                                           //登录成功后更新sig， uid
                                           [UserManager saveSig:sig uid:uid];
                                           
                                       }else{
                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                                               message:@"登录失败请重新登录"
                                                                                              delegate:self
                                                                                     cancelButtonTitle:MyLocalizedString(@"OK")
                                                                                     otherButtonTitles:nil];
                                           alertView.delegate = self;
                                           alertView.tag = APPDelegateAlertTagWithLoginError;
                                           [alertView show];
                                       }
                                   }];
        }
    }
}

#pragma mark - 设置tabbar
- (void)setTabarViewController
{
    //UIViewController *leftSideDrawerViewController = [[LeftSideDrawerViewController alloc] init];
    LOVTabBarController *lovTabBarController = [[LOVTabBarController alloc] init];
    lovTabBarController.selectedIndex = 0;
    //_lovTabBarController = [[LOVTabBarController alloc] init];
    //UIViewController *rightSideDrawerViewController = [[HomeSearchViewController alloc] init];
    
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:lovTabBarController
                                             rightDrawerViewController:nil];
    //[drawerController setMaximumLeftDrawerWidth:kMaximumLeftDrawerWidth];
    //[drawerController setMaximumRightDrawerWidth:kMaximumRightDrawerWidth];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    //--------
    self.window.rootViewController = drawerController;
}

- (void)setShareSDK
{
    _isShare = YES;
    //--
    //参数为ShareSDK官网中添加应用后得到的AppKey
    [ShareSDK registerApp:@"5990242a20a0"];
    
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
     **/
    [ShareSDK connectSinaWeiboWithAppKey:Sina_Weibo_App_Key
                               appSecret:Sina_Weibo_App_Secret
                             redirectUri:Sina_Weibo_App_Redirect_Url
                             weiboSDKCls:[WeiboSDK class]];
    
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    [ShareSDK connectWeChatWithAppId:kWXAPP_ID wechatCls:[WXApi class]];
    
    
    /**
     连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
     http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
     **/
    [ShareSDK connectQZoneWithAppKey:Tencent_App_ID
                           appSecret:Tencent_App_Key
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/
    
    [ShareSDK connectQQWithQZoneAppKey:Tencent_App_ID
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
}

#pragma mark - LOVGuardViewDelegate
/**
 移除引导界面
 */
- (void)startApp{
    [_guardView removeFromSuperview];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"first-start-app" forKey:@"first-start"];
    NSLog(@"save = %@", [userDefaults objectForKey:@"first-start"]);
    [self setTabarViewController];
}


#pragma mark - notice
/**
 点击屏幕，取消网络链接
 
 @param  notice：接收来自SVProgressHUD的消息
  */
- (void)progressNotice:(NSNotification *)notice
{
    //有问题 如果SVProgressHUD引起crash，注销下面代码
    AFHTTPRequestOperationManager *httpManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kAPPBaseHostName]];
    [[httpManager operationQueue] cancelAllOperations];
    
    //[[[AFHTTPRequestOperationManager manager] operationQueue] cancelAllOperations];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDDidReceiveTouchEventNotification object:nil];
}

#pragma mark - UIAlertViewDelegete
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == APPDelegateAlertTagWithLoginError) {
        [UserManager restKeychain];
    }
    if (alertView.tag == APPDelegateAlertTagWithUpdate) {
        if (buttonIndex == 1) {
            NSLog(@"---- --");
            NSString *str = [NSString stringWithFormat:
                             @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",
                             @"444934666"];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }
}

#pragma mark - 腾讯登陆
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    
//    
//    return [WeiboSDK handleOpenURL:url delegate:self];//[TencentOAuth HandleOpenURL:url];
//}
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return [WeiboSDK handleOpenURL:url delegate:self];//[TencentOAuth HandleOpenURL:url];
//}


#pragma mark -
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [TencentOAuth HandleOpenURL:url]|| [WeiboSDK handleOpenURL:url delegate:self] || [WXApi handleOpenURL:url delegate:self] ||[ShareSDK handleOpenURL:url wxDelegate:self];//
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [TencentOAuth HandleOpenURL:url] || [WeiboSDK handleOpenURL:url delegate:self] || [WXApi handleOpenURL:url delegate:self] ||[ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];//
}

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
        NSString* accesstoken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accesstoken)
        {
            NSLog(@"sina weibo accessToken = %@", accesstoken);
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
        
        
        if (wbCurrentUserID) {
            [UserManager saveOpenId:wbCurrentUserID];
        }
        
        __block NSString *onceId = wbCurrentUserID;
        [ThirdGetUserInfo sinaGetUserInfoWithAccessToken:wbtoken uid:wbCurrentUserID block:^(NSDictionary *dic) {
            NSString *header = nil;
            NSString *name = nil;
            NSString *sex = nil;
            if ([dic valueForKey:@"error"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"登录失败，请重试!") delegate:self cancelButtonTitle:MyLocalizedString(@"确定") otherButtonTitles:nil, nil];
                [alertView show];
            }else{
                header = [dic valueForKey:@"avatar_large"];
                name = [dic valueForKey:@"screen_name"];
                if ([[dic valueForKey:@"gender"] isEqual:@"m"]) {
                    sex = @"1";
                }else{
                    sex = @"0";
                }
                [ThirdLoginModel thirdLoginWithKey:onceId Name:name Sex:sex Header:header block:^(int code, NSString *msg, NSString *uid, NSString *sig) {
                    if (code == 1) {
                        NSLog(@"登录成功");
                        [UserManager saveSig:sig uid:uid];
                        if ([_deleagte respondsToSelector:@selector(sinaLoginSuccess)]) {
                            [_deleagte sinaLoginSuccess];
                        }
//                        [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotificationName object:nil];
                    }else{
                        NSLog(@"登录失败");
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"登录失败，请重试!" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                }];
            }
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


#pragma mark - WXApiDelegate

-(void) onReq:(BaseReq*)req
{
    
}

-(void) onResp:(BaseResp*)resp
{
    if (!_isShare) {
    /*
     ErrCode ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code    用户换取access_token的code，仅在ErrCode为0时有效
     state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang    微信客户端当前语言
     country 微信用户当前国家信息
     */
        _isShare = YES;
        
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode== 0) {
            NSString *code = aresp.code;
            //NSDictionary *dic = @{@"code":code};
            _weixinCode = code;
            [self getAccess_token];
        }
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case WXSuccess:
                [[NSNotificationCenter defaultCenter]postNotificationName:@"WXPaySuccessNotification" object:nil];
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                [SVProgressHUD showErrorWithStatus:@"支付失败，请重试。。。"];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
}
#pragma mark - 微信 token和openid

-(void)getAccess_token
{
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXAPP_ID,kWXAPP_SECRET,_weixinCode];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                accessToken_ = [dic objectForKey:@"access_token"];
                openid_ = [dic objectForKey:@"openid"];
                NSLog(@"weixin accesssToken = %@ \n openId = %@", accessToken_, openid_);
                if (openid_) {
                    [UserManager saveOpenId:openid_];
                }
                [self getUserInfo];
            }
        });
    });
}

#pragma mark - userinfo

-(void)getUserInfo
{
    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken_,openid_];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSString *nickname = [dic objectForKey:@"nickname"];
                NSString *headerImgUrl = [dic objectForKey:@"headimgurl"];
                NSString *sex = [dic objectForKey:@"sex"];
                NSString *onceID = openid_;
                [ThirdLoginModel thirdLoginWithKey:onceID Name:nickname Sex:sex Header:headerImgUrl block:^(int code, NSString *msg, NSString *uid, NSString *sig) {
                    if (code == 1) {
                        NSLog(@"登录成功");
                        [UserManager saveSig:sig uid:uid];
                        if ([_deleagte respondsToSelector:@selector(sinaLoginSuccess)]) {
                            [_deleagte sinaLoginSuccess];
                        }
                    }else{
                        NSLog(@"登录失败");
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"登录失败，请重试!" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                }];
                
            }
        });
        
    });  
}

@end
