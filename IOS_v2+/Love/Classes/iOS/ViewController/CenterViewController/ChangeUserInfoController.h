//
//  ChangeUserInfoController.h
//  Love
//
//  Created by use on 14-12-15.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//
//修改昵称以及签名页面

#import <UIKit/UIKit.h>
#import "CenterViewControllerDelegate.h"

@interface ChangeUserInfoController : LOVBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIView *line;

@property (nonatomic ,strong) NSString *statusStr;
@property (nonatomic ,assign) NSInteger status;

@property (nonatomic, weak) id<CenterViewControllerDelegate> delegate;

- (IBAction)sureButtonAction:(id)sender;

@end
