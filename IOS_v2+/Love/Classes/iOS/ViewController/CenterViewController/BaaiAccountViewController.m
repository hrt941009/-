//
//  BaaiAccountViewController.m
//  Love
//
//  Created by lee wei on 14-10-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "BaaiAccountViewController.h"

@interface BaaiAccountViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UILabel *oldAccountLabel;
@property (nonatomic, strong) IBOutlet UITextField *accountTextField;

@property (nonatomic, strong) IBOutlet UIButton *doneButton;

- (IBAction)doneAction:(id)sender;

@end

@implementation BaaiAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = MyLocalizedString(@"设置八爱号");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(accountNavBack:)
                                                 name:LOVBaseControllerNoticeNavBack
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(accountSwipeBack:)
                                                 name:LOVBaseControllerNoticeSwipeBack
                                               object:nil];
    
    if ([_oldAccountStr length] == 0) {
        _oldAccountLabel.alpha = 0;
    }else{
        _oldAccountLabel.alpha = 1.f;
        _oldAccountLabel.text = _oldAccountStr;
    }
    
    _accountTextField.placeholder = @"填写新的ID";

    _accountTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _accountTextField.layer.borderWidth = 1.f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action
- (IBAction)doneAction:(id)sender
{
    UIAlertView *alertView = nil;
    if ([_oldAccountStr length] == 0) {
        
    }else{
        alertView = [[UIAlertView alloc] initWithTitle:nil
                                               message:@"是否修改八爱ID"
                                              delegate:self
                                     cancelButtonTitle:MyLocalizedString(@"Cancel")
                                     otherButtonTitles:@"我要修改", nil];
        [alertView show];
    }
}

#pragma mark - alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark - notice
- (void)accountNavBack:(NSNotification *)notice
{
    if ([_oldAccountStr length] == 0) {
        [_delegate editBaaiAccount:_accountTextField.text];
    }else{
        [_delegate editBaaiAccount:_oldAccountStr];
    }
    
}

- (void)accountSwipeBack:(NSNotification *)notice
{
    if ([_oldAccountStr length] == 0) {
        [_delegate editBaaiAccount:_accountTextField.text];
    }else{
        [_delegate editBaaiAccount:_oldAccountStr];
    }
}


@end
