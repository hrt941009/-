//
//  RetrievePwdViewController.m
//  Love
//
//  Created by use on 15-1-29.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "RetrievePwdViewController.h"
#import "RegisterStep3ViewController.h"
#import "SVProgressHUD.h"
#import "RegisterModel.h"

@interface RetrievePwdViewController ()
{
    NSTimer *timer;
    int times;
}

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UITextField *megTextField;
@property (weak, nonatomic) IBOutlet UIButton *againButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
- (IBAction)againButtonAction:(id)sender;
- (IBAction)nextDoneAction:(id)sender;

@end

@implementation RetrievePwdViewController

-(id)init{
    self = [super init];
    if (self) {
        times = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = MyLocalizedString(@"找回密码");
    
    _textLabel.frame = CGRectMake(76, 26, kScreenWidth - 86, 60);
    _againButton.frame = CGRectMake(kScreenWidth - 155, 108, 145, 30);
    _megTextField.frame = CGRectMake(8, 109, kScreenWidth - 165, 30);
    _nextButton.frame = CGRectMake(8, 167, kScreenWidth - 16, 30);
    
    _iconImageView.image = [UIImage imageNamed:@"icon_hint"];
    
    _textLabel.text = [NSString stringWithFormat:@"已向%@发送短信，请在下面输入框当中输入短信校验码",_phoneNum];
    _textLabel.numberOfLines = 3;
    _textLabel.font = [UIFont systemFontOfSize:15.f];
    
    _againButton.layer.masksToBounds = YES;
    _againButton.layer.cornerRadius = 4.f;
    
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = 4.f;
    
    if (_currentTime == NULL) {
        times = 60;
        [_againButton setTitle:[NSString stringWithFormat:@"重新发送验证码 %d", times] forState:UIControlStateNormal];
        _againButton.enabled = NO;
    }else{
        [_againButton setTitle:@"重新发送验证码" forState:UIControlStateNormal];
        _againButton.enabled = YES;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    
}

- (void)countDownAction{
    times --;
    if (times > 0) {
        [_againButton setTitle:[NSString stringWithFormat:@"重新发送验证码 %d", times] forState:UIControlStateNormal];
        _againButton.enabled = NO;
    }else{
        [timer invalidate];
        
        [_againButton setTitle:@"重新发送验证码" forState:UIControlStateNormal];
        [_againButton setBackgroundColor:[UIColor colorRGBWithRed:225 green:35 blue:85 alpha:1]];
        _againButton.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)againButtonAction:(id)sender {
    [SVProgressHUD showSuccessWithStatus:@"发送中..."];
    [RegisterModel againChangePassword:_phoneNum block:^(NSString *msg, NSNumber *currentTime, int code)  {
//        [_againButton setBackgroundColor:[UIColor colorRGBWithRed:225 green:35 blue:85 alpha:1]];
        [SVProgressHUD dismiss];
        if (code == 1) {
            if (currentTime != NULL) {
                //        NSDate *starDate = [NSDate dateWithTimeIntervalSince1970:[_currentTime longLongValue]/1000];
                //        NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:<#(NSTimeInterval)#>]
                //        NSTimeInterval ti = [[NSDate date] timeIntervalSinceDate:starDate];
                
                
                times = 60;
                [_againButton setTitle:[NSString stringWithFormat:@"重新发送验证码 %d", times] forState:UIControlStateNormal];
                _againButton.backgroundColor = [UIColor lightGrayColor];
                _againButton.enabled = NO;
            }else{
                [_againButton setTitle:@"重新发送验证码" forState:UIControlStateNormal];
                _againButton.enabled = YES;
            }
            timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
}

- (IBAction)nextDoneAction:(id)sender {
    NSString *sms = _megTextField.text;
    if ([sms length] > 0) {
        [SVProgressHUD showSuccessWithStatus:@"正在验证...."];
        [RegisterModel againChangePAsswordWithMobile:_phoneNum code:sms block:^(NSString *msg, int code) {
            if (code == 1) {
                [SVProgressHUD dismiss];
                RegisterStep3ViewController *register3VC = [[RegisterStep3ViewController alloc] init];
                register3VC.mobileStr = _phoneNum;
                register3VC.isForgetPwd = YES;
                [self.navigationController pushViewController:register3VC animated:YES];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"验证码错误,请重试!") delegate:nil cancelButtonTitle:MyLocalizedString(@"确定") otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
    }
    
}
@end
