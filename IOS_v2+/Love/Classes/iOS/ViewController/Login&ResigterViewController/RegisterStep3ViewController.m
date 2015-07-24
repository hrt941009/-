//
//  RegisterStep3ViewController.m
//  Love
//
//  Created by lee wei on 14-8-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "RegisterStep3ViewController.h"
#import "RegisterModel.h"
#import "SVProgressHUD.h"

@interface RegisterStep3ViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *userLbel;

@property (nonatomic, strong) IBOutlet UIButton *photoButton;
@property (nonatomic, strong) IBOutlet UITextField *userNameTextField, *passwordTextField, *confirmPasswordTextField;
- (IBAction)doneAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *pwdLabel;
@property (weak, nonatomic) IBOutlet UILabel *surePwdLabel;

@end

@implementation RegisterStep3ViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _isForgetPwd = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = MyLocalizedString(@"设置用户名和密码");
    
    _userLbel.text = MyLocalizedString(@"请输入用户名:");
    _pwdLabel.text = MyLocalizedString(@"请输入密码:");
    _surePwdLabel.text = MyLocalizedString(@"确认密码:");
    _userNameTextField.placeholder = MyLocalizedString(@"4到12个字符");
    _passwordTextField.placeholder = MyLocalizedString(@"6到20个字符");
    _confirmPasswordTextField.placeholder = MyLocalizedString(@"6到20个字符");
    [_doneButton setTitle:MyLocalizedString(@"Done") forState:UIControlStateNormal];
    
    _userNameTextField.frame = CGRectMake(8, 44, kScreenWidth - 16, 32);
    _passwordTextField.frame = CGRectMake(8, 113, kScreenWidth - 16, 32);
    _confirmPasswordTextField.frame = CGRectMake(8, 192, kScreenWidth - 16, 32);
    _doneButton.frame = CGRectMake(8, 274, kScreenWidth - 16, 36);
    
    _doneButton.layer.masksToBounds = YES;
    _doneButton.layer.cornerRadius = 4.f;
    
    if (_isForgetPwd) {
        _userNameTextField.hidden = YES;
        _userLbel.hidden = YES;
    }else{
        _userNameTextField.layer.borderColor = [[UIColor colorRGBWithRed:159.f green:168.f blue:177.f alpha:1] CGColor];
        _userNameTextField.layer.borderWidth = 0.4;
        _userNameTextField.layer.cornerRadius = 5.f;
        _userNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    }
    
//    UIImageView *passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录密码icon.png"]];
//    _passwordTextField.leftView = passwordImageView;
    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.layer.borderColor = [[UIColor colorRGBWithRed:159.f green:168.f blue:177.f alpha:1] CGColor];
    _passwordTextField.layer.borderWidth = 0.4;
    _passwordTextField.layer.cornerRadius = 5.f;
    _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    
//    UIImageView *confirmPwdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录密码icon.png"]];
//    _confirmPasswordTextField.leftView = confirmPwdImageView;
    _confirmPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    _confirmPasswordTextField.layer.borderColor = [[UIColor colorRGBWithRed:159.f green:168.f blue:177.f alpha:1] CGColor];
    _confirmPasswordTextField.layer.borderWidth = 0.4;
    _confirmPasswordTextField.layer.cornerRadius = 5.f;
    _confirmPasswordTextField.clearButtonMode = UITextFieldViewModeAlways;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - alertview delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)doneAction:(id)sender {
    if (_isForgetPwd) {
        __block UIAlertView *alertView = nil;
        NSString *pwd = _passwordTextField.text;
        NSString *confirmPwd = _confirmPasswordTextField.text;
        NSString *mobile = _mobileStr;
        if ([pwd length]> 5 && [mobile length] > 5) {
            if ([pwd isEqualToString:confirmPwd]) {
                [SVProgressHUD showSuccessWithStatus:@"提交中..."];
                [RegisterModel againChangePasswordWithMobile:mobile confirmPwd:confirmPwd pwd:pwd block:^(NSString *msg, int code) {
                    [SVProgressHUD dismiss];
                    alertView = [[UIAlertView alloc] initWithTitle:nil
                                                           message:msg
                                                          delegate:self
                                                 cancelButtonTitle:MyLocalizedString(@"OK")
                                                 otherButtonTitles:nil];
                    alertView.delegate = self;
                    [alertView show];
                }];
            }else{
                [SVProgressHUD showErrorWithStatus:@"两次密码不同"];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入至少6位的密码"];
        }
    }else{
    
    __block UIAlertView *alertView = nil;
    
    NSString *name = _userNameTextField.text;
    NSString *pwd = _passwordTextField.text;
    NSString *confirmPwd = _confirmPasswordTextField.text;
    NSString *mobile = _mobileStr;
    if ([name length] > 0 && [pwd length] > 5 && [mobile length] > 5) {
        if ([pwd isEqualToString:confirmPwd]) {
            [SVProgressHUD showSuccessWithStatus:@"提交中..."];
            [RegisterModel registerWithUserName:name
                                       password:pwd
                                         mobile:mobile
                                     couponCode:_couponCode
                                          block:^(NSString *msg, int code) {
                                              [SVProgressHUD dismiss];
                                              alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                                     message:msg
                                                                                    delegate:self
                                                                           cancelButtonTitle:MyLocalizedString(@"OK")
                                                                           otherButtonTitles:nil];
                                              alertView.delegate = self;
                                              [alertView show];
                                          }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"两次密码不同"];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入用户名和密码且密码长度至少为6位"];
    }
    }
    
}
@end
