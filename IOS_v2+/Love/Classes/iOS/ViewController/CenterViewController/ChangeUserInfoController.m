//
//  ChangeUserInfoController.m
//  Love
//
//  Created by use on 14-12-15.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ChangeUserInfoController.h"
#import "UserInfoModel.h"

@interface ChangeUserInfoController ()<UITextViewDelegate>

@end

@implementation ChangeUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _textView.frame = CGRectMake(6, 118, kScreenWidth - 12, 32);
    _line.frame = CGRectMake(6, 153, kScreenWidth - 12, 1);
    _sureButton.frame = CGRectMake(14, 196, kScreenWidth - 28, 30);
    
    
    _statusLabel.text = _statusStr;
    _sureButton.layer.masksToBounds = YES;
    _sureButton.layer.cornerRadius = 3.f;
    
    _textView.delegate = self;
    
    
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

- (IBAction)sureButtonAction:(id)sender {
    if (_textView.text.length != 0) {
        if (_status == 0) {
            [UserInfoModel eidtUserName:_textView.text block:^(int code) {
                if (code == 1) {
                    [_delegate backUserCenter];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                        message:@"修改失败"
                                                                       delegate:self
                                                              cancelButtonTitle:MyLocalizedString(@"OK")
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
            }];
        }
        if (_status == 1) {
            [UserInfoModel eidtUserIntro:_textView.text block:^(int code) {
                if (code == 1) {
                    [_delegate backUserCenter];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                        message:@"修改失败"
                                                                       delegate:self
                                                              cancelButtonTitle:MyLocalizedString(@"OK")
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
            }];
        }
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:[NSString stringWithFormat:@"请输入新的%@",_statusStr]
                                                           delegate:self
                                                  cancelButtonTitle:MyLocalizedString(@"OK")
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark -- UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (_status == 1) {
        NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:_textView.text];
        if (_textView == textView)
        {
            if ([aString length] > 60) {
//                textView.text = [aString substringToIndex:30];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请输入少于30个字符"
                                                           delegate:nil
                                                  cancelButtonTitle:MyLocalizedString(@"OK")
                                                  otherButtonTitles:nil, nil];
                [alert show];
                return NO;
            }
        }
        return YES;
    }
    return YES;
}



@end
