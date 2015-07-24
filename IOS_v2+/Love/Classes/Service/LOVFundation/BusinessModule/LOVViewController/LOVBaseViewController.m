//
//  LOVBaseViewController.m
//  Love
//
//  Created by 李伟 on 14-7-8.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "LOVBaseViewController.h"


NSString * const LOVBaseControllerNoticeNavBack   =  @"LOVBaseControllerNoticeNavBack";
NSString * const LOVBaseControllerNoticeSwipeBack =  @"LOVBaseControllerNoticeSwipeBack";

@interface LOVBaseViewController ()

@end

@implementation LOVBaseViewController

- (id)init
{
    self = [super init];
    if (self) {
        //隐藏tabbar
        self.hidesBottomBarWhenPushed = YES;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorRGBWithRed:235.f green:235.f blue:235.f alpha:1];
    
    if (VersionNumber_iOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;//view在导航栏下方
    }
   
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 12, 20.f);
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setBackgroundImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButton;
    
    //-- 向右滑动返回上级页面
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRecognizer];
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:LOVBaseControllerNoticeNavBack object:nil];
}

- (void)backAction:(UISwipeGestureRecognizer *)recognizer
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:LOVBaseControllerNoticeSwipeBack object:nil];
}

@end
