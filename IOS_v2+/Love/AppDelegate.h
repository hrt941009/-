//
//  AppDelegate.h
//  Love
//
//  Created by 李伟 on 14-6-26.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import "WXApi.h"
#import "LOVGuardView.h"
#import "LOVThirdLoginConfig.h"

@protocol SinaThirdLoginDelegate <NSObject>

- (void)sinaLoginSuccess;

@end

extern NSString *const LOVPopToRootViewControllerNotification;

@class LOVTabBarController, CountdownView, LOVThirdLogin;
@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate, WXApiDelegate, LOVGuardViewDelegate, WeiboSDKDelegate>
{
    enum WXScene _scene;
    NSTimer *timer;
    int cdTime;
    
    NSString *accessToken_;
    NSString *openid_;
}

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) LOVGuardView *guardView;
@property (nonatomic, strong) CountdownView *countdownView;
@property (nonatomic, strong) LOVThirdLogin *thirdLogin;

@property (nonatomic, strong) NSString *weixinCode;

@property (nonatomic, weak) id<SinaThirdLoginDelegate>deleagte;

@property (nonatomic, assign) BOOL isShare;

+ (AppDelegate *)shareInstance;

- (void)countDownViewDisplay:(BOOL)display currentTime:(NSNumber *)currentTime endTime:(NSNumber *)endTime;
- (void)countDownViewHidden:(BOOL)hidden;

-(void)getAccess_token;
@end
