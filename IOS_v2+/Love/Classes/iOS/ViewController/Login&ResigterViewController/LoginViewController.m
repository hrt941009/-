//
//  LoginViewController.m
//  Love
//
//  Created by lee wei on 14-7-16.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterStep1ViewController.h"

#import "LOVThirdLogin.h"
#import "UserManager.h"

#import "LoginModel.h"

#import "AppDelegate.h"

NSString *const LoginSuccessNotificationName = @"LoginSuccessNotification";

@interface LoginViewController ()<UITextFieldDelegate, UIAlertViewDelegate, LoginSuccessDelegate, SinaThirdLoginDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrolleView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (nonatomic ,strong) IBOutlet UITextField *loginNameTextField, *passwordTextField;
@property (nonatomic, strong) IBOutlet UIButton *forgetPasswordButton, *loginButton, *registerButton, *backButton;
@property (nonatomic, strong) IBOutlet UIButton *qqButton, *weixinButton, *alipayButton, *weiboButton;
@property (nonatomic, strong) IBOutlet UILabel *infoLabel;

@property (nonatomic, strong) LOVThirdLogin *thirdLogin;

@property (nonatomic, strong) AppDelegate *myDelegate;

- (IBAction)forgetPasswordAction:(id)sender;

- (IBAction)qqAction:(id)sender;
- (IBAction)weixinAction:(id)sender;
- (IBAction)alipayAction:(id)sender;
- (IBAction)weiboAction:(id)sender;


@end

@implementation LoginViewController

#pragma mark -- LoginSuccessDelegate
- (void)loginSuccess{
    [self.navigationController popViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotificationName object:nil];
}

#pragma mark -- SinaSuccessDelegate
- (void)sinaLoginSuccess{
    [self.navigationController popViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotificationName object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = MyLocalizedString(@"登录");
    
    [_registerButton setTitle:MyLocalizedString(@"注册") forState:UIControlStateNormal];
    [_loginButton setTitle:MyLocalizedString(@"登录") forState:UIControlStateNormal];
    [_forgetPasswordButton setTitle:MyLocalizedString(@"忘记密码") forState:UIControlStateNormal];
    _infoLabel.text = MyLocalizedString(@"--------------------您还可以用以下方式登录----------------");
    
    
    self.view.backgroundColor = [UIColor colorRGBWithRed:235.f green:235.f blue:235.f alpha:1];
    
    _bgScrolleView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _bgImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _loginNameTextField.frame = CGRectMake(40, 23, kScreenWidth - 80, 36);
    _passwordTextField.frame = CGRectMake(40, 67, kScreenWidth - 80, 36);
    _registerButton.frame = CGRectMake(kScreenWidth/2 - 63, 120, 58, 30);
    _loginButton.frame = CGRectMake(kScreenWidth/2 + 5, 120, 58, 30);
    _forgetPasswordButton.frame = CGRectMake(kScreenWidth/2 + 45, 150, 86, 30);
    _infoLabel.frame = CGRectMake(0, 180, kScreenWidth, 18);
    
    if ([WXApi isWXAppInstalled] && ![TencentOAuth iphoneQQInstalled]) {
        _weixinButton.hidden = YES;
        _weixinButton.frame = CGRectMake((kScreenWidth - 177)/2, 220, 43, 43);
        _weiboButton.frame = CGRectMake((kScreenWidth + 43)/2 - 8 + 30, 220, 43, 43);
    }else if ([TencentOAuth iphoneQQInstalled] && ![WXApi isWXAppInstalled]) {
        _qqButton.hidden = YES;
        _qqButton.frame = CGRectMake((kScreenWidth - 177)/2, 220, 43, 43);
        _weiboButton.frame = CGRectMake((kScreenWidth + 43)/2 - 8 + 30, 220, 43, 43);
    }else if ([WXApi isWXAppInstalled] && [TencentOAuth iphoneQQInstalled]){
        _qqButton.frame = CGRectMake((kScreenWidth - 177)/2, 220, 43, 43);
        _weixinButton.frame = CGRectMake(kScreenWidth/2 - 225/6 + 15, 220, 43, 43);
        _weiboButton.frame = CGRectMake((kScreenWidth + 43)/2 - 8 + 30, 220, 43, 43);
    }else{
        _qqButton.hidden = YES;
        _weixinButton.hidden = YES;
        _weiboButton.frame = CGRectMake(kScreenWidth/2 - 225/6 + 15, 220, 43, 43);
    }

    /**
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(0, 0, 80, 36.f);
    nextButton.backgroundColor = [UIColor clearColor];
    [nextButton setTitle:@"注册" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [nextButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *nextBarButton = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    self.navigationItem.rightBarButtonItem = nextBarButton;
    */
    
    //------
    _loginNameTextField.layer.borderColor = [[UIColor colorRGBWithRed:242.f green:167.f blue:143.f alpha:1] CGColor];
    _loginNameTextField.layer.borderWidth = 0.8;
    _loginNameTextField.layer.cornerRadius = 10.f;
    _loginNameTextField.placeholder = @"用户名,邮箱,手机号";
    _loginNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    _loginNameTextField.delegate = self;
    
    _passwordTextField.layer.borderColor = [[UIColor colorRGBWithRed:242.f green:167.f blue:143.f alpha:1] CGColor];
    _passwordTextField.layer.borderWidth = 0.8;
    _passwordTextField.layer.cornerRadius = 10.f;
    _passwordTextField.placeholder = @"请输入密码";
    _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.delegate = self;
    
    //-----
    [_forgetPasswordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgetPasswordButton setTitleColor:[UIColor colorRGBWithRed:244.f green:140.f blue:156.f alpha:1.f] forState:UIControlStateNormal];
    
    _infoLabel.textColor = [UIColor colorRGBWithRed:244.f green:140.f blue:156.f alpha:1.f];
    //----
    [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [_registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    //--------
    
    _thirdLogin = [[LOVThirdLogin alloc] init];
    _thirdLogin.delegate = self;
    
    [AppDelegate shareInstance].deleagte = self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    _loginNameTextField.text = nil;
    _passwordTextField.text = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_loginNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    return YES;
}

#pragma mark - button action
/**
 登陆
 */
- (void)loginAction
{
    [LoginModel loginAppWithName:_loginNameTextField.text password:_passwordTextField.text block:^(int code, NSDictionary *dic) {
        if (code == 1) {
            
            NSString *sig = [[dic objectForKey:@"sign"] objectForKey:@"sig"];
            NSString *uid = [[dic objectForKey:@"sign"] objectForKey:@"uid"];
            NSLog(@"sig = %@, uid = %@", sig, uid);
            [UserManager saveAccount:_loginNameTextField.text password:_passwordTextField.text];
            [UserManager saveSig:sig uid:uid];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotificationName object:nil];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"用户名或密码错误"
                                                               delegate:self
                                                      cancelButtonTitle:MyLocalizedString(@"OK")
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }];
}


/**
 注册
 */
- (void)registerAction
{
    RegisterStep1ViewController *step1ViewController = [[RegisterStep1ViewController alloc] initWithNibName:@"RegisterStep1View" bundle:nil];
    [self.navigationController pushViewController:step1ViewController animated:YES];
}

/**
 忘记密码
 */
- (IBAction)forgetPasswordAction:(id)sender
{
//    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil
//                                                       message:@"如果重设密码，请输入已绑定的邮箱。"
//                                                      delegate:self
//                                             cancelButtonTitle:MyLocalizedString(@"Cancel")
//                                             otherButtonTitles:MyLocalizedString(@"OK"), nil];
//    alerView.alertViewStyle = UIAlertViewStylePlainTextInput;
//    alerView.delegate = self;
//    [alerView show];
    RegisterStep1ViewController *register1 = [[RegisterStep1ViewController alloc] init];
    register1.isForgetPwd = YES;
    [self.navigationController pushViewController:register1 animated:YES];
    
    
}

- (IBAction)qqAction:(id)sender
{
    [_thirdLogin qqLoginAction];
}
- (IBAction)weixinAction:(id)sender
{
    [_thirdLogin weixinLoginAction];
}
- (IBAction)alipayAction:(id)sender
{
    [_thirdLogin alipayLoginAction];
}
- (IBAction)weiboAction:(id)sender
{
    [_thirdLogin weiboLoginAction];
}

#pragma mark - alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        
        NSLog(@"---------------------- %@", textField.text);
    }
}

@end
