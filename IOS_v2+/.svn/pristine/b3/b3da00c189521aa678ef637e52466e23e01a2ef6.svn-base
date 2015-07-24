//
//  SettingMobileViewController.h
//  Love
//
//  Created by lee wei on 14-10-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  我-个人信息-我的账号-手机号
//

#import <UIKit/UIKit.h>

@protocol SettingMobileViewControllerDelegate <NSObject>

- (void)editMobile:(NSString *)mobile;

@end

@interface SettingMobileViewController : LOVBaseViewController

@property (nonatomic, strong) NSString *oldMobileStr;

@property (nonatomic, weak) id<SettingMobileViewControllerDelegate> delegate;

@end
