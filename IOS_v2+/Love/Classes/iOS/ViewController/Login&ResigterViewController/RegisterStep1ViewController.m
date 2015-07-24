//
//  RegisterStep1ViewController.m
//  Love
//
//  Created by lee wei on 14-8-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "RegisterStep1ViewController.h"
#import "AgreeViewController.h"
#import "CountryListViewController.h"
#import "RetrievePwdViewController.h"
#import "RegisterModel.h"
#import "SVProgressHUD.h"


@interface RegisterStep1ViewController ()<UITextFieldDelegate, CountryListControllerDelegate>
{
    NSString  *introString;
}

@property (nonatomic, strong) IBOutlet UIButton    *selectCountryButton;
@property (nonatomic, strong) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UIView *bgPhoneView;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrImgView;

@property (nonatomic, strong) NSString *mobileStr;
@property (nonatomic, strong) CountryListViewController *countryListController;
@property (nonatomic, strong) AgreeViewController *agreeViewController;


- (IBAction)selectCountryAction:(id)sender;


@end

@implementation RegisterStep1ViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle
{
    self = [super initWithNibName:nibName bundle:nibBundle];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_isForgetPwd) {
        self.title = MyLocalizedString(@"密码找回");
    }else{
        self.title = MyLocalizedString(@"注册");
    }
    
    _selectCountryButton.frame = CGRectMake(0, 14, kScreenWidth, 40);
    _bgPhoneView.frame = CGRectMake(0, 70, kScreenWidth, 40);
    _SmsButton.frame = CGRectMake(8, 145, kScreenWidth - 16, 31);
    _introLabel.frame = CGRectMake(8, 203, kScreenWidth - 16, 75);
    _rightArrImgView.frame = CGRectMake(kScreenWidth - 30, 27, 10, 16);
    _mobileTextField.frame = CGRectMake(59, 5, kScreenWidth - 69, 29);

    introString = @"中国";
    [_selectCountryButton setTitle:introString forState:UIControlStateNormal];
    _selectCountryButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 270);
    _selectCountryButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    _selectCountryButton.layer.borderColor = [[UIColor colorRGBWithRed:159.f green:168.f blue:177.f alpha:1] CGColor];
//    _selectCountryButton.layer.borderWidth = 0.4;
    
    _conturyNumber.backgroundColor = [UIColor whiteColor];
    _conturyNumber.text = @"+86";
    
    _SmsButton.layer.masksToBounds = YES;
    _SmsButton.layer.cornerRadius = 4.f;
    
    
//    UIImageView *mobileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_phone.png"]];
//    _mobileTextField.leftView = mobileImageView;
//    _mobileTextField.leftViewMode = UITextFieldViewModeAlways;
    _mobileTextField.borderStyle = UITextBorderStyleNone;
    _mobileTextField.layer.masksToBounds = YES;
    _mobileTextField.layer.cornerRadius = 4.f;
    _mobileTextField.layer.borderWidth = 1.f;
    _mobileTextField.layer.borderColor = [[UIColor GoogleRed] CGColor];
    _mobileTextField.placeholder = @"请输入手机号码";
    _mobileTextField.delegate = self;
//    _mobileTextField.keyboardAppearance = YES;
    _mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    _mobileTextField.layer.borderColor = [[UIColor colorRGBWithRed:159.f green:168.f blue:177.f alpha:1] CGColor];
    _mobileTextField.layer.borderWidth = 0.4;
    _mobileTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view bringSubviewToFront:_mobileTextField];
//    [_mobileTextField becomeFirstResponder];
    
    _introLabel.text = @"手机号仅使用于免费接收系统发送的短信验证码，不会对外泄露您的手机号及用于其它商业用途。";
    _introLabel.numberOfLines = 3;
    _introLabel.font = [UIFont systemFontOfSize:15.f];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    _countryListController = nil;
    _agreeViewController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate
- (void)getCountryName:(NSString *)name andCode:(NSString *)code
{
    [_selectCountryButton setTitle:name forState:UIControlStateNormal];
    _conturyNumber.text = [NSString stringWithFormat:@"+%@",code];
}

#pragma mark - button
- (IBAction)selectCountryAction:(id)sender
{
    if (_countryListController == nil) {
        _countryListController = [[CountryListViewController alloc] init];
        _countryListController.delegate = self;
        [self.navigationController pushViewController:_countryListController animated:YES];
    }
}


//- (void)nextAction:(id)sender
//{
//    NSString *mobile = _mobileTextField.text;
//    NSString *str = _selectCountryButton.titleLabel.text;
//    if ([str isEqualToString:introString] || [str length] == 0) {
//        [SVProgressHUD showErrorWithStatus:@"请选择国家"];
//    }else if ([mobile length] == 0){
//        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
//    }else{
//        if (_agreeViewController == nil) {
//            _agreeViewController = [[AgreeViewController alloc] initWithNibName:@"AgreeViewController"
//                                                                         bundle:nil];
//            _agreeViewController.mobile = _mobileTextField.text;
//            [self.navigationController pushViewController:_agreeViewController animated:YES];
//        }
//    }
//}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    return YES;
}



#pragma mark -- 获取验证码
- (IBAction)getSmsDataAction:(id)sender {
    
    NSString *mobile = _mobileTextField.text;
    NSString *str = _selectCountryButton.titleLabel.text;
//    if ([str isEqualToString:introString] || [str length] == 0) {
    if ([str length] == 0){
        [SVProgressHUD showErrorWithStatus:@"请选择国家"];
    }else if ([mobile length] == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
    }else{
        if (_isForgetPwd) {
            [RegisterModel againChangePassword:_mobileTextField.text block:^(NSString *msg, NSNumber *currentTime, int code) {
                if (code == 0) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                    [alertView show];
                }else{
                    RetrievePwdViewController *retrievePwdVC = [[RetrievePwdViewController alloc] init];
                    retrievePwdVC.phoneNum = _mobileTextField.text;
                    [self.navigationController pushViewController:retrievePwdVC animated:YES];
                }
            }];
            
        }else{
            if (_agreeViewController == nil) {
                _agreeViewController = [[AgreeViewController alloc] initWithNibName:@"AgreeViewController"
                                                                         bundle:nil];
                _agreeViewController.mobile = _mobileTextField.text;
                [self.navigationController pushViewController:_agreeViewController animated:YES];
            }
        }
    }
}
@end
