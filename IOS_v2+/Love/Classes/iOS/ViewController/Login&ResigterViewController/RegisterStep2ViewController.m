//
//  RegisterStep2ViewController.m
//  Love
//
//  Created by lee wei on 14-8-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "RegisterStep2ViewController.h"
#import "RegisterStep3ViewController.h"
#import "NSDate+Additions.h"
#import "RegisterModel.h"
#import "SVProgressHUD.h"

@interface RegisterStep2ViewController ()
{
    NSTimer *timer;
    int times;
}
@property (nonatomic, strong) IBOutlet UILabel *confirmLabel;
@property (nonatomic, strong) IBOutlet UITextField *smsTextField;
@property (nonatomic, strong) IBOutlet UIButton *smsConfirmButton;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@property (nonatomic, strong) RegisterStep3ViewController *step3ViewController;

- (IBAction)smsConfirmButton:(id)sender;

@end

@implementation RegisterStep2ViewController

- (id)init
{
    self = [super init];
    if (self) {
        times = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = MyLocalizedString(@"验证手机号");
    
    _myLabel.text = MyLocalizedString(@"如果没有收到短信");
    
    _smsTextField.frame = CGRectMake(20, 43, kScreenWidth - 40, 40);
    _smsConfirmButton.frame = CGRectMake(66, 115, kScreenWidth - 66 * 2, 36);
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(0, 0, 80, 36.f);
    nextButton.backgroundColor = [UIColor clearColor];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [nextButton addTarget:self action:@selector(step2NextAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *nextBarButton = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    self.navigationItem.rightBarButtonItem = nextBarButton;
    
    
    _confirmLabel.text = [NSString stringWithFormat:@"验证码已发送到%@", _mobileStr];
    
    UIImageView *smsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_key.png"]];
    _smsTextField.leftView = smsImageView;
    _smsTextField.leftViewMode = UITextFieldViewModeAlways;
    _smsTextField.layer.borderColor = [[UIColor colorRGBWithRed:159.f green:168.f blue:177.f alpha:1] CGColor];
    _smsTextField.layer.borderWidth = 0.4;
    _smsTextField.clearButtonMode = UITextFieldViewModeAlways;
    
    
    [_smsConfirmButton setBackgroundColor:[UIColor colorRGBWithRed:208.f green:208.f blue:208.f alpha:1.f]];
    
    
    //--
    if (_currentTime != NULL) {
//        NSDate *starDate = [NSDate dateWithTimeIntervalSince1970:[_currentTime longLongValue]/1000];
//        NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:<#(NSTimeInterval)#>]
//        NSTimeInterval ti = [[NSDate date] timeIntervalSinceDate:starDate];

        
        times = 60;
        [_smsConfirmButton setTitle:[NSString stringWithFormat:@"重新发送验证码 %d", times] forState:UIControlStateNormal];
        _smsConfirmButton.enabled = NO;
    }else{
        [_smsConfirmButton setTitle:@"重新发送验证码" forState:UIControlStateNormal];
        _smsConfirmButton.enabled = YES;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
}


- (void)countDownAction
{
    times --;
    if (times > 0) {
        [_smsConfirmButton setTitle:[NSString stringWithFormat:@"重新发送验证码 %d", times] forState:UIControlStateNormal];
        _smsConfirmButton.enabled = NO;
    }else{
        [timer invalidate];
        
        [_smsConfirmButton setTitle:@"重新发送验证码" forState:UIControlStateNormal];
        [_smsConfirmButton setBackgroundColor:[UIColor colorRGBWithRed:225 green:35 blue:85 alpha:1]];
        _smsConfirmButton.enabled = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    _step3ViewController = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    [timer invalidate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button
- (IBAction)smsConfirmButton:(id)sender
{
    [SVProgressHUD showSuccessWithStatus:@"发送中..."];
    [RegisterModel registerForSMSWithMobile:_mobileStr block:^(NSString *msg, NSNumber *currentTime, int code) {
        [SVProgressHUD dismiss];
        if (code == 1) {
            if (currentTime != NULL) {
                times = 60;
                [_smsConfirmButton setTitle:[NSString stringWithFormat:@"重新发送验证码 %d", times] forState:UIControlStateNormal];
                _smsConfirmButton.backgroundColor = [UIColor lightGrayColor];
                _smsConfirmButton.enabled = NO;
            }else{
                [_smsConfirmButton setTitle:@"重新发送验证码" forState:UIControlStateNormal];
                _smsConfirmButton.enabled = YES;
            }
            timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
}
- (void)step2NextAction:(id)sender
{
    NSString *sms = _smsTextField.text;
    if ([sms length] > 0) {
        [SVProgressHUD showSuccessWithStatus:@"正在验证...."];
        [RegisterModel registerForSMSConfirmWithWithMobile:_mobileStr code:sms block:^(NSString *msg, int code) {
            if (code == 1) {
                [SVProgressHUD dismiss];
                if (_step3ViewController == nil) {
                    _step3ViewController = [[RegisterStep3ViewController alloc] initWithNibName:@"RegisterStep3View" bundle:nil];
                    _step3ViewController.mobileStr = _mobileStr;
                    _step3ViewController.couponCode = _couponCode;
                    [self.navigationController pushViewController:_step3ViewController animated:YES];
                }
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"验证码错误，请重试!") delegate:nil cancelButtonTitle:MyLocalizedString(@"确认")otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
    }

}


@end
