//
//  SettingEmailViewController.m
//  Love
//
//  Created by lee wei on 14-10-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SettingEmailViewController.h"

@interface SettingEmailViewController ()

@property (nonatomic, strong) IBOutlet UILabel *oldEmailLabel;
@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;

@property (nonatomic, strong) IBOutlet UIButton *emailDoneButton;

- (IBAction)emailDoneAction:(id)sender;

@end

@implementation SettingEmailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = MyLocalizedString(@"绑定邮箱");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(emailNavBack:)
                                                 name:LOVBaseControllerNoticeNavBack
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(emailSwipeBack:)
                                                 name:LOVBaseControllerNoticeSwipeBack
                                               object:nil];
    
    _emailTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _emailTextField.layer.borderWidth = 1.f;
    
    _passwordTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _passwordTextField.layer.borderWidth = 1.f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action
- (IBAction)emailDoneAction:(id)sender
{
    
}

#pragma mark - notice
- (void)emailNavBack:(NSNotification *)notice
{

}

- (void)emailSwipeBack:(NSNotification *)notice
{

}

@end
