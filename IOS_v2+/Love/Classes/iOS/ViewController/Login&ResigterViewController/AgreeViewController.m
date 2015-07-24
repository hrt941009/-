//
//  AgreeViewController.m
//  Love
//
//  Created by lee wei on 14/11/26.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "AgreeViewController.h"
#import "RegisterStep2ViewController.h"
#import "RegisterModel.h"
#import "SVProgressHUD.h"

@interface AgreeViewController ()

@property (nonatomic, strong) RegisterStep2ViewController *step2ViewController;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UIButton *AgreeButton;

@property (weak, nonatomic) IBOutlet UITextField *CheapTextView;
@property (weak, nonatomic) IBOutlet UILabel *secretlabel;
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollview;
- (IBAction)agreeButtonAction:(id)sender;


@end

@implementation AgreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = MyLocalizedString(@"条款");
    
    _secretlabel.frame = CGRectMake(15,10,68,20);
    _bgScrollview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _myTextView.frame = CGRectMake(0, 40, kScreenWidth, 380);
    [_myTextView setEditable:NO];
    _CheapLabel.frame = CGRectMake(kScreenWidth - 90, CGRectGetMaxY(_myTextView.frame) +20, 75, 29);
    _CheapTextView.frame = CGRectMake(15, CGRectGetMaxY(_myTextView.frame) +20, kScreenWidth -115, 30);
    _AskLabel.frame = CGRectMake(15, CGRectGetMaxY(_CheapTextView.frame) +10, 323, 20);
    _AgreeButton.frame = CGRectMake(15, CGRectGetMaxY(_AskLabel.frame) +10, kScreenWidth - 35, 35);
    _AgreeButton.layer.masksToBounds = YES;
    _AgreeButton.layer.cornerRadius = 3.f;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(0, 0, 80, 36.f);
    nextButton.backgroundColor = [UIColor clearColor];
    _CheapTextView.placeholder = @"请输入优惠码";
    _CheapLabel.numberOfLines = 2;
    _CheapLabel.font = [UIFont systemFontOfSize:12.f];
    _AskLabel.font = [UIFont systemFontOfSize:12.f];
    
    _bgScrollview.contentSize = CGSizeMake(kScreenWidth, 668);
//    [nextButton setTitle:@"同意" forState:UIControlStateNormal];
//    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    nextButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
//    [nextButton addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *nextBarButton = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    self.navigationItem.rightBarButtonItem = nextBarButton;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)mytextView
{
    return NO;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    _step2ViewController = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)agreeButtonAction:(id)sender {
    if (_CheapTextView.text.length == 6) {
        [RegisterModel testAndVerifyCoupon:_CheapTextView.text block:^(NSString *msg, int code) {
            if (code == 1) {
                [SVProgressHUD showSuccessWithStatus:@"发送中..."];
                [RegisterModel registerForSMSWithMobile:_mobile block:^(NSString *msg, NSNumber *currentTime, int code) {
                    if (code == 0) {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                        [alertView show];
                    }else{
                        [SVProgressHUD dismiss];
                        if (_step2ViewController == nil) {
                            _step2ViewController = [[RegisterStep2ViewController alloc] initWithNibName:@"RegisterStep2View"
                                                                                                 bundle:nil];
                            _step2ViewController.mobileStr = _mobile;
                            _step2ViewController.currentTime = currentTime;
                            _step2ViewController.couponCode = _CheapTextView.text;
                            [self.navigationController pushViewController:_step2ViewController animated:YES];
                        }
                    }
                    
                }];
            }else{
                [SVProgressHUD showErrorWithStatus:@"邀请码错误"];
            }
        }];
    }else if (_CheapTextView.text.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"发送中..."];
        [RegisterModel registerForSMSWithMobile:_mobile block:^(NSString *msg, NSNumber *currentTime, int code) {
            if (code == 0) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                [alertView show];
            }else{
                [SVProgressHUD dismiss];
                if (_step2ViewController == nil) {
                    _step2ViewController = [[RegisterStep2ViewController alloc] initWithNibName:@"RegisterStep2View"
                                                                                         bundle:nil];
                    _step2ViewController.mobileStr = _mobile;
                    _step2ViewController.currentTime = currentTime;
                    _step2ViewController.couponCode = _CheapTextView.text;
                    [self.navigationController pushViewController:_step2ViewController animated:YES];
                }
            }
            
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"邀请码错误"];
    }
}
@end
