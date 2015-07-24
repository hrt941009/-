//
//  SettingMobileViewController.m
//  Love
//
//  Created by lee wei on 14-10-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SettingMobileViewController.h"

@interface SettingMobileViewController ()

@property (nonatomic, strong) IBOutlet UILabel *oldMobileLabel;
@property (nonatomic, strong) IBOutlet UITextField *mobileTextField;
@property (nonatomic, strong) IBOutlet UITextField *confirmTextField;
@property (nonatomic, strong) IBOutlet UIButton *confirmButton;
@property (nonatomic, strong) IBOutlet UIButton *mobileDoneButton;

- (IBAction)mobileDoneAction:(id)sender;

@end

@implementation SettingMobileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = MyLocalizedString(@"绑定手机号");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mobileNavBack:)
                                                 name:LOVBaseControllerNoticeNavBack
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mobileSwipeBack:)
                                                 name:LOVBaseControllerNoticeSwipeBack
                                               object:nil];
    
    if ([_oldMobileStr length] == 0) {
        _oldMobileLabel.alpha = 0;
    }else{
        _oldMobileLabel.alpha = 1.f;
        _oldMobileLabel.text = _oldMobileStr;
    }
    
    _mobileTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _mobileTextField.layer.borderWidth = 1.f;
    
    _confirmTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _confirmTextField.layer.borderWidth = 1.f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - button action
- (IBAction)mobileDoneAction:(id)sender
{
    
}

#pragma mark - notice
- (void)mobileNavBack:(NSNotification *)notice
{
    if ([_oldMobileStr length] == 0) {
        [_delegate editMobile:_mobileTextField.text];
    }else{
        [_delegate editMobile:_oldMobileStr];
    }
    
}

- (void)mobileSwipeBack:(NSNotification *)notice
{
    if ([_oldMobileStr length] == 0) {
        [_delegate editMobile:_mobileTextField.text];
    }else{
        [_delegate editMobile:_oldMobileStr];
    }
}

@end
