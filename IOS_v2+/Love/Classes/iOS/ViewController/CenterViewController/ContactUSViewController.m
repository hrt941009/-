//
//  ContactUSViewController.m
//  Love
//
//  Created by lee wei on 14-10-3.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "ContactUSViewController.h"
#import "SettingModel.h"

@interface ContactUSViewController ()<UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UITextView *contentTextView;
@property (nonatomic, strong) IBOutlet UITextField *contactTextField;

@end

@implementation ContactUSViewController

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
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 0, 50.f, 30.f);
    doneButton.backgroundColor = [UIColor clearColor];
    [doneButton setTitle:@"提交" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    doneButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [doneButton addTarget:self action:@selector(submitContentAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    self.navigationItem.rightBarButtonItem = doneBarButton;
    
    //---
    _contentTextView.frame = CGRectMake(5, 3, kScreenWidth - 10, 124);
    _contentTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _contentTextView.layer.borderWidth = 1.f;
    _contentTextView.delegate = self;
    _contentTextView.textColor = [UIColor lightGrayColor];
    _contentTextView.text = @"请输入您的宝贵意见";
    
    _contactTextField.frame = CGRectMake(5, 129, kScreenWidth - 10, 30);
    _contactTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _contactTextField.layer.borderWidth = 1.f;
    _contactTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textview delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
}

#pragma mark - textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

#pragma mark - button action
- (void)submitContentAction
{
    if (_contentTextView.text.length == 0 || [_contentTextView.text isEqual: @"请输入您的宝贵意见"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请给出您的宝贵意见！" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        [SettingModel getFeedBackDataString:_contentTextView.text contact:_contactTextField.text block:^(int code, NSString *msg) {
            if (code == 1) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"感谢您提出宝贵的意见。" delegate:self cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
    }
}

#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
