//
//  RegisterStep1ViewController.h
//  Love
//
//  Created by lee wei on 14-8-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  注册第一步 输入手机号获取验证码
//

#import <UIKit/UIKit.h>

@interface RegisterStep1ViewController : LOVBaseViewController

@property (nonatomic, assign) BOOL isForgetPwd;

- (IBAction)getSmsDataAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SmsButton;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *conturyNumber;

@end
